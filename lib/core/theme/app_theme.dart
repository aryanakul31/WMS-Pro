import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

/// IBM Carbon–compliant theme for WMS Pro.
///
/// Rules enforced here:
///  • 0px border-radius on all interactive controls (buttons, cards, chips).
///  • Inputs: filled with [AppColors.layer01], bottom-border only.
///  • No elevation / shadow on cards or tiles.
///  • Single accent: [AppColors.blue60].
abstract final class AppTheme {
  static ThemeData get light => _build();

  static ThemeData _build() {
    const scheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.blue60,
      onPrimary: AppColors.white,
      secondary: AppColors.blue60,
      onSecondary: AppColors.white,
      tertiary: AppColors.blue70,
      onTertiary: AppColors.white,
      error: AppColors.danger,
      onError: AppColors.white,
      surface: AppColors.background,
      onSurface: AppColors.text01,
      surfaceContainerHighest: AppColors.layer01,
      outline: AppColors.borderSubtle,
      outlineVariant: AppColors.borderStrong,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.background,
      dividerColor: AppColors.borderSubtle,

      textTheme: TextTheme(
        displayLarge: AppTextStyles.heading1,
        displayMedium: AppTextStyles.heading2,
        displaySmall: AppTextStyles.heading3,
        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
        bodySmall: AppTextStyles.bodySmall,
        labelSmall: AppTextStyles.label,
        labelMedium: AppTextStyles.label,
        labelLarge: AppTextStyles.button,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.text01,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: AppTextStyles.heading3,
        iconTheme: const IconThemeData(color: AppColors.text01),
        surfaceTintColor: Colors.transparent,
      ),

      // Cards: Gray 10 fill, no shadow, no rounding, subtle border.
      cardTheme: const CardThemeData(
        color: AppColors.layer01,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(color: AppColors.borderSubtle),
        ),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      ),

      // Primary button: Blue 60, white text, 0px radius, 48px height.
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.blue60,
          foregroundColor: AppColors.white,
          disabledBackgroundColor: AppColors.borderSubtle,
          disabledForegroundColor: AppColors.text03,
          textStyle: AppTextStyles.button,
          minimumSize: const Size.fromHeight(48),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          elevation: 0,
        ),
      ),

      // Ghost / secondary button: no fill, Blue 60 border, 0px radius.
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.blue60,
          textStyle: AppTextStyles.button.copyWith(color: AppColors.blue60),
          minimumSize: const Size.fromHeight(48),
          side: const BorderSide(color: AppColors.blue60),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.blue60,
          textStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.blue60),
        ),
      ),

      // Inputs: Gray 10 fill, bottom-border only.
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.layer01,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.borderStrong),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.borderStrong),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.blue60, width: 2),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.danger),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.danger, width: 2),
        ),
        labelStyle: AppTextStyles.bodySmall.copyWith(color: AppColors.text02),
        hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.text03),
        errorStyle: AppTextStyles.bodySmall.copyWith(color: AppColors.danger),
        // Carbon label: 12px / 0.32px tracking (above field when focused).
        floatingLabelStyle:
            AppTextStyles.label.copyWith(color: AppColors.blue60),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),

      // Bottom nav: white bg, Blue 60 selected, Gray 50 unselected.
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.blue60,
        unselectedItemColor: AppColors.text03,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: AppTextStyles.label,
        unselectedLabelStyle: AppTextStyles.label,
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.blue60,
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.borderSubtle,
        thickness: 1,
        space: 1,
      ),

      iconTheme: const IconThemeData(
        color: AppColors.text01,
        size: 24,
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.blue60,
        foregroundColor: AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: AppColors.layer01,
        labelStyle: AppTextStyles.label,
        side: const BorderSide(color: AppColors.borderSubtle),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.background,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        titleTextStyle: AppTextStyles.heading3,
        contentTextStyle: AppTextStyles.bodyMedium,
      ),
    );
  }
}
