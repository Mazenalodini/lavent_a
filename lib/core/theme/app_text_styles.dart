import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Lavent Luxury Abaya Manager - Typography System
/// Uses Cairo font for elegant Arabic support
/// Colors are NOT hardcoded - they inherit from the current theme
class AppTextStyles {
  AppTextStyles._();

  // ─────────────────────────────────────────────────────────────────────────────
  // HEADINGS
  // ─────────────────────────────────────────────────────────────────────────────

  /// Large title - for main screen titles
  static TextStyle get headlineLarge => GoogleFonts.cairo(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: 1.3,
      );

  /// Medium title - for section headers
  static TextStyle get headlineMedium => GoogleFonts.cairo(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        height: 1.3,
      );

  /// Small title - for card headers
  static TextStyle get headlineSmall => GoogleFonts.cairo(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.3,
      );

  // ─────────────────────────────────────────────────────────────────────────────
  // BODY TEXT
  // ─────────────────────────────────────────────────────────────────────────────

  /// Large body - for important content
  static TextStyle get bodyLarge => GoogleFonts.cairo(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
      );

  /// Medium body - default text
  static TextStyle get bodyMedium => GoogleFonts.cairo(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
      );

  /// Small body - for secondary info
  static TextStyle get bodySmall => GoogleFonts.cairo(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.4,
      );

  // ─────────────────────────────────────────────────────────────────────────────
  // LABELS & BUTTONS
  // ─────────────────────────────────────────────────────────────────────────────

  /// Button text
  static TextStyle get labelLarge => GoogleFonts.cairo(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      );

  /// Label text - for form labels
  static TextStyle get labelMedium => GoogleFonts.cairo(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      );

  /// Small label - for badges/chips
  static TextStyle get labelSmall => GoogleFonts.cairo(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      );

  // ─────────────────────────────────────────────────────────────────────────────
  // SPECIAL STYLES
  // ─────────────────────────────────────────────────────────────────────────────

  /// Price display - bold accent color (theme will apply accent color)
  static TextStyle get price => GoogleFonts.cairo(
        fontSize: 20,
        fontWeight: FontWeight.w700,
      );

  /// Order number display
  static TextStyle get orderNumber => GoogleFonts.cairo(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.0,
      );

  /// Error text
  static TextStyle get error => GoogleFonts.cairo(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      );
}
