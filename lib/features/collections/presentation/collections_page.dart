import 'package:flutter/material.dart';

import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/page_intro.dart';
import '../../../shared/widgets/section.dart';
import '../../../shared/widgets/site_scaffold.dart';

/// VALDARNO is intentionally not presented as a New Leather collection or
/// brand. Public sources associate the name with a separate Tuscan tannery,
/// so no relationship is asserted here. See `docs/instagram-audit.md`.
class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteScaffold(
      route: AppRoutes.collections,
      navbarStartsTransparent: true,
      children: <Widget>[
        PageIntro(
          eyebrow: 'COLLECTIONS',
          title: 'Collections.',
          lead:
              'This page is prepared as a structure. Collection names, seasons '
              'and imagery are added once supplied and confirmed by the client.',
        ),
        Section(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SectionHeading(
                eyebrow: 'STATUS',
                headline: 'Awaiting confirmed material.',
                body:
                    'No collection is described here without confirmation. '
                    'Naming, ownership and season structure are decisions for '
                    'the client, not assumptions for the website.',
              ),
              SizedBox(height: AppSpacing.xl),
              ConfirmationNote(
                text:
                    'VALDARNO: publicly the name is associated with a separate '
                    'Italian tannery (I.P. Valdarno International S.p.A.). No '
                    'relationship with New Leather srl has been verified, so no '
                    'claim of ownership, partnership or supply is made. '
                    '${AppStrings.needsConfirmation}',
              ),
              SizedBox(height: AppSpacing.md),
              ConfirmationNote(
                text:
                    'Collection names, seasons, articles and imagery: '
                    '${AppStrings.needsConfirmation}',
              ),
            ],
          ),
        ),
        Section(
          background: AppColors.ivory,
          topSpacing: 0,
          child: SizedBox.shrink(),
        ),
      ],
    );
  }
}
