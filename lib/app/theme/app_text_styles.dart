import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Two typefaces only: a serif for editorial headlines, a sans for UI and body.
class AppTextStyles {
  const AppTextStyles._();

  static TextStyle serif({
    required double fontSize,
    FontWeight fontWeight = FontWeight.w300,
    Color color = AppColors.charcoal,
    double height = 1.06,
    double letterSpacing = -0.5,
  }) {
    return GoogleFonts.cormorantGaramond(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle sans({
    required double fontSize,
    FontWeight fontWeight = FontWeight.w400,
    Color color = AppColors.neutral700,
    double height = 1.6,
    double letterSpacing = 0,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  // Editorial display, used for hero and section openers.
  static TextStyle displayXL(BuildContext context) =>
      serif(fontSize: 88, color: AppColors.ivory);

  static TextStyle displayL(BuildContext context) => serif(fontSize: 64);

  static TextStyle displayM(BuildContext context) => serif(fontSize: 44);

  static TextStyle headline(BuildContext context) => serif(fontSize: 32);

  static TextStyle title(BuildContext context) =>
      serif(fontSize: 24, height: 1.2);

  // Interface and body.
  static TextStyle bodyLarge(BuildContext context) => sans(fontSize: 18);

  static TextStyle body(BuildContext context) => sans(fontSize: 16);

  static TextStyle bodySmall(BuildContext context) =>
      sans(fontSize: 14, color: AppColors.neutral500);

  static TextStyle eyebrow(BuildContext context) => sans(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.neutral500,
        letterSpacing: 2.4,
        height: 1.2,
      );

  static TextStyle button(BuildContext context) => sans(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.8,
        height: 1.2,
        color: AppColors.charcoal,
      );

  static TextStyle navLink(BuildContext context) => sans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.6,
        height: 1.2,
        color: AppColors.ivory,
      );

  static TextStyle logo(BuildContext context) => sans(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 4,
        height: 1.1,
        color: AppColors.ivory,
      );
}
