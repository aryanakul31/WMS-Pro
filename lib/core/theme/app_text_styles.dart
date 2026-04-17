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
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.bananaMania,
        letterSpacing: -0.5,
      );

  static TextStyle get heading2 => GoogleFonts.montserrat(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.bananaMania,
        letterSpacing: -0.3,
      );

  static TextStyle get heading3 => GoogleFonts.montserrat(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.bananaMania,
      );

  static TextStyle get bodyLarge => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.bananaMania,
      );

  static TextStyle get bodyMedium => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.bananaMania,
      );

  static TextStyle get bodySmall => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.onSurfaceVariant,
      );

  static TextStyle get label => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: AppColors.onSurfaceVariant,
        letterSpacing: 0.8,
      );

  static TextStyle get button => GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppColors.white,
        letterSpacing: 0.5,
      );

  static TextStyle get caption => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w300,
        color: AppColors.onSurfaceVariant,
      );
}
