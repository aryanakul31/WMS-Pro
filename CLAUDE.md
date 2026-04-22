# WMS Pro — Project Context

## Stack
- Flutter (Dart) · GetX (state, DI, nav) · Isar (local DB) · mobile_scanner · pdf + printing
- Localization: EN / NL via ARB + flutter gen-l10n
- Target: iOS + Android · Flutter 3.38+ · Dart 3.10+

## Design System
- Inspired by IBM Carbon (see DESIGN.md)
- White `#ffffff` canvas, Gray 100 `#161616` text, IBM Blue 60 `#0f62fe` sole accent
- Buttons: 0px border-radius — unapologetically rectangular, Carbon identity
- Inputs: bottom-border only (`2px solid #161616` active), never fully boxed
- Never introduce additional accent colors beyond Blue 60

## Architecture Rules
- Feature-first: `features/<name>/domain/` → `data/` → `presentation/`
- Isar collections go in `domain/` as annotated models; repository wraps all DB access
- Run `dart run build_runner build --delete-conflicting-outputs` after any Isar schema change
- Run `flutter gen-l10n` after any ARB change — never hardcode strings in widgets
- SharedPreferences only for lightweight prefs (auth session, language setting)

## Current Sprint Goal
`feature/UI` branch — Pixel-perfect UI pass (Deliverable 1). All screens must match IBM Carbon spec before any additional feature work.

## Credentials (Dev)
- Email: `admin@wms.pro` · Password: `Admin@123`
- Change admin password after first login

## Never Do
- Don't use SharedPreferences for inventory or invoice data — that's Isar's job
- Don't skip `build_runner` after Isar model changes — stale generated code causes silent failures
- Don't hardcode UI strings — all user-visible text must be in `l10n/app_en.arb` and `app_nl.arb`
- Don't round button corners — 0px radius is non-negotiable in Carbon
- Don't add shadow to cards/tiles — depth comes from background-color layering only

## Key Files
- `lib/core/routes.dart` — GetX AppPages + bindings
- `lib/core/storage/local_storage.dart` — SharedPreferences wrapper
- `lib/core/theme/` — app_colors, app_text_styles, app_theme
- `lib/l10n/` — app_en.arb, app_nl.arb
- Feature pattern: `features/<name>/domain/` · `data/` · `presentation/`

## Session Workflow
1. ALWAYS query the knowledge graph first: '/graphify query
"your question". 
    Only read raw files if I explicitly say "read the file" or "look at the raw file"
    Use 'graphify-out/wiki/index.md' as your navigation entrypoint for browsing structure
2. Read TASKS.md — pick the top item 
3. Run `flutter pub get && dart run build_runner build --delete-conflicting-outputs && flutter gen-l10n`
4. Run `flutter analyze` before and after changes 
5. Test on physical device or simulator (camera/scanner requires physical device)
6. Append session summary to DEVLOG.md 
7. Update TASKS.md — remove completed items, add discovered work
