import 'package:flutter/material.dart';

import '../../app/routes/app_routes.dart';
import '../../app/theme/app_colors.dart';
import '../../core/responsive/responsive.dart';
import '../models/nav_item.dart';
import 'brand_wordmark.dart';
import 'nav_link.dart';

/// Transparent over the hero, solid once the page is scrolled.
class AppNavbar extends StatelessWidget {
  const AppNavbar({
    super.key,
    required this.solid,
    required this.currentRoute,
    required this.onNavigate,
    required this.onOpenMenu,
  });

  final bool solid;
  final String currentRoute;
  final ValueChanged<String> onNavigate;
  final VoidCallback onOpenMenu;

  static const double desktopHeight = 88;
  static const double mobileHeight = 68;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOut,
      height: isMobile ? mobileHeight : desktopHeight,
      color: solid ? AppColors.black : Colors.transparent,
      padding: Responsive.pagePadding(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          BrandWordmark(
            fontSize: isMobile ? 14 : 16,
            onTap: () => onNavigate(AppRoutes.home),
          ),
          if (isMobile)
            _MenuButton(onTap: onOpenMenu)
          else
            Row(
              children: <Widget>[
                for (final NavItem item in AppRoutes.primaryNav)
                  Padding(
                    padding: const EdgeInsets.only(left: 34),
                    child: NavLink(
                      label: item.label,
                      color: AppColors.ivory,
                      active: item.route == currentRoute,
                      onTap: () => onNavigate(item.route),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  const _MenuButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Open navigation menu',
      child: IconButton(
        onPressed: onTap,
        splashRadius: 22,
        icon: const Icon(Icons.menu, color: AppColors.ivory, size: 22),
        tooltip: 'Menu',
      ),
    );
  }
}
