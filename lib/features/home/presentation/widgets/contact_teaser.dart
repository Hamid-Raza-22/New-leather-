import 'package:flutter/material.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../shared/widgets/premium_button.dart';
import '../../../../shared/widgets/section.dart';

class ContactTeaser extends StatelessWidget {
  const ContactTeaser({super.key});

  @override
  Widget build(BuildContext context) {
    return Section(
      background: AppColors.charcoal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SectionHeading(
            eyebrow: 'CONTACT',
            headline: AppStrings.contactHeadline,
            body: 'Tell us what you are working on and we will come back to you.',
            dark: true,
          ),
          const SizedBox(height: AppSpacing.xl),
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: <Widget>[
              PremiumButton(
                label: 'SEND AN INQUIRY',
                variant: PremiumButtonVariant.solidLight,
                trailingArrow: true,
                onPressed: () =>
                    Navigator.of(context).pushNamed(AppRoutes.contact),
              ),
              PremiumButton(
                label: 'EXPLORE THE GALLERY',
                variant: PremiumButtonVariant.outlineLight,
                onPressed: () =>
                    Navigator.of(context).pushNamed(AppRoutes.gallery),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
