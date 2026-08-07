import 'package:flutter/material.dart';

import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/page_intro.dart';
import '../../../shared/widgets/section.dart';
import '../../../shared/widgets/site_scaffold.dart';

/// No names, roles, portraits or biographies are invented. The page provides
/// the layout; the client supplies verified people and imagery.
class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteScaffold(
      route: AppRoutes.team,
      navbarStartsTransparent: true,
      children: <Widget>[
        PageIntro(
          eyebrow: 'TEAM',
          title: 'The people behind\nthe material.',
          lead:
              'Leather is judged by people. This page is reserved for the '
              'people of New Leather srl.',
        ),
        Section(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SectionHeading(
                eyebrow: 'STATUS',
                headline: 'Reserved for verified people.',
                body:
                    'No names, positions, portraits or biographies appear here '
                    'until the client supplies them, together with permission '
                    'to publish the imagery.',
              ),
              SizedBox(height: AppSpacing.xl),
              ConfirmationNote(
                text:
                    'Team names, roles, portraits and image rights: '
                    '${AppStrings.needsConfirmation}',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
