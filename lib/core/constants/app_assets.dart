/// Asset paths.
///
/// Image assets are supplied by the client. Until they are delivered, the
/// editorial image widgets render a clearly marked placeholder instead of
/// third-party stock imagery. See `docs/asset-manifest.md`.
class AppAssets {
  const AppAssets._();

  static const String imagesRoot = 'assets/images';

  static const String brandDir = '$imagesRoot/brand';
  static const String heroDir = '$imagesRoot/hero';
  static const String leatherDir = '$imagesRoot/leather';
  static const String texturesDir = '$imagesRoot/textures';
  static const String colorsDir = '$imagesRoot/colors';
  static const String fashionDir = '$imagesRoot/fashion';
  static const String teamDir = '$imagesRoot/team';
  static const String processDir = '$imagesRoot/process';
  static const String eventsDir = '$imagesRoot/events';
  static const String galleryDir = '$imagesRoot/gallery';

  /// CLIENT LOGO ASSET REQUIRED — until an official logo file is supplied the
  /// wordmark is rendered typographically.
  static const String? logo = null;
}
