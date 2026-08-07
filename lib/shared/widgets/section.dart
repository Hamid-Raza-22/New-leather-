import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import '../../core/responsive/responsive.dart';
import '../../core/widgets/reveal_on_scroll.dart';

/// Standard section wrapper: page gutters, max width, vertical rhythm.
class Section extends StatelessWidget {
  const Section({
    super.key,
    required this.child,
    this.background = AppColors.warmWhite,
    this.topSpacing,
    this.bottomSpacing,
    this.maxWidth = AppSpacing.maxContentWidth,
  });

  final Widget child;
  final Color background;
  final double? topSpacing;
  final double? bottomSpacing;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final double spacing = Responsive.sectionSpacing(context);

    return ColoredBox(
      color: background,
      child: Padding(
        padding: Responsive.pagePadding(context).copyWith(
          top: topSpacing ?? spacing,
          bottom: bottomSpacing ?? spacing,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Eyebrow + serif headline + optional body copy.
class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    this.eyebrow,
    required this.headline,
    this.body,
    this.dark = false,
    this.alignment = CrossAxisAlignment.start,
    this.maxBodyWidth = AppSpacing.maxTextWidth,
  });

  final String? eyebrow;
  final String headline;
  final String? body;
  final bool dark;
  final CrossAxisAlignment alignment;
  final double maxBodyWidth;

  @override
  Widget build(BuildContext context) {
    final Color headlineColor = dark ? AppColors.ivory : AppColors.charcoal;
    final Color bodyColor = dark ? AppColors.neutral300 : AppColors.neutral700;
    final double headlineSize = Responsive.value<double>(
      context,
      mobile: 34,
      tablet: 44,
      desktop: 52,
    );

    return RevealOnScroll(
      child: Column(
        crossAxisAlignment: alignment,
        children: <Widget>[
          if (eyebrow != null) ...<Widget>[
            Semantics(
              header: true,
              child: Text(
                eyebrow!,
                style: AppTextStyles.eyebrow(context).copyWith(
                  color: dark ? AppColors.neutral300 : AppColors.neutral500,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
          Text(
            headline,
            style: AppTextStyles.serif(
              fontSize: headlineSize,
              color: headlineColor,
            ),
          ),
          if (body != null) ...<Widget>[
            const SizedBox(height: AppSpacing.lg),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxBodyWidth),
              child: Text(
                body!,
                style: AppTextStyles.bodyLarge(context)
                    .copyWith(color: bodyColor),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Asymmetrical text/image pair that stacks on mobile.
class EditorialSplit extends StatelessWidget {
  const EditorialSplit({
    super.key,
    required this.text,
    required this.image,
    this.imageFirst = false,
    this.textFlex = 4,
    this.imageFlex = 6,
    this.imageAspectRatio = 3 / 4,
  });

  final Widget text;
  final Widget image;
  final bool imageFirst;
  final int textFlex;
  final int imageFlex;
  final double imageAspectRatio;

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (imageFirst) ...<Widget>[
            AspectRatio(aspectRatio: 4 / 5, child: image),
            const SizedBox(height: AppSpacing.xxl),
            text,
          ] else ...<Widget>[
            text,
            const SizedBox(height: AppSpacing.xxl),
            AspectRatio(aspectRatio: 4 / 5, child: image),
          ],
        ],
      );
    }

    final Widget textPane = Expanded(flex: textFlex, child: text);
    final Widget imagePane = Expanded(
      flex: imageFlex,
      child: AspectRatio(aspectRatio: imageAspectRatio, child: image),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        if (imageFirst) ...<Widget>[
          imagePane,
          const SizedBox(width: AppSpacing.xxxl),
          textPane,
        ] else ...<Widget>[
          textPane,
          const SizedBox(width: AppSpacing.xxxl),
          imagePane,
        ],
      ],
    );
  }
}

/// Small note used wherever a factual claim needs client sign-off.
class ConfirmationNote extends StatelessWidget {
  const ConfirmationNote({super.key, required this.text, this.dark = false});

  final String text;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: dark ? AppColors.graphite : AppColors.neutral100,
        ),
      ),
      child: Text(
        text,
        style: AppTextStyles.sans(
          fontSize: 12,
          letterSpacing: 0.4,
          color: dark ? AppColors.neutral300 : AppColors.neutral500,
        ),
      ),
    );
  }
}
