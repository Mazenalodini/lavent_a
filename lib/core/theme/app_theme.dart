import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Lavent Luxury Abaya Manager - Main Theme Configuration
class AppTheme {
  AppTheme._();

  // Shared text theme builder to ensure consistent styles
  static TextTheme _buildTextTheme(Color primaryColor, Color secondaryColor) {
    return TextTheme(
      displayLarge: GoogleFonts.cairo(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        color: primaryColor,
      ),
      displayMedium: GoogleFonts.cairo(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: primaryColor,
      ),
      displaySmall: GoogleFonts.cairo(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: primaryColor,
      ),
      headlineLarge: GoogleFonts.cairo(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: primaryColor,
      ),
      headlineMedium: GoogleFonts.cairo(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
      headlineSmall: GoogleFonts.cairo(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
      titleLarge: GoogleFonts.cairo(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
      titleMedium: GoogleFonts.cairo(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: primaryColor,
      ),
      titleSmall: GoogleFonts.cairo(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: primaryColor,
      ),
      bodyLarge: GoogleFonts.cairo(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: primaryColor,
      ),
      bodyMedium: GoogleFonts.cairo(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: primaryColor,
      ),
      bodySmall: GoogleFonts.cairo(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: secondaryColor,
      ),
      labelLarge: GoogleFonts.cairo(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: primaryColor,
      ),
      labelMedium: GoogleFonts.cairo(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: secondaryColor,
      ),
      labelSmall: GoogleFonts.cairo(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: secondaryColor,
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // LIGHT THEME (Primary)
  // ─────────────────────────────────────────────────────────────────────────────

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,

        // Color Scheme
        colorScheme: const ColorScheme.light(
          primary: AppColors.accent,
          onPrimary: Colors.white,
          secondary: AppColors.surfaceSecondary,
          onSecondary: AppColors.textPrimary,
          surface: AppColors.cardSurface,
          onSurface: AppColors.textPrimary,
          error: AppColors.error,
          onError: Colors.white,
        ),

        // Scaffold
        scaffoldBackgroundColor: AppColors.background,

        // AppBar
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: GoogleFonts.cairo(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
          iconTheme: const IconThemeData(
            color: AppColors.textPrimary,
            size: 24,
          ),
        ),

        // Drawer
        drawerTheme: const DrawerThemeData(
          backgroundColor: AppColors.cardSurface,
          elevation: 2,
        ),

        // Cards
        cardTheme: CardTheme(
          color: AppColors.cardSurface,
          elevation: 2,
          shadowColor: AppColors.textPrimary.withOpacity(0.08),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),

        // Elevated Buttons
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accent,
            foregroundColor: Colors.white,
            elevation: 2,
            shadowColor: AppColors.accent.withOpacity(0.3),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: GoogleFonts.cairo(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // Outlined Buttons
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.accent,
            side: const BorderSide(color: AppColors.accent, width: 1.5),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: GoogleFonts.cairo(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // Text Buttons
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.accent,
            textStyle: GoogleFonts.cairo(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // Input Decoration
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surfaceSecondary.withOpacity(0.5),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.divider, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.accent, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.error, width: 1),
          ),
          labelStyle: GoogleFonts.cairo(fontSize: 14, color: AppColors.textSecondary),
          hintStyle: GoogleFonts.cairo(fontSize: 14, color: AppColors.textSecondary.withOpacity(0.7)),
        ),

        // FAB
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.accent,
          foregroundColor: Colors.white,
          elevation: 4,
          shape: CircleBorder(),
        ),

        // Divider
        dividerTheme: const DividerThemeData(
          color: AppColors.divider,
          thickness: 1,
          space: 24,
        ),

        // Chip
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.surfaceSecondary,
          labelStyle: GoogleFonts.cairo(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textPrimary),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),

        // SnackBar
        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColors.textPrimary,
          contentTextStyle: GoogleFonts.cairo(fontSize: 14, color: Colors.white),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),

        // Dialog
        dialogTheme: DialogTheme(
          backgroundColor: AppColors.cardSurface,
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          titleTextStyle: GoogleFonts.cairo(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
          contentTextStyle: GoogleFonts.cairo(fontSize: 14, color: AppColors.textSecondary),
        ),

        // List Tile
        listTileTheme: const ListTileThemeData(
          iconColor: AppColors.textSecondary,
          textColor: AppColors.textPrimary,
        ),

        // Icon Theme
        iconTheme: const IconThemeData(color: AppColors.textSecondary),

        // Text Theme
        textTheme: _buildTextTheme(AppColors.textPrimary, AppColors.textSecondary),
      );

  // ─────────────────────────────────────────────────────────────────────────────
  // DARK THEME
  // ─────────────────────────────────────────────────────────────────────────────

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,

        // Color Scheme
        colorScheme: const ColorScheme.dark(
          primary: AppColors.darkAccent,
          onPrimary: AppColors.darkBackground,
          secondary: AppColors.darkAccentSecondary,
          onSecondary: AppColors.darkBackground,
          surface: AppColors.darkCardSurface,
          onSurface: AppColors.darkTextPrimary,
          error: AppColors.darkError,
          onError: Colors.white,
        ),

        // Scaffold
        scaffoldBackgroundColor: AppColors.darkBackground,

        // AppBar
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.darkBackground,
          foregroundColor: AppColors.darkTextPrimary,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: GoogleFonts.cairo(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.darkTextPrimary,
          ),
          iconTheme: const IconThemeData(color: AppColors.darkIconPrimary, size: 24),
        ),

        // Drawer
        drawerTheme: const DrawerThemeData(
          backgroundColor: AppColors.darkSurface,
          elevation: 4,
        ),

        // Cards
        cardTheme: CardTheme(
          color: AppColors.darkCardSurface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: AppColors.darkDivider.withOpacity(0.5), width: 1),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),

        // Elevated Buttons
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.darkAccent,
            foregroundColor: AppColors.darkBackground,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            textStyle: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),

        // Outlined Buttons
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.darkAccent,
            side: BorderSide(color: AppColors.darkAccent.withOpacity(0.7), width: 1.5),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            textStyle: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),

        // Text Buttons
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.darkAccent,
            textStyle: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),

        // Input Decoration
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.darkSurface,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.darkDivider, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.darkAccent, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.darkError, width: 1),
          ),
          labelStyle: GoogleFonts.cairo(fontSize: 14, color: AppColors.darkTextSecondary),
          hintStyle: GoogleFonts.cairo(fontSize: 14, color: AppColors.darkTextSecondary.withOpacity(0.7)),
        ),

        // FAB
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.darkAccent,
          foregroundColor: AppColors.darkBackground,
          elevation: 4,
          shape: CircleBorder(),
        ),

        // Divider
        dividerTheme: const DividerThemeData(
          color: AppColors.darkDivider,
          thickness: 1,
          space: 24,
        ),

        // Chip
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.darkSurfaceSecondary,
          disabledColor: AppColors.darkSurface,
          selectedColor: AppColors.darkAccent,
          labelStyle: GoogleFonts.cairo(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.darkTextPrimary),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: AppColors.darkDivider.withOpacity(0.5)),
          ),
        ),

        // SnackBar
        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColors.darkCardSurface,
          contentTextStyle: GoogleFonts.cairo(fontSize: 14, color: AppColors.darkTextPrimary),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),

        // Dialog
        dialogTheme: DialogTheme(
          backgroundColor: AppColors.darkCardSurface,
          elevation: 16,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: AppColors.darkDivider.withOpacity(0.3)),
          ),
          titleTextStyle: GoogleFonts.cairo(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.darkTextPrimary),
          contentTextStyle: GoogleFonts.cairo(fontSize: 14, color: AppColors.darkTextSecondary),
        ),

        // List Tile
        listTileTheme: ListTileThemeData(
          iconColor: AppColors.darkIconSecondary,
          textColor: AppColors.darkTextPrimary,
          subtitleTextStyle: GoogleFonts.cairo(color: AppColors.darkTextSecondary),
        ),

        // Icon Theme
        iconTheme: const IconThemeData(color: AppColors.darkIconSecondary),

        // Switch Theme
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) return AppColors.darkAccent;
            return AppColors.darkTextSecondary;
          }),
          trackColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) return AppColors.darkAccent.withOpacity(0.3);
            return AppColors.darkDivider;
          }),
        ),

        // Text Theme
        textTheme: _buildTextTheme(AppColors.darkTextPrimary, AppColors.darkTextSecondary),
      );
}
