# Asset manifest

Every image slot on the site is listed here. **No third-party stock photography
is used as New Leather imagery.** Where an asset has not been supplied, the
`EditorialImage` widget renders a clearly marked placeholder rather than a
substitute photograph, so nothing on the site can be mistaken for the brand's
own material.

## Status values

| Status | Meaning |
| --- | --- |
| VERIFIED | Confirmed as the company's own imagery, cleared for use |
| CLIENT ASSET | Awaiting delivery from the client |
| TEMPORARY | Temporary stock, filename must be `TEMPORARY_STOCK_REPLACE.jpg` |
| NEEDS CONFIRMATION | Rights, subject or accuracy not yet confirmed |

**Current state: every slot below is CLIENT ASSET. Nothing is TEMPORARY, because
no stock imagery has been introduced.**

## Brand

| Filename (target) | Source | Category | Section | Alt text | Status |
| --- | --- | --- | --- | --- | --- |
| `assets/images/brand/logo.svg` (or `.png`) | Client | brand | Navbar, mobile menu, footer | "New Leather" | CLIENT LOGO ASSET REQUIRED |
| `web/og-image.png` (1200x630) | Client | brand | Open Graph share image | "New Leather" | CLIENT ASSET |
| `web/favicon.png` | Client | brand | Favicon | — | CLIENT ASSET (Flutter default in place) |

Until a logo file exists, `AppAssets.logo` stays `null` and `BrandWordmark`
renders the wordmark typographically.

## Hero

| Filename (target) | Category | Section | Alt text | Status |
| --- | --- | --- | --- | --- |
| `assets/images/hero/hero.webp` | hero | Home — hero | Full-bleed image of leather | CLIENT ASSET |

Should be the strongest available image of the material. Target 2400px wide,
WebP, progressive; a 1200px variant for mobile.

## Leather / editorial

| Filename (target) | Category | Section | Alt text | Status |
| --- | --- | --- | --- | --- |
| `assets/images/leather/editorial-01.webp` | leather | Home — MORE THAN LEATHER; About | Editorial image of leather in the workshop | CLIENT ASSET |
| `assets/images/leather/full-hide.webp` | leather | Gallery `leather-01` | Full hide photographed flat in daylight | CLIENT ASSET |
| `assets/images/leather/folded.webp` | leather | Gallery `leather-02` | Folded leather showing the fall of the material | CLIENT ASSET |
| `assets/images/leather/stacked.webp` | leather | Gallery `leather-03` | Stacked hides seen from the edge | CLIENT ASSET |

## Textures

| Filename (target) | Category | Section | Alt text | Status |
| --- | --- | --- | --- | --- |
| `assets/images/textures/grain-close.webp` | textures | Home — THE MATERIAL; Gallery `textures-01` | Macro study of leather grain | CLIENT ASSET |
| `assets/images/textures/raking-light.webp` | textures | Gallery `textures-02` | Leather surface photographed in raking light | CLIENT ASSET |

## Colors

| Filename (target) | Category | Section | Alt text | Status |
| --- | --- | --- | --- | --- |
| `assets/images/colors/tone-study.webp` | colors | Home — THE MATERIAL; Gallery `colors-01` | Range of leather tones laid side by side | CLIENT ASSET |
| `assets/images/colors/depth.webp` | colors | Gallery `colors-02` | Single colour shown across light and shadow | CLIENT ASSET |

## Fashion

| Filename (target) | Category | Section | Alt text | Status |
| --- | --- | --- | --- | --- |
| `assets/images/fashion/context-01.webp` | fashion | Applications; Gallery `fashion-01` | Leather in a contemporary fashion context | CLIENT ASSET / NEEDS CONFIRMATION (rights) |
| `assets/images/fashion/context-02.webp` | fashion | Gallery `fashion-02` | Detail of leather used in a fashion context | CLIENT ASSET / NEEDS CONFIRMATION (rights) |

## Process

| Filename (target) | Category | Section | Alt text | Status |
| --- | --- | --- | --- | --- |
| `assets/images/process/research.webp` | process | Home — RESEARCH & EVOLUTION; Expertise | Image representing material research | CLIENT ASSET |
| `assets/images/process/experience.webp` | process | Home — EXPERIENCE MATTERS | Image representing hands-on leather experience | CLIENT ASSET |

## Details

| Filename (target) | Category | Section | Alt text | Status |
| --- | --- | --- | --- | --- |
| `assets/images/gallery/edge.webp` | details | Gallery `details-01` | Close view of a finished leather edge | CLIENT ASSET |
| `assets/images/gallery/finish.webp` | details | Gallery `details-02` | Close view of a leather finish | CLIENT ASSET |

## Team

| Filename (target) | Category | Section | Alt text | Status |
| --- | --- | --- | --- | --- |
| `assets/images/team/team-01.webp` | team | Team page; Gallery `team-01` | Reserved for a verified photograph of the New Leather team | CLIENT ASSET / NEEDS CONFIRMATION (identity + image rights) |

No names may be attached to a portrait until the client confirms them.

## Events

| Filename (target) | Category | Section | Alt text | Status |
| --- | --- | --- | --- | --- |
| `assets/images/events/event-01.webp` | events | Gallery `events-01` | Reserved for verified photographs of events or exhibitions | NEEDS CONFIRMATION (no participation verified) |

## Delivery guidance

- **Format:** WebP preferred; JPEG acceptable for photographic fallbacks.
- **Dimensions:** hero 2400px wide; editorial 1600px; gallery tiles 1200px;
  provide a ~50% variant for mobile where practical.
- **Weight:** aim for < 250 KB per gallery image, < 500 KB for the hero.
- **Colour:** sRGB.
- **Naming:** lowercase, hyphenated, descriptive. Temporary stock, if it ever
  becomes unavoidable, must be named `TEMPORARY_STOCK_REPLACE.jpg`.
- **Registration:** directories are already registered in `pubspec.yaml`; drop
  files in and reference them from `GalleryData` / the relevant widget.
- Each directory contains a `README.md` placeholder so the directory is tracked
  and the asset bundle resolves. Delete it once real assets are added.
