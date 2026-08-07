import 'package:flutter/foundation.dart';

enum GalleryCategory {
  leather('LEATHER'),
  textures('TEXTURES'),
  colors('COLORS'),
  fashion('FASHION'),
  team('TEAM'),
  events('EVENTS'),
  details('DETAILS');

  const GalleryCategory(this.label);

  final String label;
}

@immutable
class GalleryItem {
  const GalleryItem({
    required this.id,
    required this.category,
    required this.title,
    required this.altText,
    this.assetPath,
  });

  final String id;
  final GalleryCategory category;
  final String title;

  /// Description used for `Semantics` and, once supplied, image alt text.
  final String altText;

  /// Null until the client supplies the corresponding asset.
  final String? assetPath;
}
