import 'package:flutter/material.dart';

/// IBM Carbon design tokens — WMS Pro palette.
/// Sole interactive accent: Blue 60 (#0f62fe).
/// Never add secondary accent colors.
abstract final class AppColors {
  // ── Neutrals ────────────────────────────────────────────────────────────
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);

  // ── Canvas / Layer ───────────────────────────────────────────────────────
  /// White canvas — Scaffold background.
  static const background = Color(0xFFFFFFFF);

  /// Gray 10 — tile / card background.
  static const layer01 = Color(0xFFF4F4F4);

  /// Gray 10 Hover — hover / pressed state on tiles.
  static const layer01Hover = Color(0xFFE8E8E8);

  // ── Text ─────────────────────────────────────────────────────────────────
  /// Gray 100 — primary text.
  static const text01 = Color(0xFF161616);

  /// Gray 70 — secondary / supporting text.
  static const text02 = Color(0xFF525252);

  /// Gray 50 — placeholder / disabled text.
  static const text03 = Color(0xFF8D8D8D);

  // ── Interactive — sole accent ────────────────────────────────────────────
  /// Blue 60 — primary interactive, buttons, focus rings.
  static const blue60 = Color(0xFF0F62FE);

  /// Blue 70 — button hover.
  static const blue70 = Color(0xFF0043CE);

  /// Blue 80 — button active / pressed.
  static const blue80 = Color(0xFF002D9C);

  // ── Borders / Dividers ───────────────────────────────────────────────────
  /// Gray 20 — subtle divider lines, card stroke.
  static const borderSubtle = Color(0xFFE0E0E0);

  /// Gray 50 — stronger border (enabled input underline).
  static const borderStrong = Color(0xFF8D8D8D);

  // ── Status ───────────────────────────────────────────────────────────────
  /// Red 60 — error / danger / destructive actions.
  static const danger = Color(0xFFDA1E28);

  /// Green 60 — success indicator.
  static const supportSuccess = Color(0xFF198038);

  /// Yellow 30 — warning indicator.
  static const supportWarning = Color(0xFFF1C21B);
}
