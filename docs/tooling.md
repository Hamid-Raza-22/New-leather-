# Toolchain

The project was scaffolded with `flutter create . --platforms web`.

| Tool | Version |
| --- | --- |
| Flutter | 3.35.1 (stable, revision 20f8274939) |
| Dart | 3.9.0 |
| DevTools | 2.48.0 |
| Dart SDK constraint | `^3.9.0` |

## Dependencies

Kept intentionally small.

| Package | Why |
| --- | --- |
| `google_fonts` | Cormorant Garamond (editorial serif) + Inter (UI sans) |
| `url_launcher` | `mailto:`, maps and Instagram links |
| `flutter_lints` (dev) | Standard lint set |

No state-management package is used: the site relies on `StatefulWidget`,
`ValueNotifier` and local state, as specified.

## Commands

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d chrome
flutter build web --release
```

## Notes

- `google_fonts` fetches font files at runtime by default. To ship fonts with
  the bundle instead (recommended for production, and required if the site must
  work without calls to Google's font CDN), add the `.ttf` files under
  `assets/fonts/`, declare them in `pubspec.yaml`, and set
  `GoogleFonts.config.allowRuntimeFetching = false`.
- Web renderer: Flutter 3.35's default (CanvasKit with an HTML fallback). A
  Wasm dry run passes, so `flutter build web --wasm` is available if wanted.
