import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/app_toast.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/utils/id_generator.dart';
import '../../../core/utils/validators.dart';
import '../../../data/local/database.dart';
import '../../../data/models/enums.dart';
import '../../../providers.dart';
import '../../common/lavent_button.dart';
import '../../common/lavent_text_field.dart';

/// Screen for adding a new receipt to an existing order
class ReceiptFormScreen extends ConsumerStatefulWidget {
  const ReceiptFormScreen({super.key});

  @override
  ConsumerState<ReceiptFormScreen> createState() => _ReceiptFormScreenState();
}

class _ReceiptFormScreenState extends ConsumerState<ReceiptFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();

  Order? _selectedOrder;
  PaymentMethod _paymentMethod = PaymentMethod.cash;
  WalletType _walletType = WalletType.kareemi;
  final _walletOtherController = TextEditingController();
  bool _isLoading = false;
  double _remaining = 0;

  @override
  void dispose() {
    _amountController.dispose();
    _notesController.dispose();
    _walletOtherController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ordersAsync = ref.watch(allOrdersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة سند قبض جديد'),
      ),
      body: ordersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('خطأ: $err')),
        data: (orders) => _buildForm(orders),
      ),
    );
  }

  Widget _buildForm(List<Order> orders) {
    // Show all orders that have remaining balance (not fully paid)
    // and are not delivered (since we can't add receipts to delivered orders)
    final availableOrders = orders.where((o) {
      final status = OrderStatus.fromName(o.status);
      return status != OrderStatus.delivered;
    }).toList();

    if (orders.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_bag_outlined,
                size: 80,
                color: AppColors.textSecondary.withOpacity(0.3),
              ),
              const SizedBox(height: 16),
              Text(
                'لا توجد طلبات',
                style: AppTextStyles.headlineSmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'قم بإنشاء طلب جديد أولاً',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              LaventButton(
                label: 'إنشاء طلب جديد',
                icon: Icons.add,
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/orders/new');
                },
              ),
            ],
          ),
        ),
      );
    }

    if (availableOrders.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 80,
                color: AppColors.statusDelivered.withOpacity(0.5),
              ),
              const SizedBox(height: 16),
              Text(
                'جميع الطلبات تم تسليمها',
                style: AppTextStyles.headlineSmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'لا يمكن إضافة سندات قبض للطلبات التي تم تسليمها',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Order Selection
            Text('اختر الطلب', style: AppTextStyles.labelMedium),
            const SizedBox(height: 8),
            DropdownButtonFormField<Order>(
              value: _selectedOrder,
              decoration: InputDecoration(
                hintText: 'اختر طلباً',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: availableOrders.map((order) {
                return DropdownMenuItem(
                  value: order,
                  child: Text(
                    '${order.orderNumber} - ${order.clientName}',
                    style: AppTextStyles.bodyMedium,
                  ),
                );
              }).toList(),
              onChanged: (order) async {
                setState(() => _selectedOrder = order);
                if (order != null) {
                  final totalPaid = await ref
                      .read(databaseProvider)
                      .getTotalPaidForOrder(order.id);
                  setState(() {
                    _remaining = order.totalPrice - totalPaid;
                  });
                }
              },
              validator: (val) => val == null ? 'اختر طلباً' : null,
            ),

            if (_selectedOrder != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surfaceSecondary.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('إجمالي الطلب', style: AppTextStyles.bodySmall),
                        Text(
                          Formatters.currency(_selectedOrder!.totalPrice),
                          style: AppTextStyles.bodyLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('المتبقي', style: AppTextStyles.bodySmall),
                        Text(
                          Formatters.currency(_remaining),
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: _remaining > 0
                                ? AppColors.error
                                : AppColors.statusDelivered,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 24),

            // Amount
            LaventTextField(
              label: 'المبلغ',
              controller: _amountController,
              keyboardType: TextInputType.number,
              suffixIcon: const Padding(
                padding: EdgeInsets.all(12),
                child: Text('ر.ي'),
              ),
              validator: (val) {
                final error = Validators.required(val, 'المبلغ');
                if (error != null) return error;
                final amount = Validators.parseDouble(val);
                if (amount <= 0) return 'المبلغ يجب أن يكون أكبر من صفر';
                if (amount > _remaining) {
                  return 'المبلغ يتجاوز المتبقي (${Formatters.currency(_remaining)})';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // Payment Method
            Text('طريقة الدفع', style: AppTextStyles.labelMedium),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: AppColors.cardSurface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.divider),
              ),
              child: Row(
                children: PaymentMethod.values.map((method) {
                  final isSelected = _paymentMethod == method;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _paymentMethod = method),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.accent : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              method == PaymentMethod.cash 
                                  ? Icons.payments_outlined 
                                  : Icons.account_balance_wallet_outlined,
                              size: 20,
                              color: isSelected ? Colors.white : AppColors.textSecondary,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              method.displayName,
                              style: TextStyle(
                                color: isSelected ? Colors.white : AppColors.textPrimary,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Wallet Type Selection (if wallet selected)
            if (_paymentMethod == PaymentMethod.wallet) ...[
              const SizedBox(height: 16),
              Text('اختر المحفظة', style: AppTextStyles.labelMedium),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: WalletType.values.map((wallet) {
                  final isSelected = _walletType == wallet;
                  return ChoiceChip(
                    label: Text(wallet.displayName),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) setState(() => _walletType = wallet);
                    },
                    selectedColor: AppColors.accent,
                    backgroundColor: AppColors.cardSurface,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                    ),
                  );
                }).toList(),
              ),
              if (_walletType == WalletType.other) ...[
                const SizedBox(height: 12),
                LaventTextField(
                  label: 'اسم المحفظة',
                  controller: _walletOtherController,
                  hintText: 'أدخل اسم المحفظة',
                ),
              ],
            ],

            const SizedBox(height: 16),

            // Notes
            LaventTextField(
              label: 'ملاحظات (اختياري)',
              controller: _notesController,
              maxLines: 3,
            ),

            const SizedBox(height: 32),

            // Save Button
            LaventButton(
              label: 'حفظ السند',
              icon: Icons.save_rounded,
              fullWidth: true,
              isLoading: _isLoading,
              onPressed: _saveReceipt,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveReceipt() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedOrder == null) return;

    setState(() => _isLoading = true);

    try {
      final amount = Validators.parseDouble(_amountController.text);

      // Build notes with wallet info if applicable
      String? notes = _notesController.text.isEmpty ? null : _notesController.text;
      if (_paymentMethod == PaymentMethod.wallet) {
        final walletName = _walletType == WalletType.other 
            ? _walletOtherController.text 
            : _walletType.displayName;
        notes = notes ?? '';
        notes = 'المحفظة: $walletName${notes.isNotEmpty ? '\n$notes' : ''}';
      }

      final db = ref.read(databaseProvider);
      await db.insertReceipt(ReceiptsCompanion.insert(
        receiptNumber: IdGenerator.generateReceiptNumber(),
        orderId: _selectedOrder!.id,
        amount: amount,
        date: DateTime.now(),
        paymentMethod: drift.Value(_paymentMethod.name),
        notes: drift.Value(notes),
      ));

      // Invalidate providers
      ref.invalidate(totalPaidForOrderProvider(_selectedOrder!.id));
      ref.invalidate(receiptsForOrderProvider(_selectedOrder!.id));
      ref.invalidate(allReceiptsProvider);
      ref.invalidate(dashboardStatsProvider);

      if (mounted) {
        AppToast.success(context, 'تم حفظ السند بنجاح ✅');
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        AppToast.error(context, 'حدث خطأ: $e');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}
