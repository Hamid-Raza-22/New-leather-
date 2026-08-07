import 'package:flutter/material.dart';

import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/editorial_image.dart';
import '../../../shared/widgets/page_intro.dart';
import '../../../shared/widgets/section.dart';
import '../../../shared/widgets/site_scaffold.dart';

class ExpertisePage extends StatelessWidget {
  const ExpertisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteScaffold(
      route: AppRoutes.expertise,
      navbarStartsTransparent: true,
      children: <Widget>[
        PageIntro(
          eyebrow: 'EXPERTISE',
          title: 'Experience matters.',
          lead: AppStrings.experienceBody,
        ),
        Section(
          child: EditorialSplit(
            text: SectionHeading(
              eyebrow: AppStrings.researchEyebrow,
              headline: AppStrings.researchHeadline,
              body: AppStrings.researchBody,
            ),
            image: EditorialImage(
              semanticLabel:
                  'Image representing material research, pending client asset',
              category: 'PROCESS \u2014 RESEARCH',
            ),
          ),
        ),
        Section(
          background: AppColors.ivory,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SectionHeading(
                eyebrow: 'QUALITY',
                headline: 'Quality is in the detail.',
                body: AppStrings.qualityBody,
              ),
              SizedBox(height: AppSpacing.xl),
              ConfirmationNote(
                text:
                    'Years of activity, certifications, machinery, capacity, '
                    'client names and processes: ${AppStrings.needsConfirmation}. '
                    'None are stated on this site.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
