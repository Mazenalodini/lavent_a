import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/app_toast.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/enums.dart';
import '../../../providers.dart';
import '../../common/empty_state.dart';
import '../../common/lavent_card.dart';
import '../../common/status_badge.dart';

/// شاشة الطلبات المؤرشفة
class ArchivedOrdersScreen extends ConsumerWidget {
  const ArchivedOrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final archivedOrders = ref.watch(archivedOrdersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('الأرشيف'),
      ),
      body: archivedOrders.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('خطأ: $err')),
        data: (orders) {
          if (orders.isEmpty) {
            return EmptyState.noArchivedOrders();
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return _ArchivedOrderCard(order: order);
            },
          );
        },
      ),
    );
  }
}

class _ArchivedOrderCard extends ConsumerWidget {
  final dynamic order;

  const _ArchivedOrderCard({required this.order});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = OrderStatus.fromName(order.status);

    return LaventCard(
      margin: const EdgeInsets.only(bottom: 12),
      onTap: () => _showActions(context, ref),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(order.orderNumber, style: AppTextStyles.orderNumber),
                  const SizedBox(height: 4),
                  Text(order.clientName, style: AppTextStyles.headlineSmall),
                ],
              ),
              StatusBadge(status: status),
            ],
          ),
          const SizedBox(height: 12),

          // Info Row
          Row(
            children: [
              Icon(Icons.phone, size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 6),
              Text(order.clientPhone, style: AppTextStyles.bodySmall),
              const Spacer(),
              Icon(Icons.calendar_today, size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 6),
              Text(Formatters.date(order.orderDate), style: AppTextStyles.bodySmall),
            ],
          ),

          const SizedBox(height: 12),

          // Archive indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.textSecondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.archive_rounded, size: 16, color: AppColors.textSecondary),
                const SizedBox(width: 6),
                Text('مؤرشف', style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showActions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('إجراءات الأرشيف', style: AppTextStyles.headlineSmall),
            const SizedBox(height: 24),

            // Restore button
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.unarchive_rounded, color: AppColors.success),
              ),
              title: const Text('استعادة الطلب'),
              subtitle: const Text('إرجاع الطلب إلى القائمة الرئيسية'),
              onTap: () async {
                Navigator.pop(context);
                await _unarchive(context, ref);
              },
            ),

            const Divider(),

            // Permanent delete button
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.delete_forever_rounded, color: AppColors.error),
              ),
              title: Text('حذف نهائي', style: TextStyle(color: AppColors.error)),
              subtitle: const Text('لا يمكن التراجع عن هذا الإجراء'),
              onTap: () async {
                Navigator.pop(context);
                await _permanentDelete(context, ref);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _unarchive(BuildContext context, WidgetRef ref) async {
    try {
      final db = ref.read(databaseProvider);
      await db.unarchiveOrder(order.id);
      
      ref.invalidate(archivedOrdersProvider);
      ref.invalidate(allOrdersProvider);

      if (context.mounted) {
        AppToast.success(context, 'تم استعادة الطلب ✅');
      }
    } catch (e) {
      if (context.mounted) {
        AppToast.error(context, 'حدث خطأ: $e');
      }
    }
  }

  Future<void> _permanentDelete(BuildContext context, WidgetRef ref) async {
    final confirmed = await AppDialog.confirmPermanentDelete(context);
    if (!confirmed) return;

    try {
      final db = ref.read(databaseProvider);
      await db.deleteOrder(order.id);
      
      ref.invalidate(archivedOrdersProvider);

      if (context.mounted) {
        AppToast.success(context, 'تم الحذف نهائياً');
      }
    } catch (e) {
      if (context.mounted) {
        AppToast.error(context, 'حدث خطأ: $e');
      }
    }
  }
}
