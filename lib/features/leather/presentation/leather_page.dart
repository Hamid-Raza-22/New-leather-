import 'package:flutter/material.dart';

import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/widgets/editorial_image.dart';
import '../../../core/widgets/hover_reveal.dart';
import '../../../core/widgets/reveal_on_scroll.dart';
import '../../../shared/widgets/page_intro.dart';
import '../../../shared/widgets/premium_button.dart';
import '../../../shared/widgets/section.dart';
import '../../../shared/widgets/site_scaffold.dart';

class LeatherPage extends StatelessWidget {
  const LeatherPage({super.key});

  static const List<(String, String)> _readings = <(String, String)>[
    ('TEXTURE', 'Surface and grain, read by hand before the eye.'),
    ('COLOR', 'Tone and depth, judged in daylight.'),
    ('CHARACTER', 'How a hide behaves, marks and settles.'),
    ('DETAIL', 'The edge, the fold, the small decisions.'),
  ];

  @override
  Widget build(BuildContext context) {
    return SiteScaffold(
      route: AppRoutes.leather,
      navbarStartsTransparent: true,
      children: <Widget>[
        const PageIntro(
          eyebrow: 'THE MATERIAL',
          title: 'Texture. Color.\nCharacter.',
          lead: AppStrings.materialBody,
        ),
        Section(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SectionHeading(
                eyebrow: 'HOW WE LOOK AT LEATHER',
                headline: 'Four readings of a hide.',
              ),
              const SizedBox(height: AppSpacing.xxl),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _readings.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: Responsive.isMobile(context) ? 1 : 2,
                  crossAxisSpacing: AppSpacing.xl,
                  mainAxisSpacing: AppSpacing.xl,
                  childAspectRatio: Responsive.isMobile(context) ? 0.9 : 1.05,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final (String, String) reading = _readings[index];
                  return RevealOnScroll(
                    delay: Duration(milliseconds: index * 90),
                    child: _ReadingTile(
                      title: reading.$1,
                      caption: reading.$2,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Section(
          background: AppColors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SectionHeading(
                eyebrow: AppStrings.qualityEyebrow,
                headline: AppStrings.qualityHeadline,
                body: AppStrings.qualityBody,
                dark: true,
              ),
              const SizedBox(height: AppSpacing.xl),
              const ConfirmationNote(
                dark: true,
                text:
                    'Specific leather types, tanning methods, finishes and '
                    'technical specifications: ${AppStrings.needsConfirmation}.',
              ),
              const SizedBox(height: AppSpacing.xl),
              PremiumButton(
                label: 'EXPLORE COLLECTION',
                variant: PremiumButtonVariant.solidLight,
                trailingArrow: true,
                onPressed: () =>
                    Navigator.of(context).pushNamed(AppRoutes.gallery),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ReadingTile extends StatelessWidget {
  const _ReadingTile({required this.title, required this.caption});

  final String title;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$title. $caption',
      child: ExcludeSemantics(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ClipRect(
                child: HoverReveal(
                  builder: (BuildContext context, bool hovered) => Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      EditorialImage(
                        semanticLabel: title,
                        category: title,
                      ),
                      Positioned.fill(
                        child: AnimatedOpacity(
                          opacity: hovered ? 1 : 0,
                          duration: const Duration(milliseconds: 320),
                          child: const ColoredBox(color: AppColors.overlaySoft),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(title, style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: AppSpacing.xxs),
            Text(caption, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
