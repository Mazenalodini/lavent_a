import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/utils/id_generator.dart';
import '../../../core/utils/validators.dart';
import '../../../data/local/database.dart';
import '../../../data/models/enums.dart';
import '../../../providers.dart';
import '../../common/lavent_button.dart';
import '../../common/lavent_card.dart';
import '../../common/lavent_text_field.dart';
import '../../common/status_badge.dart';

class OrderDetailScreen extends ConsumerStatefulWidget {
  final int orderId;

  const OrderDetailScreen({super.key, required this.orderId});

  @override
  ConsumerState<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends ConsumerState<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final orderAsync = ref.watch(orderByIdProvider(widget.orderId));
    final receiptsAsync = ref.watch(receiptsForOrderProvider(widget.orderId));
    final totalPaidAsync = ref.watch(totalPaidForOrderProvider(widget.orderId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل الطلب'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_rounded),
            onPressed: () async {
              await Navigator.pushNamed(context, '/orders/edit',
                  arguments: widget.orderId);
              // Refresh data after returning from edit
              ref.invalidate(orderByIdProvider(widget.orderId));
            },
          ),
        ],
      ),
      body: orderAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('خطأ: $err')),
        data: (order) {
          if (order == null) {
            return const Center(child: Text('الطلب غير موجود'));
          }

          final status = OrderStatus.fromName(order.status);
          final totalPaid = totalPaidAsync.valueOrNull ?? 0.0;
          final remaining = order.totalPrice - totalPaid;
          final canAddReceipt =
              status != OrderStatus.delivered && remaining > 0;
          final canPrintInvoice =
              status == OrderStatus.delivered && remaining <= 0;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Order Header
                LaventCard(
                  margin: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(order.orderNumber,
                                    style: AppTextStyles.orderNumber),
                                const SizedBox(height: 4),
                                Text(order.clientName,
                                    style: AppTextStyles.headlineMedium),
                              ],
                            ),
                          ),
                          StatusBadge(status: status),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildInfoItem(Icons.phone, 'الجوال',
                          Formatters.phone(order.clientPhone)),
                      if (order.clientAddress != null)
                        _buildInfoItem(Icons.location_on, 'العنوان',
                            order.clientAddress!),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Status Change Section
                LaventCard(
                  margin: EdgeInsets.zero,
                  color: AppColors.accent.withOpacity(0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('تغيير حالة الطلب',
                          style: AppTextStyles.headlineSmall),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _StatusButton(
                              label: 'جديد',
                              status: OrderStatus.newOrder,
                              isSelected: status == OrderStatus.newOrder,
                              onTap: () => _updateStatus(order, OrderStatus.newOrder),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _StatusButton(
                              label: 'قيد التنفيذ',
                              status: OrderStatus.processing,
                              isSelected: status == OrderStatus.processing,
                              onTap: () => _updateStatus(order, OrderStatus.processing),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _StatusButton(
                              label: 'تم التسليم',
                              status: OrderStatus.delivered,
                              isSelected: status == OrderStatus.delivered,
                              onTap: () => _updateStatus(order, OrderStatus.delivered),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Abaya Info
                LaventCard(
                  margin: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('بيانات العباية', style: AppTextStyles.headlineSmall),
                      const SizedBox(height: 12),
                      _buildInfoItem(Icons.checkroom, 'النوع', order.abayaType),
                      if (order.abayaNumber != null)
                        _buildInfoItem(Icons.tag, 'الرقم', order.abayaNumber!),
                      const SizedBox(height: 8),
                      _buildInfoItem(Icons.calendar_today, 'تاريخ الطلب',
                          Formatters.date(order.orderDate)),
                      if (order.deliveryDate != null)
                        _buildInfoItem(Icons.event, 'تاريخ التسليم',
                            Formatters.date(order.deliveryDate!)),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Financial Summary
                LaventCard(
                  margin: EdgeInsets.zero,
                  color: AppColors.surfaceSecondary.withOpacity(0.3),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('إجمالي الطلب',
                              style: AppTextStyles.bodyLarge),
                          Text(Formatters.currency(order.totalPrice),
                              style: AppTextStyles.price),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('المدفوع', style: AppTextStyles.bodyLarge),
                          Text(
                            Formatters.currency(totalPaid),
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: AppColors.statusDelivered,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Divider(),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('المتبقي',
                              style: AppTextStyles.headlineSmall),
                          Text(
                            Formatters.currency(remaining),
                            style: AppTextStyles.headlineSmall.copyWith(
                              color: remaining > 0
                                  ? AppColors.error
                                  : AppColors.statusDelivered,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Receipts Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('سندات القبض', style: AppTextStyles.headlineSmall),
                    if (canAddReceipt)
                      TextButton.icon(
                        onPressed: () => _showAddReceiptDialog(order, remaining),
                        icon: const Icon(Icons.add),
                        label: const Text('إضافة'),
                      ),
                  ],
                ),

                receiptsAsync.when(
                  loading: () => const Center(
                      child: Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  )),
                  error: (err, _) => Text('خطأ: $err'),
                  data: (receiptsList) {
                    final hasInitialPayment = (order.initialPayment ?? 0) > 0;
                    final noPayments = receiptsList.isEmpty && !hasInitialPayment;
                    
                    if (noPayments) {
                      return Padding(
                        padding: const EdgeInsets.all(24),
                        child: Center(
                          child: Text(
                            'لا توجد مدفوعات',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      );
                    }
                    
                    return Column(
                      children: [
                        // Initial Payment (if exists)
                        if (hasInitialPayment)
                          _InitialPaymentCard(
                            amount: order.initialPayment!,
                            date: order.orderDate,
                            paymentMethod: order.initialPaymentMethod,
                          ),
                        // Receipts
                        ...receiptsList.map((r) => _ReceiptCard(receipt: r)),
                      ],
                    );
                  },
                ),

                // Cannot add receipt warning
                if (status == OrderStatus.delivered && remaining > 0)
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.warning_rounded,
                            color: AppColors.warning, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            AppConstants.errCannotAddReceiptDelivered,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.warning,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 24),

                // Print Invoice Button
                if (status == OrderStatus.delivered)
                  LaventButton(
                    label: AppConstants.btnPrintInvoice,
                    icon: Icons.picture_as_pdf_rounded,
                    fullWidth: true,
                    onPressed: canPrintInvoice
                        ? () => Navigator.pushNamed(
                            context, '/invoices/preview',
                            arguments: widget.orderId)
                        : null,
                  ),

                if (status == OrderStatus.delivered && !canPrintInvoice)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Center(
                      child: Text(
                        AppConstants.errCannotPrintInvoice,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.error,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.textSecondary),
          const SizedBox(width: 8),
          Text('$label: ', style: AppTextStyles.bodySmall),
          Flexible(
            child: Text(value, style: AppTextStyles.bodyMedium),
          ),
        ],
      ),
    );
  }

  Future<void> _updateStatus(Order order, OrderStatus newStatus) async {
    if (OrderStatus.fromName(order.status) == newStatus) return;

    // Check if trying to set status to delivered
    if (newStatus == OrderStatus.delivered) {
      final db = ref.read(databaseProvider);
      final totalPaid = await db.getTotalPaidForOrder(order.id);
      final remaining = order.totalPrice - totalPaid;

      if (remaining > 0) {
        // Show warning - cannot deliver with remaining balance
        if (mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              icon: Icon(Icons.warning_amber_rounded, color: AppColors.warning, size: 48),
              title: const Text('لا يمكن تغيير الحالة'),
              content: Text(
                'لا يمكن تغيير حالة الطلب إلى "تم التسليم" لأن هناك مبلغ متبقي: ${Formatters.currency(remaining)}',
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('حسناً'),
                ),
              ],
            ),
          );
        }
        return;
      }
    }

    try {
      final db = ref.read(databaseProvider);
      await db.updateOrderById(
        order.id,
        OrdersCompanion(
          status: drift.Value(newStatus.name),
          updatedAt: drift.Value(DateTime.now()),
        ),
      );

      ref.invalidate(orderByIdProvider(widget.orderId));
      ref.invalidate(allOrdersProvider);
      ref.invalidate(dashboardStatsProvider);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تم تغيير الحالة إلى ${newStatus.displayName}')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ: $e')),
        );
      }
    }
  }

  void _showAddReceiptDialog(Order order, double maxAmount) {
    final amountController = TextEditingController();
    final notesController = TextEditingController();
    final walletOtherController = TextEditingController();
    PaymentMethod paymentMethod = PaymentMethod.cash;
    WalletType walletType = WalletType.kareemi;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 24,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('إضافة سند قبض', style: AppTextStyles.headlineMedium),
                const SizedBox(height: 8),
                Text(
                  'المتبقي: ${Formatters.currency(maxAmount)}',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.accent,
                  ),
                ),
                const SizedBox(height: 24),
                LaventTextField(
                  label: 'المبلغ',
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  suffixIcon: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('ر.ي'),
                  ),
                ),
                const SizedBox(height: 16),
                // Payment Method Selection
                Text('طريقة الدفع', style: AppTextStyles.labelMedium),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _PaymentMethodButton(
                        label: 'نقدي',
                        icon: Icons.payments_rounded,
                        isSelected: paymentMethod == PaymentMethod.cash,
                        onTap: () => setModalState(() => paymentMethod = PaymentMethod.cash),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _PaymentMethodButton(
                        label: 'محفظة',
                        icon: Icons.account_balance_wallet_rounded,
                        isSelected: paymentMethod == PaymentMethod.wallet,
                        onTap: () => setModalState(() => paymentMethod = PaymentMethod.wallet),
                      ),
                    ),
                  ],
                ),
                // Wallet Type Selection (shown when wallet is selected)
                if (paymentMethod == PaymentMethod.wallet) ...[
                  const SizedBox(height: 16),
                  Text('اختر المحفظة', style: AppTextStyles.labelMedium),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: WalletType.values.map((type) {
                      final isSelected = walletType == type;
                      return ChoiceChip(
                        label: Text(type.displayName),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) setModalState(() => walletType = type);
                        },
                        selectedColor: AppColors.accent.withOpacity(0.2),
                        backgroundColor: AppColors.surfaceSecondary,
                        labelStyle: TextStyle(
                          color: isSelected ? AppColors.accent : AppColors.textPrimary,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        ),
                      );
                    }).toList(),
                  ),
                  // Other wallet name field
                  if (walletType == WalletType.other) ...[
                    const SizedBox(height: 12),
                    LaventTextField(
                      label: 'اسم المحفظة',
                      controller: walletOtherController,
                      hintText: 'أدخل اسم المحفظة',
                    ),
                  ],
                ],
                const SizedBox(height: 16),
                LaventTextField(
                  label: 'ملاحظات (اختياري)',
                  controller: notesController,
                ),
                const SizedBox(height: 24),
                LaventButton(
                  label: 'حفظ السند',
                  icon: Icons.save,
                  fullWidth: true,
                  onPressed: () async {
                    final amount =
                        Validators.parseDouble(amountController.text);

                    if (amount <= 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('يرجى إدخال مبلغ صحيح')),
                      );
                      return;
                    }

                    if (amount > maxAmount) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text(AppConstants.errAmountExceedsRemaining)),
                      );
                      return;
                    }

                    // Build payment method string
                    String paymentMethodStr = paymentMethod.name;
                    if (paymentMethod == PaymentMethod.wallet) {
                      if (walletType == WalletType.other && walletOtherController.text.isNotEmpty) {
                        paymentMethodStr = 'wallet_${walletOtherController.text}';
                      } else {
                        paymentMethodStr = 'wallet_${walletType.name}';
                      }
                    }

                    final db = ref.read(databaseProvider);
                    await db.insertReceipt(ReceiptsCompanion.insert(
                      receiptNumber: IdGenerator.generateReceiptNumber(),
                      orderId: order.id,
                      amount: amount,
                      date: DateTime.now(),
                      paymentMethod: drift.Value(paymentMethodStr),
                      notes: drift.Value(
                          notesController.text.isEmpty
                              ? null
                              : notesController.text),
                    ));

                    ref.invalidate(totalPaidForOrderProvider(order.id));
                    ref.invalidate(receiptsForOrderProvider(order.id));
                    ref.invalidate(dashboardStatsProvider);

                    if (context.mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(AppConstants.msgReceiptAdded)),
                      );
                    }
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Payment method button widget
}

class _PaymentMethodButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentMethodButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accent : AppColors.surfaceSecondary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.accent : AppColors.divider,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : AppColors.textSecondary,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.textPrimary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusButton extends StatelessWidget {
  final String label;
  final OrderStatus status;
  final bool isSelected;
  final VoidCallback onTap;

  const _StatusButton({
    required this.label,
    required this.status,
    required this.isSelected,
    required this.onTap,
  });

  Color get _statusColor {
    switch (status) {
      case OrderStatus.newOrder:
        return AppColors.statusNew;
      case OrderStatus.processing:
        return AppColors.statusProcessing;
      case OrderStatus.delivered:
        return AppColors.statusDelivered;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? _statusColor : _statusColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _statusColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: isSelected ? Colors.white : _statusColor,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class _ReceiptCard extends StatelessWidget {
  final Receipt receipt;

  const _ReceiptCard({required this.receipt});

  @override
  Widget build(BuildContext context) {
    final method = PaymentMethod.fromName(receipt.paymentMethod);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final successColor = isDark ? AppColors.darkStatusDelivered : AppColors.statusDelivered;

    return LaventCard(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: successColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.receipt_long_rounded,
              color: successColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(receipt.receiptNumber, style: AppTextStyles.labelSmall),
                const SizedBox(height: 2),
                Text(Formatters.date(receipt.date),
                    style: AppTextStyles.bodySmall),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                Formatters.currency(receipt.amount),
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                  color: successColor,
                ),
              ),
              Text(method.displayName, style: AppTextStyles.bodySmall),
            ],
          ),
        ],
      ),
    );
  }
}

/// Widget to display initial payment (دفعة مقدمة)
class _InitialPaymentCard extends StatelessWidget {
  final double amount;
  final DateTime date;
  final String? paymentMethod;

  const _InitialPaymentCard({
    required this.amount,
    required this.date,
    this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    final method = paymentMethod != null 
        ? PaymentMethod.fromName(paymentMethod!) 
        : PaymentMethod.cash;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accentColor = isDark ? AppColors.darkAccentSecondary : AppColors.accentSecondary;

    return LaventCard(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.payments_rounded,
              color: accentColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('دفعة مقدمة', style: AppTextStyles.labelSmall.copyWith(
                  fontWeight: FontWeight.w600,
                )),
                const SizedBox(height: 2),
                Text(Formatters.date(date),
                    style: AppTextStyles.bodySmall),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                Formatters.currency(amount),
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                  color: accentColor,
                ),
              ),
              Text(method.displayName, style: AppTextStyles.bodySmall),
            ],
          ),
        ],
      ),
    );
  }
}
