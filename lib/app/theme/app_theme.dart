import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_text_styles.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData light() {
    final ThemeData base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.warmWhite,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.charcoal,
        secondary: AppColors.cognac,
        surface: AppColors.warmWhite,
        error: AppColors.error,
      ),
      textTheme: GoogleFonts.interTextTheme(base.textTheme).apply(
        bodyColor: AppColors.neutral700,
        displayColor: AppColors.charcoal,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.neutral100,
        thickness: 1,
        space: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: false,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        labelStyle: AppTextStyles.sans(
          fontSize: 12,
          letterSpacing: 1.4,
          color: AppColors.neutral500,
        ),
        floatingLabelStyle: AppTextStyles.sans(
          fontSize: 12,
          letterSpacing: 1.4,
          color: AppColors.charcoal,
        ),
        errorStyle: AppTextStyles.sans(fontSize: 12, color: AppColors.error),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.neutral300),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.charcoal, width: 1.4),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.error, width: 1.4),
        ),
      ),
      focusColor: AppColors.cognac,
      splashFactory: NoSplash.splashFactory,
      cardTheme: const CardThemeData(
        elevation: 0,
        color: AppColors.warmWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.none)),
        ),
      ),
    );
  }
}
