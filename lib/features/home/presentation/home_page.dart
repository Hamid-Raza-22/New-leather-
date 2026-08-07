import 'package:flutter/material.dart';

import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/site_scaffold.dart';
import 'widgets/contact_teaser.dart';
import 'widgets/hero_section.dart';
import 'widgets/intro_section.dart';
import 'widgets/material_section.dart';
import 'widgets/quality_section.dart';
import 'widgets/statement_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteScaffold(
      route: AppRoutes.home,
      navbarStartsTransparent: true,
      children: <Widget>[
        HeroSection(),
        IntroSection(),
        MaterialSection(),
        QualitySection(),
        StatementSection(
          eyebrow: AppStrings.researchEyebrow,
          headline: AppStrings.researchHeadline,
          body: AppStrings.researchBody,
          imageCategory: 'PROCESS \u2014 RESEARCH',
          imageSemantics:
              'Image representing material research, pending client asset',
          imageFirst: true,
        ),
        StatementSection(
          eyebrow: AppStrings.experienceEyebrow,
          headline: AppStrings.experienceHeadline,
          body: AppStrings.experienceBody,
          imageCategory: 'PROCESS \u2014 EXPERIENCE',
          imageSemantics:
              'Image representing hands-on leather experience, pending client asset',
          background: AppColors.ivory,
        ),
        ContactTeaser(),
      ],
    );
  }
}
