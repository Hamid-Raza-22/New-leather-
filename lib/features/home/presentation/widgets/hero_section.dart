import 'package:flutter/material.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/widgets/editorial_image.dart';
import '../../../../shared/widgets/premium_button.dart';

/// Cinematic full-screen opener.
class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..forward();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Animation<double> _at(double start, double end) => CurvedAnimation(
        parent: _controller,
        curve: Interval(start, end, curve: Curves.easeOutCubic),
      );

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final bool isMobile = Responsive.isMobile(context);
    final double headlineSize = Responsive.value<double>(
      context,
      mobile: 44,
      tablet: 64,
      desktop: 92,
    );

    return SizedBox(
      height: size.height,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          const Hero(
            tag: 'hero-leather',
            child: EditorialImage(
              semanticLabel:
                  'Full-bleed image of leather, pending client asset delivery',
              category: 'HERO \u2014 LEATHER',
              dark: true,
            ),
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color(0xCC000000),
                  Color(0x66000000),
                  Color(0xE6000000),
                ],
                stops: <double>[0, 0.45, 1],
              ),
            ),
          ),
          Padding(
            padding: Responsive.pagePadding(context).copyWith(
              bottom: isMobile ? 72 : 96,
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: AppSpacing.maxContentWidth,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeTransition(
                      opacity: _at(0.05, 0.6),
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.25),
                          end: Offset.zero,
                        ).animate(_at(0.05, 0.75)),
                        child: Text(
                          AppStrings.heroHeadline,
                          style: AppTextStyles.serif(
                            fontSize: headlineSize,
                            color: AppColors.ivory,
                            height: 1.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    FadeTransition(
                      opacity: _at(0.3, 0.85),
                      child: Text(
                        AppStrings.heroSubline,
                        style: AppTextStyles.sans(
                          fontSize: isMobile ? 14 : 16,
                          letterSpacing: 3,
                          color: AppColors.neutral300,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    FadeTransition(
                      opacity: _at(0.5, 1),
                      child: Wrap(
                        spacing: AppSpacing.md,
                        runSpacing: AppSpacing.md,
                        children: <Widget>[
                          PremiumButton(
                            label: AppStrings.heroCtaPrimary,
                            variant: PremiumButtonVariant.solidLight,
                            trailingArrow: true,
                            onPressed: () => Navigator.of(context)
                                .pushNamed(AppRoutes.leather),
                          ),
                          PremiumButton(
                            label: AppStrings.heroCtaSecondary,
                            variant: PremiumButtonVariant.outlineLight,
                            onPressed: () => Navigator.of(context)
                                .pushNamed(AppRoutes.contact),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
