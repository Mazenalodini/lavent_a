import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/formatters.dart';

/// عنصر لعرض المبالغ (المدفوع/المتبقي) بشكل جميل
/// يستخدم ألوان مختلفة حسب الحالة
class AmountPill extends StatelessWidget {
  final double amount;
  final String label;
  final AmountType type;
  final bool compact;

  const AmountPill({
    super.key,
    required this.amount,
    required this.label,
    required this.type,
    this.compact = false,
  });

  /// المبلغ المدفوع
  factory AmountPill.paid(double amount, {bool compact = false}) {
    return AmountPill(
      amount: amount,
      label: 'المدفوع',
      type: AmountType.paid,
      compact: compact,
    );
  }

  /// المبلغ المتبقي
  factory AmountPill.remaining(double amount, {bool compact = false}) {
    return AmountPill(
      amount: amount,
      label: 'المتبقي',
      type: amount > 0 ? AmountType.remaining : AmountType.complete,
      compact: compact,
    );
  }

  /// الإجمالي
  factory AmountPill.total(double amount, {bool compact = false}) {
    return AmountPill(
      amount: amount,
      label: 'الإجمالي',
      type: AmountType.total,
      compact: compact,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = _getColors();

    if (compact) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: colors.background,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: colors.border, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(colors.icon, size: 14, color: colors.text),
            const SizedBox(width: 4),
            Text(
              Formatters.currencyCompact(amount),
              style: AppTextStyles.labelSmall.copyWith(
                color: colors.text,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(colors.icon, size: 16, color: colors.text),
              const SizedBox(width: 6),
              Text(
                label,
                style: AppTextStyles.labelSmall.copyWith(
                  color: colors.text.withOpacity(0.8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            Formatters.currency(amount),
            style: AppTextStyles.headlineSmall.copyWith(
              color: colors.text,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  _AmountColors _getColors() {
    switch (type) {
      case AmountType.paid:
        return _AmountColors(
          background: AppColors.success.withOpacity(0.1),
          border: AppColors.success.withOpacity(0.3),
          text: AppColors.success,
          icon: Icons.check_circle_rounded,
        );
      case AmountType.remaining:
        return _AmountColors(
          background: AppColors.warning.withOpacity(0.1),
          border: AppColors.warning.withOpacity(0.3),
          text: AppColors.warning,
          icon: Icons.schedule_rounded,
        );
      case AmountType.complete:
        return _AmountColors(
          background: AppColors.statusDelivered.withOpacity(0.1),
          border: AppColors.statusDelivered.withOpacity(0.3),
          text: AppColors.statusDelivered,
          icon: Icons.check_circle_rounded,
        );
      case AmountType.total:
        return _AmountColors(
          background: AppColors.accent.withOpacity(0.1),
          border: AppColors.accent.withOpacity(0.3),
          text: AppColors.accent,
          icon: Icons.monetization_on_rounded,
        );
    }
  }
}

enum AmountType { paid, remaining, complete, total }

class _AmountColors {
  final Color background;
  final Color border;
  final Color text;
  final IconData icon;

  const _AmountColors({
    required this.background,
    required this.border,
    required this.text,
    required this.icon,
  });
}
