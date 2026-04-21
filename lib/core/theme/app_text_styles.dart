// Heading font placeholder: Aloevera Display
//   Swap: replace GoogleFonts.montserrat with TextStyle(fontFamily: 'AloeveraDisplay')
//   after declaring the font assets in pubspec.yaml.
// Body font placeholder: Neutiva
//   Swap: replace GoogleFonts.inter with TextStyle(fontFamily: 'Neutiva').
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

abstract final class AppTextStyles {
  static TextStyle get heading1 => GoogleFonts.montserrat(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: AppColors.text01,
        letterSpacing: -0.5,
      );

  static TextStyle get heading2 => GoogleFonts.montserrat(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.text01,
        letterSpacing: 0,
      );

  static TextStyle get heading3 => GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.text01,
        letterSpacing: 0,
      );

  /// Carbon body-short-02 — 16px / 0.16px tracking.
  static TextStyle get bodyLarge => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.text01,
        letterSpacing: 0.16,
      );

  /// Carbon body-short-01 — 14px / 0.16px tracking.
  static TextStyle get bodyMedium => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.text01,
        letterSpacing: 0.16,
      );

  /// Carbon caption-01 / label-01 — 12px / 0.32px tracking.
  static TextStyle get bodySmall => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.text02,
        letterSpacing: 0.32,
      );

  /// Carbon label — 12px semibold / 0.32px tracking.
  static TextStyle get label => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppColors.text02,
        letterSpacing: 0.32,
      );

  /// Button label — 14px semibold / 0.16px tracking.
  static TextStyle get button => GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
        letterSpacing: 0.16,
      );

  /// Caption — 12px light / 0.32px tracking.
  static TextStyle get caption => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w300,
        color: AppColors.text03,
        letterSpacing: 0.32,
      );
}
