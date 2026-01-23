import 'package:flutter/material.dart';

/// Lavent Luxury Abaya Manager - Color Palette
/// Design Philosophy: "Minimal Luxury" - Clean and Elegant
class AppColors {
  AppColors._();

  // ─────────────────────────────────────────────────────────────────────────────
  // LIGHT THEME CORE PALETTE
  // ─────────────────────────────────────────────────────────────────────────────

  /// Background: Off-White / Ivory - Clean, warm canvas
  static const Color background = Color(0xFFFDFCF8);

  /// Primary Text/Dark: Deep Charcoal - Softer than pure black for luxury text
  static const Color textPrimary = Color(0xFF2C2C2C);

  /// Secondary Text: Muted gray for less important text
  static const Color textSecondary = Color(0xFF6B6B6B);

  /// Accent (Luxury): Rose Gold - For primary buttons, highlights
  static const Color accent = Color(0xFFB76E79);

  /// Secondary Accent: Champagne Gold
  static const Color accentSecondary = Color(0xFFD4AF37);

  /// Secondary Surface: Soft Beige - For card backgrounds, dividers
  static const Color surfaceSecondary = Color(0xFFE8E4D9);

  /// Card Surface: Pure white with slight warmth
  static const Color cardSurface = Color(0xFFFFFFFF);

  /// Surface: Light surface for elevated elements
  static const Color surface = Color(0xFFF5F4F0);

  /// Divider/Border: Light beige
  static const Color divider = Color(0xFFE0DDD5);

  // ─────────────────────────────────────────────────────────────────────────────
  // STATUS COLORS (Elegant - Light Theme)
  // ─────────────────────────────────────────────────────────────────────────────

  /// New Order: Steel Blue - Professional, calm
  static const Color statusNew = Color(0xFF4682B4);

  /// In Progress: Warm Gold / Amber - Active, precious
  static const Color statusProcessing = Color(0xFFD4AF37);

  /// Delivered: Emerald Green - Success, completed
  static const Color statusDelivered = Color(0xFF50C878);

  // ─────────────────────────────────────────────────────────────────────────────
  // SEMANTIC COLORS (Light Theme)
  // ─────────────────────────────────────────────────────────────────────────────

  /// Error: Soft red for validation errors
  static const Color error = Color(0xFFD32F2F);

  /// Warning: Warm amber for warnings
  static const Color warning = Color(0xFFF9A825);

  /// Success: Green for success states
  static const Color success = Color(0xFF388E3C);

  // ═══════════════════════════════════════════════════════════════════════════
  // DARK THEME - ELEGANT LUXURY NIGHT MODE
  // ═══════════════════════════════════════════════════════════════════════════

  /// Dark Background: Rich deep navy with warmth
  static const Color darkBackground = Color(0xFF0F1419);

  /// Dark Surface: Elevated dark with subtle blue
  static const Color darkSurface = Color(0xFF1C2127);

  /// Dark Card Surface: Slightly lighter for cards
  static const Color darkCardSurface = Color(0xFF252B33);

  /// Dark Surface Secondary: For subtle sections
  static const Color darkSurfaceSecondary = Color(0xFF2E353E);

  /// Dark Divider: Subtle line with slight glow
  static const Color darkDivider = Color(0xFF3A424D);

  /// Dark Text Primary: Warm off-white (NOT pure white)
  static const Color darkTextPrimary = Color(0xFFF0EDE8);

  /// Dark Text Secondary: Soft silver with warmth
  static const Color darkTextSecondary = Color(0xFF9BA3AD);

  /// Dark Accent: Brighter rose gold for dark mode
  static const Color darkAccent = Color(0xFFE8919A);

  /// Dark Secondary Accent: Bright gold
  static const Color darkAccentSecondary = Color(0xFFE8C547);

  // ─────────────────────────────────────────────────────────────────────────────
  // STATUS COLORS (Dark Theme - Brighter for visibility)
  // ─────────────────────────────────────────────────────────────────────────────

  /// New Order (Dark): Bright Sky Blue
  static const Color darkStatusNew = Color(0xFF5CA8E8);

  /// In Progress (Dark): Bright Gold
  static const Color darkStatusProcessing = Color(0xFFE8C547);

  /// Delivered (Dark): Bright Emerald
  static const Color darkStatusDelivered = Color(0xFF6BD98E);

  // ─────────────────────────────────────────────────────────────────────────────
  // SEMANTIC COLORS (Dark Theme - Softer for comfort)
  // ─────────────────────────────────────────────────────────────────────────────

  /// Error (Dark): Coral red
  static const Color darkError = Color(0xFFFF7B7B);

  /// Warning (Dark): Warm amber
  static const Color darkWarning = Color(0xFFFFBB4D);

  /// Success (Dark): Bright green
  static const Color darkSuccess = Color(0xFF6BD98E);

  // ─────────────────────────────────────────────────────────────────────────────
  // ICON COLORS (Dark Theme)
  // ─────────────────────────────────────────────────────────────────────────────

  /// Icon Primary (Dark): Warm off-white
  static const Color darkIconPrimary = Color(0xFFE0DDD8);

  /// Icon Secondary (Dark): Soft silver
  static const Color darkIconSecondary = Color(0xFF8A919A);

  // ─────────────────────────────────────────────────────────────────────────────
  // GRADIENT COLORS (Luxury Effects)
  // ─────────────────────────────────────────────────────────────────────────────

  /// Gold gradient for premium elements
  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFD4AF37), Color(0xFFF0D78C), Color(0xFFD4AF37)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Rose gradient
  static const LinearGradient roseGradient = LinearGradient(
    colors: [Color(0xFFB76E79), Color(0xFFE8B4BC), Color(0xFFB76E79)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Dark gradient for night mode cards
  static const LinearGradient darkCardGradient = LinearGradient(
    colors: [Color(0xFF252B33), Color(0xFF1C2127)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
