import 'package:flutter/material.dart';

import '../../app/routes/app_routes.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../core/constants/company_info.dart';
import '../../core/utils/launcher.dart';
import '../models/nav_item.dart';
import 'brand_wordmark.dart';

/// Fullscreen mobile navigation with a staggered reveal.
class MobileMenu extends StatefulWidget {
  const MobileMenu({
    super.key,
    required this.currentRoute,
    required this.onNavigate,
    required this.onClose,
  });

  final String currentRoute;
  final ValueChanged<String> onNavigate;
  final VoidCallback onClose;

  @override
  State<MobileMenu> createState() => _MobileMenuState();
}

class _MobileMenuState extends State<MobileMenu>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 520),
  )..forward();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Animation<double> _staggered(int index, int total) {
    final double start = (index / (total + 2)).clamp(0.0, 0.8);
    return CurvedAnimation(
      parent: _controller,
      curve: Interval(start, (start + 0.45).clamp(0.0, 1.0),
          curve: Curves.easeOutCubic),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<NavItem> items = AppRoutes.allPages;

    return Semantics(
      scopesRoute: true,
      explicitChildNodes: true,
      label: 'Navigation menu',
      child: FadeTransition(
        opacity: CurvedAnimation(
          parent: _controller,
          curve: const Interval(0, 0.4),
        ),
        child: ColoredBox(
          color: AppColors.black,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 8, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const BrandWordmark(fontSize: 14),
                      IconButton(
                        onPressed: widget.onClose,
                        icon: const Icon(Icons.close,
                            color: AppColors.ivory, size: 22),
                        tooltip: 'Close menu',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      final NavItem item = items[index];
                      final Animation<double> animation =
                          _staggered(index, items.length);
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.35),
                            end: Offset.zero,
                          ).animate(animation),
                          child: _MenuEntry(
                            item: item,
                            active: item.route == widget.currentRoute,
                            onTap: () => widget.onNavigate(item.route),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Divider(color: AppColors.graphite),
                      const SizedBox(height: 18),
                      GestureDetector(
                        onTap: () => Launcher.email(CompanyInfo.emailUri),
                        child: Text(
                          CompanyInfo.email,
                          style: AppTextStyles.body(context)
                              .copyWith(color: AppColors.neutral300),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        CompanyInfo.addressSingleLine,
                        style: AppTextStyles.bodySmall(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuEntry extends StatelessWidget {
  const _MenuEntry({
    required this.item,
    required this.active,
    required this.onTap,
  });

  final NavItem item;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      link: true,
      selected: active,
      label: item.label,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            item.label,
            style: AppTextStyles.serif(
              fontSize: 34,
              color: active ? AppColors.tan : AppColors.ivory,
              letterSpacing: 0,
            ),
          ),
        ),
      ),
    );
  }
}
