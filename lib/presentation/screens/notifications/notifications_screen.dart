import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../data/local/database.dart' as db;
import '../../../providers.dart';

/// Filter options for notifications
enum NotificationFilter {
  all('الكل'),
  today('اليوم'),
  week('هذا الأسبوع'),
  month('هذا الشهر');

  final String label;
  const NotificationFilter(this.label);
}

/// Provider for unread notifications count
final unreadCountProvider = StreamProvider<int>((ref) {
  final database = ref.watch(databaseProvider);
  return database.watchUnreadCount();
});

/// Provider for notifications with filter
final notificationsFilterProvider = StateProvider<NotificationFilter>((ref) => NotificationFilter.all);

final filteredNotificationsProvider = StreamProvider<List<db.Notification>>((ref) {
  final database = ref.watch(databaseProvider);
  final filter = ref.watch(notificationsFilterProvider);
  
  final now = DateTime.now();
  switch (filter) {
    case NotificationFilter.today:
      final startOfDay = DateTime(now.year, now.month, now.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));
      return database.watchNotificationsFiltered(startDate: startOfDay, endDate: endOfDay);
    case NotificationFilter.week:
      final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
      final start = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
      return database.watchNotificationsFiltered(startDate: start);
    case NotificationFilter.month:
      final startOfMonth = DateTime(now.year, now.month, 1);
      return database.watchNotificationsFiltered(startDate: startOfMonth);
    case NotificationFilter.all:
      return database.watchAllNotifications();
  }
});

/// شاشة الإشعارات والتذكيرات الاحترافية
class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animationController.forward();
    
    // Mark all as read when entering the screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(databaseProvider).markAllNotificationsAsRead();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notificationsAsync = ref.watch(filteredNotificationsProvider);
    final currentFilter = ref.watch(notificationsFilterProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('الإشعارات'),
        actions: [
          // Filter Dropdown
          PopupMenuButton<NotificationFilter>(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.surfaceSecondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.filter_list_rounded, size: 18, color: AppColors.accent),
                  const SizedBox(width: 4),
                  Text(
                    currentFilter.label,
                    style: AppTextStyles.bodySmall.copyWith(color: AppColors.accent),
                  ),
                ],
              ),
            ),
            onSelected: (filter) {
              ref.read(notificationsFilterProvider.notifier).state = filter;
            },
            itemBuilder: (context) => NotificationFilter.values
                .map((filter) => PopupMenuItem(
                      value: filter,
                      child: Row(
                        children: [
                          Icon(
                            filter == currentFilter ? Icons.check_circle : Icons.circle_outlined,
                            size: 18,
                            color: filter == currentFilter ? AppColors.accent : AppColors.textSecondary,
                          ),
                          const SizedBox(width: 8),
                          Text(filter.label),
                        ],
                      ),
                    ))
                .toList(),
          ),
          // Clear All Button
          Builder(
            builder: (context) {
              return notificationsAsync.when(
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
                data: (notifications) => notifications.isNotEmpty
                    ? IconButton(
                        icon: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.error.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(Icons.delete_sweep_rounded, size: 20, color: AppColors.error),
                        ),
                        tooltip: 'مسح الكل',
                        onPressed: _clearAll,
                      )
                    : const SizedBox.shrink(),
              );
            },
          ),
        ],
      ),
      body: notificationsAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: AppColors.error),
              const SizedBox(height: 16),
              Text('حدث خطأ', style: AppTextStyles.headlineMedium),
            ],
          ),
        ),
        data: (notifications) => notifications.isEmpty
            ? _buildEmptyState()
            : _buildNotificationsList(notifications),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.accent.withOpacity(0.1),
                  AppColors.accentSecondary.withOpacity(0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_off_rounded,
              size: 64,
              color: AppColors.accent.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'لا توجد إشعارات',
            style: AppTextStyles.headlineMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'ستظهر هنا تذكيرات مواعيد التسليم',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsList(List<db.Notification> notifications) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(filteredNotificationsProvider);
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              final delay = index * 0.1;
              final slideAnimation = Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: _animationController,
                curve: Interval(
                  delay.clamp(0.0, 0.9),
                  (delay + 0.3).clamp(0.0, 1.0),
                  curve: Curves.easeOutCubic,
                ),
              ));

              return SlideTransition(
                position: slideAnimation,
                child: child,
              );
            },
            child: _NotificationCard(
              notification: notification,
              onDismiss: () => _deleteNotification(notification.id),
            ),
          );
        },
      ),
    );
  }

  Future<void> _deleteNotification(int id) async {
    await ref.read(databaseProvider).deleteNotification(id);
  }

  Future<void> _clearAll() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.delete_forever_rounded, color: AppColors.error),
            ),
            const SizedBox(width: 12),
            const Text('مسح جميع الإشعارات'),
          ],
        ),
        content: const Text('هل أنت متأكد من حذف جميع الإشعارات؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('حذف الكل'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(databaseProvider).deleteAllNotifications();
    }
  }
}

/// بطاقة الإشعار الاحترافية
class _NotificationCard extends StatelessWidget {
  final db.Notification notification;
  final VoidCallback onDismiss;

  const _NotificationCard({
    required this.notification,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final type = notification.type;
    final isUrgent = type == 'delivery_1day';
    final isToday = type == 'delivery_today';

    // Determine icon and color based on type
    IconData icon;
    List<Color> gradientColors;
    
    if (isToday) {
      icon = Icons.local_shipping_rounded;
      gradientColors = [Colors.red.shade400, Colors.red.shade600];
    } else if (isUrgent) {
      icon = Icons.warning_amber_rounded;
      gradientColors = [Colors.orange.shade400, Colors.orange.shade600];
    } else {
      icon = Icons.notifications_active_rounded;
      gradientColors = [AppColors.accent, AppColors.accent.withOpacity(0.8)];
    }

    // Time ago calculation
    final timeAgo = _getTimeAgo(notification.scheduledAt);

    return Dismissible(
      key: Key(notification.id.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 24),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red.shade300, Colors.red.shade500],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Row(
          children: [
            Icon(Icons.delete_rounded, color: Colors.white, size: 28),
            SizedBox(width: 8),
            Text('حذف', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      onDismissed: (_) => onDismiss(),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: notification.isRead 
                ? AppColors.divider.withOpacity(0.5) 
                : gradientColors.first.withOpacity(0.3),
            width: notification.isRead ? 1 : 2,
          ),
          boxShadow: [
            BoxShadow(
              color: gradientColors.first.withOpacity(notification.isRead ? 0.05 : 0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              // Can navigate to order details here
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Icon with gradient background
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: gradientColors),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: gradientColors.first.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Icon(icon, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 14),

                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                notification.title,
                                style: AppTextStyles.bodyLarge.copyWith(
                                  fontWeight: notification.isRead ? FontWeight.w500 : FontWeight.bold,
                                  color: notification.isRead ? AppColors.textSecondary : AppColors.textPrimary,
                                ),
                              ),
                            ),
                            if (!notification.isRead)
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: gradientColors.first,
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          notification.body,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              size: 14,
                              color: AppColors.textSecondary.withOpacity(0.7),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              timeAgo,
                              style: AppTextStyles.labelSmall.copyWith(
                                color: AppColors.textSecondary.withOpacity(0.7),
                              ),
                            ),
                            if (notification.orderNumber != null) ...[
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.accent.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  notification.orderNumber!,
                                  style: AppTextStyles.labelSmall.copyWith(
                                    color: AppColors.accent,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.isNegative) {
      // Future notification
      final futureDiff = date.difference(now);
      if (futureDiff.inDays > 0) {
        return 'بعد ${futureDiff.inDays} ${futureDiff.inDays == 1 ? "يوم" : "أيام"}';
      } else if (futureDiff.inHours > 0) {
        return 'بعد ${futureDiff.inHours} ${futureDiff.inHours == 1 ? "ساعة" : "ساعات"}';
      } else {
        return 'بعد ${futureDiff.inMinutes} دقيقة';
      }
    }

    if (difference.inDays > 30) {
      return 'منذ ${(difference.inDays / 30).floor()} شهر';
    } else if (difference.inDays > 7) {
      return 'منذ ${(difference.inDays / 7).floor()} أسبوع';
    } else if (difference.inDays > 0) {
      return 'منذ ${difference.inDays} ${difference.inDays == 1 ? "يوم" : "أيام"}';
    } else if (difference.inHours > 0) {
      return 'منذ ${difference.inHours} ${difference.inHours == 1 ? "ساعة" : "ساعات"}';
    } else if (difference.inMinutes > 0) {
      return 'منذ ${difference.inMinutes} دقيقة';
    } else {
      return 'الآن';
    }
  }
}

/// زر الجرس مع عداد الإشعارات غير المقروءة
class NotificationBell extends ConsumerWidget {
  const NotificationBell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unreadCountAsync = ref.watch(unreadCountProvider);

    return Stack(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () async {
              await Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const NotificationsScreen(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1, 0),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOutCubic,
                      )),
                      child: child,
                    );
                  },
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.surfaceSecondary.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.notifications_rounded,
                color: AppColors.textPrimary,
                size: 24,
              ),
            ),
          ),
        ),
        unreadCountAsync.when(
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
          data: (count) => count > 0
              ? Positioned(
                  right: 4,
                  top: 4,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.elasticOut,
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: child,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.red.shade400, Colors.red.shade600],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.4),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Text(
                        count > 99 ? '99+' : count.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
