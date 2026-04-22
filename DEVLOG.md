# WMS Pro — Dev Log

Append-only. After each session paste: date, what changed, why, and any open questions.

---

## 2026-04-22 — DB bug fix + README screenshots

- Fixed critical Isar bug: `InventoryController.save()` and `InvoiceController.save()` both used `existing?.id ?? -1` for new items. Isar treats `-1` as a fixed auto ID → every new item overwrote the same single record. Changed to `Isar.autoIncrement`. Added `isar` import to both controllers.
- Updated `README.md` Screens section: added all 11 screenshots (Dashboard, Login, Inventory, AddStockItem, InvoiceList, CreateInvoice, AddLineItem, Invoice, PDFPreviewInvoice, Settings). Fixed broken `InventoryList.png` ref → `Inventory.png`.
- Note: `nextInvoiceNumber()` uses `count + 1` for sequence — will collide if invoices are deleted. Acceptable for now; flag for future sprint.

---

## 2026-04-21 — IBM Carbon theme overhaul

- Rewrote `app_colors.dart`: replaced crimson/mustard/banana palette with Carbon tokens (white canvas, Gray 10 layer, Gray 100 text, Blue 60 sole accent, Red 60 danger).
- Rewrote `app_text_styles.dart`: Carbon type scale — 28/20/16px headings, 16/14/12px body, 0.16–0.32px tracking, `text01`/`text02`/`text03` colors.
- Rewrote `app_theme.dart`: light-only theme, 0px button/FAB/card/chip radius, bottom-border-only inputs (`UnderlineInputBorder`, `layer01` fill, Blue 60 focus), no card shadows, white AppBar.
- Fixed `app.dart`: removed `darkTheme`/`ThemeMode.dark`, switched to `ThemeMode.light`.
- Fixed all 8 feature pages: replaced every direct `AppColors.*` ref — old accents → `blue60`, errors → `danger`, disabled → `text03`, secondary text → `text02`.
- `flutter analyze`: 0 issues.

---

## 2026-04-20 — Project scaffolding
- Created CLAUDE.md, DEVLOG.md, TASKS.md for session continuity
- Active branch: `feature/UI` — pixel-perfect IBM Carbon UI pass
- No code changes this session
