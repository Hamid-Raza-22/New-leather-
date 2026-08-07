import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/editorial_image.dart';
import '../../../../shared/widgets/section.dart';

/// Reusable editorial statement block used for Research and Experience.
class StatementSection extends StatelessWidget {
  const StatementSection({
    super.key,
    required this.eyebrow,
    required this.headline,
    required this.body,
    required this.imageCategory,
    required this.imageSemantics,
    this.imageFirst = false,
    this.background = AppColors.warmWhite,
    this.dark = false,
  });

  final String eyebrow;
  final String headline;
  final String body;
  final String imageCategory;
  final String imageSemantics;
  final bool imageFirst;
  final Color background;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Section(
      background: background,
      child: EditorialSplit(
        imageFirst: imageFirst,
        imageAspectRatio: 5 / 4,
        text: SectionHeading(
          eyebrow: eyebrow,
          headline: headline,
          body: body,
          dark: dark,
        ),
        image: EditorialImage(
          semanticLabel: imageSemantics,
          category: imageCategory,
          dark: dark,
        ),
      ),
    );
  }
}
