# New Leather

Editorial Flutter Web site for **New Leather srl**, Montegranaro (FM), Italy.

## Quick start

```bash
flutter pub get
flutter run -d chrome
```

Build for production:

```bash
flutter build web --release
```

Toolchain versions are recorded in [`docs/tooling.md`](docs/tooling.md).

## Structure

```
lib/
  main.dart
  app/            app widget, routes, theme (colors, type, spacing, radius, breakpoints)
  core/           constants, responsive helpers, utils, low-level widgets
  features/       home, about, leather, expertise, applications, collections,
                  gallery, team, journal, contact — each with presentation/
  shared/         cross-feature widgets (navbar, mobile menu, footer, sections) and models
```

No state-management package: `StatefulWidget`, `ValueNotifier` and local state
only.

## Documentation

| Document | Contents |
| --- | --- |
| [`docs/instagram-audit.md`](docs/instagram-audit.md) | Public-information audit; verified vs. unverified facts |
| [`docs/asset-manifest.md`](docs/asset-manifest.md) | Every image slot, its source, alt text and status |
| [`docs/contact-form-setup.md`](docs/contact-form-setup.md) | How to connect the contact form to a real backend |
| [`docs/tooling.md`](docs/tooling.md) | Flutter/Dart versions, dependencies, commands |

## Content policy

Nothing on this site states a fact that has not been verified. Years of
activity, certifications, awards, clients, capacity, machinery, employees,
sustainability claims, leather types, processes and partnerships are **not**
mentioned. Where a claim would otherwise be needed, the page shows
`[CLIENT CONFIRMATION REQUIRED]`.

Editorial lines such as *"Leather, shaped by experience."* are **website copy**,
not official company slogans.

## Outstanding before launch

- [ ] Client logo asset (`CLIENT LOGO ASSET REQUIRED`) — a typographic wordmark
      is used meanwhile.
- [ ] Photography for every slot in the asset manifest.
- [ ] Contact form backend and credentials.
- [ ] Production domain: replace `example.com` in `web/index.html`,
      `web/robots.txt` and `web/sitemap.xml`.
- [ ] Confirm or remove every `[CLIENT CONFIRMATION REQUIRED]` marker.
