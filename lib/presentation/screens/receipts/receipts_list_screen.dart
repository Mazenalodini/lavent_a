import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/local/database.dart';
import '../../../data/models/enums.dart';
import '../../../providers.dart';
import '../../common/lavent_card.dart';

class ReceiptsListScreen extends ConsumerWidget {
  const ReceiptsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final receiptsAsync = ref.watch(allReceiptsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة سندات القبض'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/receipts/new');
        },
        child: const Icon(Icons.add),
      ),
      body: receiptsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('خطأ: $err')),
        data: (receipts) {
          if (receipts.isEmpty) {
            return _buildEmptyState();
          }
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 80), // Padding for FAB
            itemCount: receipts.length,
            itemBuilder: (context, index) {
              return _ReceiptListCard(receipt: receipts[index]);
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
            Icons.receipt_long_outlined,
            size: 80,
            color: AppColors.textSecondary.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'لا توجد سندات قبض بعد',
            style: AppTextStyles.headlineSmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'اضغط على زر + لإضافة سند قبض جديد',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReceiptListCard extends ConsumerWidget {
  final Receipt receipt;

  const _ReceiptListCard({required this.receipt});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderAsync = ref.watch(orderByIdProvider(receipt.orderId));
    final method = PaymentMethod.fromName(receipt.paymentMethod);

    return LaventCard(
      onTap: () {
        Navigator.pushNamed(context, '/orders/detail',
            arguments: receipt.orderId);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.statusDelivered.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.receipt_long_rounded,
                  color: AppColors.statusDelivered,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      receipt.receiptNumber,
                      style: AppTextStyles.orderNumber,
                    ),
                    const SizedBox(height: 4),
                    orderAsync.when(
                      loading: () => const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      error: (_, __) => const Text('-'),
                      data: (order) => Text(
                        order?.clientName ?? '-',
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    Formatters.currency(receipt.amount),
                    style: AppTextStyles.price,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceSecondary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      method.displayName,
                      style: AppTextStyles.labelSmall,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.calendar_today,
                  size: 14, color: AppColors.textSecondary),
              const SizedBox(width: 4),
              Text(
                Formatters.date(receipt.date),
                style: AppTextStyles.bodySmall,
              ),
              const SizedBox(width: 16),
              orderAsync.when(
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
                data: (order) {
                  if (order == null) return const SizedBox.shrink();
                  return Row(
                    children: [
                      Icon(Icons.tag,
                          size: 14, color: AppColors.textSecondary),
                      const SizedBox(width: 4),
                      Text(
                        order.orderNumber,
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          if (receipt.notes != null && receipt.notes!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              receipt.notes!,
              style: AppTextStyles.bodySmall.copyWith(
                fontStyle: FontStyle.italic,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}
