import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';


/// A styled card widget following the Lavent luxury design system
/// Theme-aware: Automatically adapts to light/dark mode
class LaventCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;

  const LaventCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final cardColor = color ?? (isDark ? AppColors.darkCardSurface : AppColors.cardSurface);
    final shadowColor = isDark 
        ? Colors.black.withOpacity(0.3) 
        : AppColors.textPrimary.withOpacity(0.06);
    final borderColor = isDark 
        ? AppColors.darkDivider.withOpacity(0.5) 
        : Colors.transparent;

    return Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: isDark ? 1 : 0),
        boxShadow: isDark ? [] : [
          BoxShadow(
            color: shadowColor,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// A dashboard stat card with icon, value, and label
/// Theme-aware: Automatically adapts to light/dark mode
class StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color? accentColor;

  const StatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = accentColor ?? (isDark ? AppColors.darkAccent : AppColors.accent);
    final textColor = isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;

    return LaventCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(isDark ? 0.2 : 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: AppTextStyles.headlineMedium.copyWith(
              color: textColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
