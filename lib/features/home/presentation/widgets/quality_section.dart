import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/widgets/reveal_on_scroll.dart';
import '../../../../shared/widgets/section.dart';

/// Selection / Texture / Color / Finish / Detail, presented as the lenses used
/// to look at leather rather than as a described production process.
class QualitySection extends StatelessWidget {
  const QualitySection({super.key});

  static const List<(String, String)> _lenses = <(String, String)>[
    ('SELECTION', 'What is chosen, and what is set aside.'),
    ('TEXTURE', 'Grain and hand, read by touch.'),
    ('COLOR', 'Tone, depth and how light sits on a surface.'),
    ('FINISH', 'The final surface, and how it is presented.'),
    ('DETAIL', 'The small decisions that carry the whole.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Section(
      background: AppColors.ivory,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SectionHeading(
            eyebrow: AppStrings.qualityEyebrow,
            headline: AppStrings.qualityHeadline,
            body: AppStrings.qualityBody,
          ),
          const SizedBox(height: AppSpacing.xxl),
          for (int i = 0; i < _lenses.length; i++)
            RevealOnScroll(
              delay: Duration(milliseconds: i * 70),
              child: _LensRow(
                index: i + 1,
                title: _lenses[i].$1,
                description: _lenses[i].$2,
              ),
            ),
        ],
      ),
    );
  }
}

class _LensRow extends StatelessWidget {
  const _LensRow({
    required this.index,
    required this.title,
    required this.description,
  });

  final int index;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    return Semantics(
      label: '$title. $description',
      child: ExcludeSemantics(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: isMobile ? 20 : 28),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: AppColors.neutral100),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: isMobile ? 40 : 80,
                child: Text(
                  index.toString().padLeft(2, '0'),
                  style: AppTextStyles.sans(
                    fontSize: 12,
                    color: AppColors.neutral300,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: AppTextStyles.serif(
                    fontSize: isMobile ? 24 : 32,
                    letterSpacing: 0,
                  ),
                ),
              ),
              if (!isMobile)
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      description,
                      style: AppTextStyles.body(context),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
