import 'package:flutter/material.dart';

import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/company_info.dart';
import '../../../core/widgets/editorial_image.dart';
import '../../../shared/widgets/page_intro.dart';
import '../../../shared/widgets/section.dart';
import '../../../shared/widgets/site_scaffold.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteScaffold(
      route: AppRoutes.about,
      navbarStartsTransparent: true,
      children: <Widget>[
        const PageIntro(
          eyebrow: 'ABOUT',
          title: 'More than leather.',
          lead:
              'New Leather srl is based in Montegranaro, in the Marche region '
              'of Italy \u2014 a territory long associated with leather and '
              'footwear manufacturing.',
        ),
        const Section(
          child: EditorialSplit(
            imageFirst: true,
            text: SectionHeading(
              eyebrow: AppStrings.introEyebrow,
              headline: AppStrings.introHeadline,
              body: AppStrings.introBody,
            ),
            image: EditorialImage(
              semanticLabel:
                  'Editorial portrait of leather in daylight, pending client asset',
              category: 'LEATHER \u2014 EDITORIAL',
            ),
          ),
        ),
        Section(
          background: AppColors.ivory,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              SectionHeading(
                eyebrow: 'WHERE WE ARE',
                headline: 'Montegranaro, Marche.',
                body:
                    'The company is registered at ${CompanyInfo.addressSingleLine}. '
                    'Details of history, structure and capabilities are kept '
                    'deliberately general here until confirmed by the client.',
              ),
              SizedBox(height: AppSpacing.xl),
              ConfirmationNote(
                text:
                    'Company history, size, capabilities, certifications and '
                    'partnerships: ${AppStrings.needsConfirmation}. No such '
                    'claims are made anywhere on this site until supplied.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
