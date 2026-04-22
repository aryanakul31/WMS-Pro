# WMS Pro — Tasks

One action per line. Pick from top. Move done items to DEVLOG.md.

## UI Sprint (Deliverable 1 — feature/UI branch)
- [X] Login screen — IBM Carbon bottom-border inputs, 0px radius, Blue 60 CTA
- [X] Dashboard screen — stats overview, Gray 10 tile grid, no shadows
- [X] Inventory list screen — full-width tiles with hover shift to Gray 10 Hover
- [X] Add/Edit stock item form — Carbon bottom-border inputs, label at 12px 0.32px tracking
- [X] Barcode scanner screen — live camera with scan overlay
- [X] Invoice list screen
- [X] Create invoice screen — item selection, totals
- [X] PDF preview + share sheet integration
- [X] Settings screen — language toggle (EN/NL), logout
- [X] Bottom nav shell — 48px touch targets

## Localization
- [ ] Audit all hardcoded strings — move to `l10n/app_en.arb`
- [ ] Add Dutch translations to `l10n/app_nl.arb`
- [ ] Run `flutter gen-l10n` and fix any missing keys

## Data / Architecture
- [X] Verify Isar schema for inventory items (SKU, barcode, location, quantity)
- [X] Verify Isar schema for invoices
- [X] Fix Isar ID bug — `InventoryController` + `InvoiceController` used `-1` as new-item ID instead of `Isar.autoIncrement` → only 1 record ever saved
- [ ] Run `build_runner` clean build and resolve any conflicts
- [ ] Role-based auth session — Admin vs Vendor access gating

## Polish / Future
- [ ] Swap Montserrat/Inter placeholders for final licensed fonts when available
- [ ] Add offline sync-ready repository interface (stub for future remote sync)
- [X] Add README screenshots once UI stabilizes
- [ ] Run `graphify update .` after next significant code session
