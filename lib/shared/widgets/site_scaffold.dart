import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app/routes/app_routes.dart';
import '../../app/theme/app_colors.dart';
import '../../core/responsive/responsive.dart';
import '../../core/utils/document_title.dart';
import 'app_footer.dart';
import 'app_navbar.dart';
import 'mobile_menu.dart';

/// Shared page shell: scroll-aware navbar, fullscreen mobile menu, footer.
class SiteScaffold extends StatefulWidget {
  const SiteScaffold({
    super.key,
    required this.route,
    required this.children,
    this.navbarStartsTransparent = false,
    this.backgroundColor = AppColors.warmWhite,
  });

  final String route;
  final List<Widget> children;

  /// True on pages that open with a full-bleed dark hero.
  final bool navbarStartsTransparent;
  final Color backgroundColor;

  @override
  State<SiteScaffold> createState() => _SiteScaffoldState();
}

class _SiteScaffoldState extends State<SiteScaffold> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _navSolid = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _menuOpen = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _navSolid.value = !widget.navbarStartsTransparent;
    _scrollController.addListener(_onScroll);
    DocumentTitle.set(AppRoutes.titles[widget.route] ?? '');
  }

  void _onScroll() {
    if (!widget.navbarStartsTransparent) return;
    final bool solid = _scrollController.offset > 60;
    if (solid != _navSolid.value) _navSolid.value = solid;
  }

  void _navigate(String route) {
    _menuOpen.value = false;
    if (route == widget.route) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
      );
      return;
    }
    Navigator.of(context).pushNamed(route);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _navSolid.dispose();
    _menuOpen.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double topInset = widget.navbarStartsTransparent
        ? 0
        : (Responsive.isMobile(context)
            ? AppNavbar.mobileHeight
            : AppNavbar.desktopHeight);

    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Scrollbar(
              controller: _scrollController,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: topInset),
                    ...widget.children,
                    AppFooter(onNavigate: _navigate),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ValueListenableBuilder<bool>(
              valueListenable: _navSolid,
              builder: (BuildContext context, bool solid, _) => AppNavbar(
                solid: solid,
                currentRoute: widget.route,
                onNavigate: _navigate,
                onOpenMenu: () => _menuOpen.value = true,
              ),
            ),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: _menuOpen,
            builder: (BuildContext context, bool open, _) {
              if (!open) return const SizedBox.shrink();
              return Positioned.fill(
                child: CallbackShortcuts(
                  bindings: <ShortcutActivator, VoidCallback>{
                    const SingleActivator(LogicalKeyboardKey.escape): () =>
                        _menuOpen.value = false,
                  },
                  child: FocusScope(
                    autofocus: true,
                    child: MobileMenu(
                      currentRoute: widget.route,
                      onNavigate: _navigate,
                      onClose: () => _menuOpen.value = false,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
