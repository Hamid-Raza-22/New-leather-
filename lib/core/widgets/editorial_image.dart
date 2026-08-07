import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';

/// Renders a client-supplied image when one is available.
///
/// While assets are pending, a clearly marked placeholder is drawn instead of
/// third-party stock imagery, so nothing on the site misrepresents the brand.
class EditorialImage extends StatelessWidget {
  const EditorialImage({
    super.key,
    this.assetPath,
    required this.semanticLabel,
    this.aspectRatio,
    this.category,
    this.dark = false,
    this.fit = BoxFit.cover,
  });

  final String? assetPath;
  final String semanticLabel;
  final double? aspectRatio;
  final String? category;
  final bool dark;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final Widget content = assetPath == null
        ? _Placeholder(label: category ?? semanticLabel, dark: dark)
        : Image.asset(
            assetPath!,
            fit: fit,
            semanticLabel: semanticLabel,
            errorBuilder: (_, __, ___) =>
                _Placeholder(label: category ?? semanticLabel, dark: dark),
          );

    final Widget sized = aspectRatio == null
        ? SizedBox.expand(child: content)
        : AspectRatio(aspectRatio: aspectRatio!, child: content);

    return Semantics(
      image: true,
      label: semanticLabel,
      child: ExcludeSemantics(child: sized),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.label, required this.dark});

  final String label;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    final Color background = dark ? AppColors.charcoal : AppColors.bone;
    final Color foreground = dark ? AppColors.neutral500 : AppColors.neutral500;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        border: Border.all(color: foreground.withValues(alpha: 0.25)),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                label.toUpperCase(),
                textAlign: TextAlign.center,
                style: AppTextStyles.eyebrow(context).copyWith(
                  color: foreground,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'CLIENT IMAGE ASSET REQUIRED',
                textAlign: TextAlign.center,
                style: AppTextStyles.sans(
                  fontSize: 10,
                  letterSpacing: 1.6,
                  color: foreground.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
