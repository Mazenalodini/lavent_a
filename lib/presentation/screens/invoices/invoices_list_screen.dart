import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/local/database.dart';
import '../../../data/models/enums.dart';
import '../../../providers.dart';
import '../../common/lavent_card.dart';
import '../../common/status_badge.dart';

/// Screen showing orders ready for invoice (Delivered + Fully Paid)
class InvoicesListScreen extends ConsumerWidget {
  const InvoicesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch only delivered orders
    final deliveredOrdersAsync =
        ref.watch(ordersByStatusProvider(OrderStatus.delivered));

    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة الفواتير'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Create InvoiceFormScreen to select an order and create invoice
        },
        child: const Icon(Icons.add),
      ),
      body: deliveredOrdersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('خطأ: $err')),
        data: (orders) {
          if (orders.isEmpty) {
            return _buildEmptyState();
          }
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 80), // Padding for FAB
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return _InvoiceOrderCard(order: orders[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.picture_as_pdf_outlined,
            size: 80,
            color: AppColors.textSecondary.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'لا توجد طلبات جاهزة للفوترة',
            style: AppTextStyles.headlineSmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'اضغط على زر + لإنشاء فاتورة جديدة لطلب مكتمل',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _InvoiceOrderCard extends ConsumerWidget {
  final Order order;

  const _InvoiceOrderCard({required this.order});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalPaidAsync = ref.watch(totalPaidForOrderProvider(order.id));

    return totalPaidAsync.when(
      loading: () => const LaventCard(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      error: (err, _) => LaventCard(child: Text('خطأ: $err')),
      data: (totalPaid) {
        final remaining = order.totalPrice - totalPaid;
        final canPrint = remaining <= 0;

        return LaventCard(
          onTap: canPrint
              ? () => Navigator.pushNamed(context, '/invoices/preview',
                  arguments: order.id)
              : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(order.clientName,
                            style: AppTextStyles.headlineSmall),
                        const SizedBox(height: 4),
                        Text(order.orderNumber,
                            style: AppTextStyles.orderNumber),
                      ],
                    ),
                  ),
                  StatusBadge(status: OrderStatus.delivered),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('الإجمالي', style: AppTextStyles.bodySmall),
                  Text(
                    Formatters.currency(order.totalPrice),
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('المتبقي', style: AppTextStyles.bodySmall),
                  Text(
                    Formatters.currency(remaining),
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                      color: remaining > 0
                          ? AppColors.error
                          : AppColors.statusDelivered,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (canPrint)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pushNamed(
                        context, '/invoices/preview',
                        arguments: order.id),
                    icon: const Icon(Icons.picture_as_pdf_rounded),
                    label: const Text('معاينة الفاتورة'),
                  ),
                )
              else
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.warning_rounded,
                          color: AppColors.error, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        'يجب سداد المبلغ المتبقي أولاً',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
