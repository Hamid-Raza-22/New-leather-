import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../core/constants/app_assets.dart';

/// Typographic wordmark.
///
/// CLIENT LOGO ASSET REQUIRED: once an official logo file is supplied it can be
/// dropped into `assets/images/brand/` and referenced from [AppAssets.logo];
/// this widget then renders the real mark instead.
class BrandWordmark extends StatelessWidget {
  const BrandWordmark({
    super.key,
    this.color = AppColors.ivory,
    this.fontSize = 16,
    this.onTap,
  });

  final Color color;
  final double fontSize;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    const String? logo = AppAssets.logo;

    final Widget mark = logo == null
        ? Text(
            'NEW LEATHER',
            style: AppTextStyles.logo(context)
                .copyWith(color: color, fontSize: fontSize),
          )
        : Image.asset(
            logo,
            height: fontSize * 1.6,
            color: color,
            semanticLabel: 'New Leather',
          );

    final Widget semantic = Semantics(
      header: true,
      label: 'New Leather home',
      button: onTap != null,
      child: ExcludeSemantics(child: mark),
    );

    if (onTap == null) return semantic;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(onTap: onTap, child: semantic),
    );
  }
}
