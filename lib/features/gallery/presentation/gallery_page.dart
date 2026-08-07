import 'package:flutter/material.dart';

import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/widgets/editorial_image.dart';
import '../../../core/widgets/hover_reveal.dart';
import '../../../core/widgets/reveal_on_scroll.dart';
import '../../../shared/models/gallery_item.dart';
import '../../../shared/widgets/page_intro.dart';
import '../../../shared/widgets/section.dart';
import '../../../shared/widgets/site_scaffold.dart';
import 'gallery_data.dart';
import 'widgets/category_filter.dart';
import 'widgets/gallery_viewer.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final ValueNotifier<GalleryCategory?> _category =
      ValueNotifier<GalleryCategory?>(null);

  @override
  void dispose() {
    _category.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SiteScaffold(
      route: AppRoutes.gallery,
      navbarStartsTransparent: true,
      backgroundColor: AppColors.black,
      children: <Widget>[
        const PageIntro(
          eyebrow: 'GALLERY',
          title: 'The material,\nseen closely.',
          lead:
              'Filter by category. Select an image to open it full screen; use '
              'the arrow keys or swipe to move between images.',
        ),
        Section(
          background: AppColors.black,
          topSpacing: 0,
          child: ValueListenableBuilder<GalleryCategory?>(
            valueListenable: _category,
            builder: (BuildContext context, GalleryCategory? selected, _) {
              final List<GalleryItem> visible = selected == null
                  ? GalleryData.items
                  : GalleryData.items
                      .where((GalleryItem i) => i.category == selected)
                      .toList(growable: false);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CategoryFilter(
                    selected: selected,
                    onChanged: (GalleryCategory? value) =>
                        _category.value = value,
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  if (visible.isEmpty)
                    Text(
                      'No images in this category yet.',
                      style: AppTextStyles.body(context)
                          .copyWith(color: AppColors.neutral500),
                    )
                  else
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: visible.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: Responsive.gridColumns(context),
                        crossAxisSpacing: AppSpacing.md,
                        mainAxisSpacing: AppSpacing.md,
                        childAspectRatio: 3 / 4,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return RevealOnScroll(
                          delay: Duration(milliseconds: (index % 6) * 70),
                          child: _GalleryTile(
                            item: visible[index],
                            onTap: () => GalleryViewer.open(
                              context,
                              items: visible,
                              initialIndex: index,
                            ),
                          ),
                        );
                      },
                    ),
                  const SizedBox(height: AppSpacing.xxl),
                  const ConfirmationNote(
                    dark: true,
                    text:
                        'Gallery images are layout slots until the client '
                        'supplies photography. Event and team imagery in '
                        'particular: ${AppStrings.needsConfirmation}',
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _GalleryTile extends StatelessWidget {
  const _GalleryTile({required this.item, required this.onTap});

  final GalleryItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '${item.title}. ${item.altText}. Open full screen.',
      child: ExcludeSemantics(
        child: FocusableActionDetector(
          actions: <Type, Action<Intent>>{
            ActivateIntent: CallbackAction<ActivateIntent>(
              onInvoke: (_) {
                onTap();
                return null;
              },
            ),
          },
          child: ClipRect(
            child: HoverReveal(
              onTap: onTap,
              builder: (BuildContext context, bool hovered) => Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Hero(
                    tag: 'gallery-${item.id}',
                    child: EditorialImage(
                      assetPath: item.assetPath,
                      semanticLabel: item.altText,
                      category: item.category.label,
                      dark: true,
                    ),
                  ),
                  Positioned.fill(
                    child: AnimatedOpacity(
                      opacity: hovered ? 1 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: const ColoredBox(color: AppColors.overlayDark),
                    ),
                  ),
                  Positioned(
                    left: AppSpacing.md,
                    right: AppSpacing.md,
                    bottom: AppSpacing.md,
                    child: AnimatedOpacity(
                      opacity: hovered ? 1 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        item.title,
                        style: AppTextStyles.sans(
                          fontSize: 13,
                          color: AppColors.ivory,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
