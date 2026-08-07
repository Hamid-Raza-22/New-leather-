import 'package:flutter/material.dart';

import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/company_info.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/utils/launcher.dart';
import '../../../core/widgets/reveal_on_scroll.dart';
import '../../../shared/widgets/page_intro.dart';
import '../../../shared/widgets/premium_button.dart';
import '../../../shared/widgets/section.dart';
import '../../../shared/widgets/site_scaffold.dart';
import 'widgets/contact_form.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    return SiteScaffold(
      route: AppRoutes.contact,
      navbarStartsTransparent: true,
      children: <Widget>[
        const PageIntro(
          eyebrow: 'CONTACT',
          title: AppStrings.contactHeadline,
          lead:
              'Tell us about the material you are looking for, the context it '
              'is for, and how best to reach you.',
        ),
        Section(
          child: isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    _Details(),
                    SizedBox(height: AppSpacing.xxl),
                    RevealOnScroll(child: ContactForm()),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Expanded(flex: 4, child: _Details()),
                    SizedBox(width: AppSpacing.xxxl),
                    Expanded(
                      flex: 6,
                      child: RevealOnScroll(child: ContactForm()),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}

class _Details extends StatelessWidget {
  const _Details();

  @override
  Widget build(BuildContext context) {
    return RevealOnScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('NEW LEATHER SRL', style: AppTextStyles.eyebrow(context)),
          const SizedBox(height: AppSpacing.lg),
          Text(
            '${CompanyInfo.street}\n'
            '${CompanyInfo.postalCode} ${CompanyInfo.city}\n'
            '${CompanyInfo.country}',
            style: AppTextStyles.bodyLarge(context),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(CompanyInfo.email, style: AppTextStyles.bodyLarge(context)),
          const SizedBox(height: AppSpacing.xl),
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: <Widget>[
              PremiumButton(
                label: 'EMAIL NEW LEATHER',
                trailingArrow: true,
                onPressed: () => Launcher.email(CompanyInfo.emailUri),
              ),
              PremiumButton(
                label: 'VIEW LOCATION',
                variant: PremiumButtonVariant.outlineDark,
                onPressed: () => Launcher.open(CompanyInfo.mapsUrl),
              ),
              PremiumButton(
                label: 'INSTAGRAM',
                variant: PremiumButtonVariant.outlineDark,
                onPressed: () => Launcher.open(CompanyInfo.instagramUrl),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          const ConfirmationNote(
            text:
                'No telephone number is published here. '
                '${AppStrings.needsConfirmation}',
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Opening hours and direct contacts are published once confirmed.',
            style: AppTextStyles.bodySmall(context)
                .copyWith(color: AppColors.neutral500),
          ),
        ],
      ),
    );
  }
}
