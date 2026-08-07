import 'package:flutter/material.dart';

import '../../app/routes/app_routes.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import '../../core/constants/company_info.dart';
import '../../core/responsive/responsive.dart';
import '../../core/utils/launcher.dart';
import '../models/nav_item.dart';
import 'brand_wordmark.dart';
import 'nav_link.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key, required this.onNavigate});

  final ValueChanged<String> onNavigate;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    return ColoredBox(
      color: AppColors.black,
      child: Padding(
        padding: Responsive.pagePadding(context).copyWith(
          top: isMobile ? 56 : 88,
          bottom: 32,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppSpacing.maxContentWidth,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (isMobile)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _BrandBlock(onNavigate: onNavigate),
                      const SizedBox(height: 40),
                      _NavBlock(onNavigate: onNavigate),
                      const SizedBox(height: 40),
                      const _ContactBlock(),
                    ],
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: _BrandBlock(onNavigate: onNavigate),
                      ),
                      const SizedBox(width: 48),
                      Expanded(flex: 3, child: _NavBlock(onNavigate: onNavigate)),
                      const SizedBox(width: 48),
                      const Expanded(flex: 3, child: _ContactBlock()),
                    ],
                  ),
                const SizedBox(height: 64),
                const Divider(color: AppColors.graphite),
                const SizedBox(height: 20),
                Text(
                  CompanyInfo.copyright(DateTime.now()),
                  style: AppTextStyles.sans(
                    fontSize: 12,
                    color: AppColors.neutral500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BrandBlock extends StatelessWidget {
  const _BrandBlock({required this.onNavigate});

  final ValueChanged<String> onNavigate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        BrandWordmark(onTap: () => onNavigate(AppRoutes.home)),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: Text(
            'Leather, considered. A material practice built on selection, '
            'experience and research.',
            style: AppTextStyles.body(context)
                .copyWith(color: AppColors.neutral300),
          ),
        ),
      ],
    );
  }
}

class _NavBlock extends StatelessWidget {
  const _NavBlock({required this.onNavigate});

  final ValueChanged<String> onNavigate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('NAVIGATION', style: AppTextStyles.eyebrow(context)),
        const SizedBox(height: 20),
        for (final NavItem item in AppRoutes.allPages)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: NavLink(
              label: item.label,
              color: AppColors.neutral300,
              onTap: () => onNavigate(item.route),
            ),
          ),
      ],
    );
  }
}

class _ContactBlock extends StatelessWidget {
  const _ContactBlock();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('CONTACT', style: AppTextStyles.eyebrow(context)),
        const SizedBox(height: 20),
        Text(
          '${CompanyInfo.legalName}\n${CompanyInfo.street}\n'
          '${CompanyInfo.postalCode} ${CompanyInfo.city}\n'
          '${CompanyInfo.country}',
          style: AppTextStyles.body(context)
              .copyWith(color: AppColors.neutral300),
        ),
        const SizedBox(height: 16),
        NavLink(
          label: CompanyInfo.email,
          color: AppColors.neutral300,
          fontSize: 14,
          onTap: () => Launcher.email(CompanyInfo.emailUri),
        ),
        const SizedBox(height: 10),
        NavLink(
          label: 'INSTAGRAM ${CompanyInfo.instagramHandle}',
          color: AppColors.neutral300,
          onTap: () => Launcher.open(CompanyInfo.instagramUrl),
        ),
      ],
    );
  }
}
