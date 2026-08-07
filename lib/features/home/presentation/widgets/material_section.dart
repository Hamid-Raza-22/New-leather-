import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/widgets/editorial_image.dart';
import '../../../../core/widgets/hover_reveal.dart';
import '../../../../core/widgets/reveal_on_scroll.dart';
import '../../../../shared/widgets/section.dart';

class MaterialSection extends StatelessWidget {
  const MaterialSection({super.key});

  static const List<(String, String)> _plates = <(String, String)>[
    ('TEXTURE', 'Close study of grain and surface'),
    ('COLOR', 'Tone and depth across a hide'),
    ('CHARACTER', 'How a material behaves over time'),
  ];

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    return Section(
      background: AppColors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SectionHeading(
            eyebrow: AppStrings.materialEyebrow,
            headline: AppStrings.materialHeadline,
            body: AppStrings.materialBody,
            dark: true,
          ),
          const SizedBox(height: AppSpacing.xxxl),
          if (isMobile)
            Column(
              children: <Widget>[
                for (final (String, String) plate in _plates)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.xl),
                    child: _Plate(title: plate.$1, caption: plate.$2),
                  ),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                for (int i = 0; i < _plates.length; i++) ...<Widget>[
                  if (i > 0) const SizedBox(width: AppSpacing.xl),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: i.isOdd ? 56 : 0),
                      child: _Plate(
                        title: _plates[i].$1,
                        caption: _plates[i].$2,
                        delayMs: i * 110,
                      ),
                    ),
                  ),
                ],
              ],
            ),
        ],
      ),
    );
  }
}

class _Plate extends StatelessWidget {
  const _Plate({
    required this.title,
    required this.caption,
    this.delayMs = 0,
  });

  final String title;
  final String caption;
  final int delayMs;

  @override
  Widget build(BuildContext context) {
    return RevealOnScroll(
      delay: Duration(milliseconds: delayMs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRect(
            child: HoverReveal(
              builder: (BuildContext context, bool hovered) => Stack(
                children: <Widget>[
                  EditorialImage(
                    aspectRatio: 3 / 4,
                    semanticLabel: '$title: $caption. Pending client asset.',
                    category: title,
                    dark: true,
                  ),
                  Positioned.fill(
                    child: AnimatedOpacity(
                      opacity: hovered ? 1 : 0,
                      duration: const Duration(milliseconds: 320),
                      child: const ColoredBox(color: AppColors.overlaySoft),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(title, style: _titleStyle(context)),
          const SizedBox(height: AppSpacing.xs),
          Text(caption, style: _captionStyle(context)),
        ],
      ),
    );
  }

  TextStyle _titleStyle(BuildContext context) => TextStyle(
        color: AppColors.ivory,
        fontSize: 13,
        letterSpacing: 2,
        fontWeight: FontWeight.w500,
        height: 1.2,
        fontFamily: DefaultTextStyle.of(context).style.fontFamily,
      );

  TextStyle _captionStyle(BuildContext context) => TextStyle(
        color: AppColors.neutral500,
        fontSize: 13,
        height: 1.5,
        fontFamily: DefaultTextStyle.of(context).style.fontFamily,
      );
}
