import '../../../shared/models/gallery_item.dart';

/// Placeholder gallery slots.
///
/// Each entry is a layout slot with alt text, not a claim about a specific
/// photograph. `assetPath` stays null until the client supplies the image;
/// see `docs/asset-manifest.md`.
class GalleryData {
  const GalleryData._();

  static const List<GalleryItem> items = <GalleryItem>[
    GalleryItem(
      id: 'leather-01',
      category: GalleryCategory.leather,
      title: 'Leather, full hide',
      altText: 'Full hide photographed flat in daylight',
    ),
    GalleryItem(
      id: 'leather-02',
      category: GalleryCategory.leather,
      title: 'Leather, folded',
      altText: 'Folded leather showing the fall of the material',
    ),
    GalleryItem(
      id: 'leather-03',
      category: GalleryCategory.leather,
      title: 'Leather, stacked',
      altText: 'Stacked hides seen from the edge',
    ),
    GalleryItem(
      id: 'textures-01',
      category: GalleryCategory.textures,
      title: 'Grain, close',
      altText: 'Macro study of leather grain',
    ),
    GalleryItem(
      id: 'textures-02',
      category: GalleryCategory.textures,
      title: 'Surface, raking light',
      altText: 'Leather surface photographed in raking light',
    ),
    GalleryItem(
      id: 'colors-01',
      category: GalleryCategory.colors,
      title: 'Tone study',
      altText: 'Range of leather tones laid side by side',
    ),
    GalleryItem(
      id: 'colors-02',
      category: GalleryCategory.colors,
      title: 'Depth of color',
      altText: 'Single colour shown across light and shadow',
    ),
    GalleryItem(
      id: 'fashion-01',
      category: GalleryCategory.fashion,
      title: 'Fashion context',
      altText: 'Leather in a contemporary fashion context',
    ),
    GalleryItem(
      id: 'fashion-02',
      category: GalleryCategory.fashion,
      title: 'Fashion context, detail',
      altText: 'Detail of leather used in a fashion context',
    ),
    GalleryItem(
      id: 'details-01',
      category: GalleryCategory.details,
      title: 'Edge',
      altText: 'Close view of a finished leather edge',
    ),
    GalleryItem(
      id: 'details-02',
      category: GalleryCategory.details,
      title: 'Finish',
      altText: 'Close view of a leather finish',
    ),
    GalleryItem(
      id: 'team-01',
      category: GalleryCategory.team,
      title: 'The people behind the material',
      altText:
          'Reserved for a verified photograph of the New Leather team',
    ),
    GalleryItem(
      id: 'events-01',
      category: GalleryCategory.events,
      title: 'Events and exhibitions',
      altText:
          'Reserved for verified photographs of events or exhibitions',
    ),
  ];
}
