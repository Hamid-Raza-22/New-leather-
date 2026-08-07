import 'package:flutter/material.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/editorial_image.dart';
import '../../../../core/widgets/hover_reveal.dart';
import '../../../../core/widgets/reveal_on_scroll.dart';
import '../../../../shared/widgets/premium_button.dart';
import '../../../../shared/widgets/section.dart';

class IntroSection extends StatelessWidget {
  const IntroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Section(
      child: EditorialSplit(
        textFlex: 5,
        imageFlex: 7,
        imageAspectRatio: 4 / 5,
        text: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SectionHeading(
              eyebrow: AppStrings.introEyebrow,
              headline: AppStrings.introHeadline,
              body: AppStrings.introBody,
            ),
            const SizedBox(height: AppSpacing.xl),
            RevealOnScroll(
              delay: const Duration(milliseconds: 120),
              child: PremiumButton(
                label: 'ABOUT NEW LEATHER',
                variant: PremiumButtonVariant.outlineDark,
                trailingArrow: true,
                onPressed: () =>
                    Navigator.of(context).pushNamed(AppRoutes.about),
              ),
            ),
          ],
        ),
        image: RevealOnScroll(
          delay: const Duration(milliseconds: 80),
          child: ClipRect(
            child: HoverReveal(
              builder: (BuildContext context, bool hovered) =>
                  const EditorialImage(
                semanticLabel:
                    'Editorial image of leather in the workshop, pending client asset',
                category: 'LEATHER \u2014 EDITORIAL',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
