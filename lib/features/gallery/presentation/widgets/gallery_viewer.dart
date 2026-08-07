import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/editorial_image.dart';
import '../../../../shared/models/gallery_item.dart';

/// Fullscreen viewer. Swipe on touch, arrow keys and Escape on desktop.
class GalleryViewer extends StatefulWidget {
  const GalleryViewer({
    super.key,
    required this.items,
    required this.initialIndex,
  });

  final List<GalleryItem> items;
  final int initialIndex;

  static Future<void> open(
    BuildContext context, {
    required List<GalleryItem> items,
    required int initialIndex,
  }) {
    return Navigator.of(context).push<void>(
      PageRouteBuilder<void>(
        opaque: false,
        barrierColor: AppColors.black,
        transitionDuration: const Duration(milliseconds: 260),
        pageBuilder: (_, __, ___) =>
            GalleryViewer(items: items, initialIndex: initialIndex),
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  State<GalleryViewer> createState() => _GalleryViewerState();
}

class _GalleryViewerState extends State<GalleryViewer> {
  late final PageController _controller =
      PageController(initialPage: widget.initialIndex);
  late int _index = widget.initialIndex;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _step(int delta) {
    final int next = (_index + delta).clamp(0, widget.items.length - 1);
    if (next == _index) return;
    _controller.animateToPage(
      next,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final GalleryItem current = widget.items[_index];

    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        const SingleActivator(LogicalKeyboardKey.escape): () =>
            Navigator.of(context).maybePop(),
        const SingleActivator(LogicalKeyboardKey.arrowLeft): () => _step(-1),
        const SingleActivator(LogicalKeyboardKey.arrowRight): () => _step(1),
      },
      child: FocusScope(
        autofocus: true,
        child: Scaffold(
          backgroundColor: AppColors.black,
          body: Stack(
            children: <Widget>[
              PageView.builder(
                controller: _controller,
                itemCount: widget.items.length,
                onPageChanged: (int index) => setState(() => _index = index),
                itemBuilder: (BuildContext context, int index) {
                  final GalleryItem item = widget.items[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(24, 96, 24, 96),
                    child: Center(
                      child: Hero(
                        tag: 'gallery-${item.id}',
                        child: EditorialImage(
                          assetPath: item.assetPath,
                          semanticLabel: item.altText,
                          category: item.category.label,
                          aspectRatio: 3 / 2,
                          fit: BoxFit.contain,
                          dark: true,
                        ),
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                top: 24,
                right: 16,
                child: IconButton(
                  tooltip: 'Close',
                  onPressed: () => Navigator.of(context).maybePop(),
                  icon: const Icon(Icons.close, color: AppColors.ivory),
                ),
              ),
              Positioned(
                left: 24,
                right: 24,
                bottom: 32,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      current.category.label,
                      style: AppTextStyles.eyebrow(context),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      current.title,
                      style: AppTextStyles.serif(
                        fontSize: 26,
                        color: AppColors.ivory,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${_index + 1} / ${widget.items.length}',
                      style: AppTextStyles.bodySmall(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
