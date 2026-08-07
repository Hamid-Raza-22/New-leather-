import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import '../../core/responsive/responsive.dart';
import '../../core/widgets/reveal_on_scroll.dart';

/// Dark masthead used at the top of every inner page, so the transparent
/// navbar always sits on a dark surface.
class PageIntro extends StatelessWidget {
  const PageIntro({
    super.key,
    required this.eyebrow,
    required this.title,
    this.lead,
  });

  final String eyebrow;
  final String title;
  final String? lead;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    final double titleSize = Responsive.value<double>(
      context,
      mobile: 40,
      tablet: 56,
      desktop: 76,
    );

    return ColoredBox(
      color: AppColors.black,
      child: Padding(
        padding: Responsive.pagePadding(context).copyWith(
          top: isMobile ? 120 : 200,
          bottom: isMobile ? 56 : 96,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppSpacing.maxContentWidth,
            ),
            child: RevealOnScroll(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(eyebrow, style: AppTextStyles.eyebrow(context)),
                  const SizedBox(height: AppSpacing.lg),
                  Semantics(
                    header: true,
                    child: Text(
                      title,
                      style: AppTextStyles.serif(
                        fontSize: titleSize,
                        color: AppColors.ivory,
                      ),
                    ),
                  ),
                  if (lead != null) ...<Widget>[
                    const SizedBox(height: AppSpacing.lg),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: AppSpacing.maxTextWidth,
                      ),
                      child: Text(
                        lead!,
                        style: AppTextStyles.bodyLarge(context)
                            .copyWith(color: AppColors.neutral300),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
