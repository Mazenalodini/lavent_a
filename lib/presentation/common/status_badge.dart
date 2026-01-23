import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/models/enums.dart';


/// A styled badge widget for displaying order status
/// Theme-aware: Automatically adjusts colors for light/dark mode
class StatusBadge extends StatelessWidget {
  final OrderStatus status;
  final bool compact;

  const StatusBadge({
    super.key,
    required this.status,
    this.compact = false,
  });

  Color _getStatusColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    switch (status) {
      case OrderStatus.newOrder:
        return isDark ? AppColors.darkStatusNew : AppColors.statusNew;
      case OrderStatus.processing:
        return isDark ? AppColors.darkStatusProcessing : AppColors.statusProcessing;
      case OrderStatus.delivered:
        return isDark ? AppColors.darkStatusDelivered : AppColors.statusDelivered;
    }
  }

  Color _getBackgroundColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final statusColor = _getStatusColor(context);
    
    return isDark 
        ? statusColor.withOpacity(0.2)
        : statusColor.withOpacity(0.15);
  }

  IconData get _icon {
    switch (status) {
      case OrderStatus.newOrder:
        return Icons.fiber_new_rounded;
      case OrderStatus.processing:
        return Icons.pending_actions_rounded;
      case OrderStatus.delivered:
        return Icons.check_circle_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(context);
    final bgColor = _getBackgroundColor(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 12,
        vertical: compact ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: statusColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _icon,
            size: compact ? 14 : 16,
            color: statusColor,
          ),
          const SizedBox(width: 4),
          Text(
            status.displayName,
            style: AppTextStyles.labelSmall.copyWith(
              color: statusColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
