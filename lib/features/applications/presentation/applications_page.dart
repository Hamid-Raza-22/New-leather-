import 'package:flutter/material.dart';

import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/widgets/editorial_image.dart';
import '../../../core/widgets/reveal_on_scroll.dart';
import '../../../shared/widgets/page_intro.dart';
import '../../../shared/widgets/section.dart';
import '../../../shared/widgets/site_scaffold.dart';

/// Applications are presented as contexts leather is used in, not as claims
/// that New Leather manufactures finished garments or goods.
class ApplicationsPage extends StatelessWidget {
  const ApplicationsPage({super.key});

  static const List<(String, String)> _applications = <(String, String)>[
    ('FASHION', 'Leather for contemporary fashion and applications.'),
    ('APPAREL', 'Material considered for apparel contexts.'),
    ('LEATHER GOODS', 'Material considered for leather goods.'),
    ('ACCESSORIES', 'Material considered for accessories.'),
  ];

  @override
  Widget build(BuildContext context) {
    return SiteScaffold(
      route: AppRoutes.applications,
      navbarStartsTransparent: true,
      children: <Widget>[
        const PageIntro(
          eyebrow: 'APPLICATIONS',
          title: 'Leather for contemporary\nfashion and applications.',
          lead:
              'The categories below describe the contexts leather is used in. '
              'They are not statements about finished products made by New Leather.',
        ),
        Section(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _applications.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: Responsive.isMobile(context) ? 1 : 2,
                  crossAxisSpacing: AppSpacing.xl,
                  mainAxisSpacing: AppSpacing.xl,
                  childAspectRatio: Responsive.isMobile(context) ? 1.1 : 1.4,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final (String, String) app = _applications[index];
                  return RevealOnScroll(
                    delay: Duration(milliseconds: index * 90),
                    child: _ApplicationTile(
                      title: app.$1,
                      caption: app.$2,
                    ),
                  );
                },
              ),
              const SizedBox(height: AppSpacing.xxl),
              const ConfirmationNote(
                text:
                    'Whether New Leather supplies, represents or produces for '
                    'any of these categories: ${AppStrings.needsConfirmation}.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ApplicationTile extends StatelessWidget {
  const _ApplicationTile({required this.title, required this.caption});

  final String title;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$title. $caption',
      child: ExcludeSemantics(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            EditorialImage(
              semanticLabel: title,
              category: title,
              dark: true,
            ),
            const Positioned.fill(
              child: ColoredBox(color: AppColors.overlaySoft),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: AppColors.ivory),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      caption,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: AppColors.neutral300),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
