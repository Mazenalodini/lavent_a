import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/services/notification_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/app_toast.dart';
import '../../../core/utils/validators.dart';
import '../../../data/local/database.dart';
import '../../../data/models/enums.dart';
import '../../../providers.dart';
import '../../common/lavent_button.dart';
import '../../common/lavent_text_field.dart';
import '../../common/status_badge.dart';

class OrderFormScreen extends ConsumerStatefulWidget {
  final int? orderId;

  const OrderFormScreen({super.key, this.orderId});

  @override
  ConsumerState<OrderFormScreen> createState() => _OrderFormScreenState();
}

class _OrderFormScreenState extends ConsumerState<OrderFormScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isEditMode = false;
  Order? _existingOrder;

  // Form Controllers
  late TextEditingController _clientNameController;
  late TextEditingController _clientPhoneController;
  late TextEditingController _clientAddressController;
  late TextEditingController _abayaTypeController;
  late TextEditingController _abayaNumberController;
  late TextEditingController _totalPriceController;
  late TextEditingController _initialPaymentController;
  late TextEditingController _notesController;

  // Measurements
  late TextEditingController _generalSizeController;
  late TextEditingController _measurementNotesController;
  late TextEditingController _lengthController;
  late TextEditingController _shoulderController;
  late TextEditingController _sleeveController;
  late TextEditingController _chestController;
  late TextEditingController _waistController;

  // Order Source
  late TextEditingController _orderSourceOtherController;

  // Wallet
  late TextEditingController _walletNameOtherController;

  DateTime _orderDate = DateTime.now();
  DateTime? _deliveryDate;
  OrderStatus _status = OrderStatus.newOrder;
  MeasurementType _measurementType = MeasurementType.general;
  OrderSource _orderSource = OrderSource.whatsapp;
  PaymentMethod _initialPaymentMethod = PaymentMethod.cash;
  WalletType _walletType = WalletType.kareemi;

  @override
  void initState() {
    super.initState();
    _initControllers();

    if (widget.orderId != null) {
      _isEditMode = true;
      _loadOrder();
    }
  }

  void _initControllers() {
    _clientNameController = TextEditingController();
    _clientPhoneController = TextEditingController();
    _clientAddressController = TextEditingController();
    _abayaTypeController = TextEditingController();
    _abayaNumberController = TextEditingController();
    _totalPriceController = TextEditingController();
    _initialPaymentController = TextEditingController(text: '0');
    _notesController = TextEditingController();
    _generalSizeController = TextEditingController();
    _measurementNotesController = TextEditingController();
    _lengthController = TextEditingController();
    _shoulderController = TextEditingController();
    _sleeveController = TextEditingController();
    _chestController = TextEditingController();
    _waistController = TextEditingController();
    _orderSourceOtherController = TextEditingController();
    _walletNameOtherController = TextEditingController();
  }

  Future<void> _loadOrder() async {
    final db = ref.read(databaseProvider);
    final order = await db.getOrderById(widget.orderId!);
    if (order != null && mounted) {
      setState(() {
        _existingOrder = order;
        _clientNameController.text = order.clientName;
        _clientPhoneController.text = order.clientPhone;
        _clientAddressController.text = order.clientAddress ?? '';
        _abayaTypeController.text = order.abayaType;
        _abayaNumberController.text = order.abayaNumber ?? '';
        _totalPriceController.text = order.totalPrice.toString();
        _initialPaymentController.text = order.initialPayment.toString();
        _notesController.text = order.orderNotes ?? '';
        _orderDate = order.orderDate;
        _deliveryDate = order.deliveryDate;
        _status = OrderStatus.fromName(order.status);

        // Load measurement type and values
        _measurementType = MeasurementType.fromName(order.measurementType);
        _generalSizeController.text = order.generalSize ?? '';
        _measurementNotesController.text = order.measurementNotes ?? '';
        _lengthController.text = order.length?.toString() ?? '';
        _shoulderController.text = order.shoulder?.toString() ?? '';
        _sleeveController.text = order.sleeve?.toString() ?? '';
        _chestController.text = order.chest?.toString() ?? '';
        _waistController.text = order.waist?.toString() ?? '';

        // Load order source
        _orderSource = OrderSource.fromName(order.orderSource);
        _orderSourceOtherController.text = order.orderSourceOther ?? '';

        // Load payment method and wallet
        _initialPaymentMethod = PaymentMethod.fromName(order.initialPaymentMethod);
        if (order.walletName != null) {
          _walletType = WalletType.fromName(order.walletName!);
          _walletNameOtherController.text = order.walletNameOther ?? '';
        }
      });
    }
  }

  @override
  void dispose() {
    _clientNameController.dispose();
    _clientPhoneController.dispose();
    _clientAddressController.dispose();
    _abayaTypeController.dispose();
    _abayaNumberController.dispose();
    _totalPriceController.dispose();
    _initialPaymentController.dispose();
    _notesController.dispose();
    _generalSizeController.dispose();
    _measurementNotesController.dispose();
    _lengthController.dispose();
    _shoulderController.dispose();
    _sleeveController.dispose();
    _chestController.dispose();
    _waistController.dispose();
    _orderSourceOtherController.dispose();
    _walletNameOtherController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? 'تعديل الطلب' : 'طلب جديد'),
        actions: [
          if (_isEditMode)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: _confirmDelete,
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Status (Edit Mode Only)
            if (_isEditMode) ...[
              _SectionHeader(title: 'حالة الطلب'),
              Row(
                children: [
                  StatusBadge(status: _status),
                  const SizedBox(width: 16),
                  Expanded(
                    child: LaventDropdown<OrderStatus>(
                      label: 'تغيير الحالة',
                      value: _status,
                      items: OrderStatus.values
                          .map((s) => DropdownMenuItem(
                                value: s,
                                child: Text(s.displayName),
                              ))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _status = val);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],

            // Client Info Section
            _SectionHeader(title: 'بيانات العميل'),
            LaventTextField(
              label: AppConstants.labelClientName,
              controller: _clientNameController,
              validator: (v) => Validators.required(v, 'اسم العميل'),
            ),
            const SizedBox(height: 16),
            LaventTextField(
              label: AppConstants.labelClientPhone,
              controller: _clientPhoneController,
              keyboardType: TextInputType.phone,
              validator: Validators.phone,
            ),
            const SizedBox(height: 16),
            LaventTextField(
              label: AppConstants.labelClientAddress,
              controller: _clientAddressController,
              maxLines: 2,
            ),

            const SizedBox(height: 24),

            // Abaya Info Section
            _SectionHeader(title: 'بيانات العباية'),
            LaventTextField(
              label: AppConstants.labelAbayaType,
              controller: _abayaTypeController,
              validator: (v) => Validators.required(v, 'نوع العباية'),
            ),
            const SizedBox(height: 16),
            LaventTextField(
              label: AppConstants.labelAbayaNumber,
              controller: _abayaNumberController,
            ),

            const SizedBox(height: 24),

            // Measurements Section
            _SectionHeader(title: 'المقاسات'),
            _buildMeasurementTypeSelector(),
            const SizedBox(height: 16),
            if (_measurementType == MeasurementType.general)
              _buildGeneralMeasurements()
            else
              _buildCustomMeasurements(),
            const SizedBox(height: 16),
            LaventTextField(
              label: 'ملاحظات المقاسات',
              controller: _measurementNotesController,
              maxLines: 2,
            ),

            const SizedBox(height: 24),

            // Dates Section
            _SectionHeader(title: 'التواريخ'),
            LaventDateField(
              label: AppConstants.labelOrderDate,
              value: _orderDate,
              onChanged: (d) => setState(() => _orderDate = d),
            ),
            const SizedBox(height: 16),
            LaventDateField(
              label: AppConstants.labelDeliveryDate,
              value: _deliveryDate,
              onChanged: (d) => setState(() => _deliveryDate = d),
              firstDate: DateTime.now(),
            ),

            const SizedBox(height: 24),

            // Order Source Section
            _SectionHeader(title: 'جهة الطلب'),
            _buildOrderSourceSelector(),

            const SizedBox(height: 24),

            // Financial Section
            _SectionHeader(title: 'المبالغ'),
            LaventTextField(
              label: AppConstants.labelTotalPrice,
              controller: _totalPriceController,
              keyboardType: TextInputType.number,
              validator: (v) => Validators.positiveNumber(v, 'السعر'),
              suffixIcon: const Padding(
                padding: EdgeInsets.all(12),
                child: Text('ر.ي'),
              ),
            ),
            const SizedBox(height: 16),
            _buildInitialPaymentSection(),

            const SizedBox(height: 24),

            // Notes
            _SectionHeader(title: 'ملاحظات'),
            LaventTextField(
              label: AppConstants.labelNotes,
              controller: _notesController,
              maxLines: 3,
            ),

            const SizedBox(height: 32),

            // Submit Button
            LaventButton(
              label: _isEditMode ? 'حفظ التغييرات' : 'إنشاء الطلب',
              icon: Icons.save_rounded,
              isLoading: _isLoading,
              fullWidth: true,
              onPressed: _saveOrder,
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  /// Measurement Type Selector (مقاس عام / مقاس خاص)
  Widget _buildMeasurementTypeSelector() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: MeasurementType.values.map((type) {
          final isSelected = _measurementType == type;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _measurementType = type),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.accent : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  type.displayName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textPrimary,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  /// General Measurement (single field)
  Widget _buildGeneralMeasurements() {
    return LaventTextField(
      label: 'المقاس العام',
      controller: _generalSizeController,
      keyboardType: TextInputType.text,
      hintText: 'مثال: 52',
    );
  }

  /// Custom Measurements (5 fields)
  Widget _buildCustomMeasurements() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: LaventTextField(
                label: AppConstants.labelLength,
                controller: _lengthController,
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: LaventTextField(
                label: AppConstants.labelShoulderWidth,
                controller: _shoulderController,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: LaventTextField(
                label: AppConstants.labelSleeveLength,
                controller: _sleeveController,
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: LaventTextField(
                label: AppConstants.labelChest,
                controller: _chestController,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        LaventTextField(
          label: AppConstants.labelWaist,
          controller: _waistController,
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  /// Order Source Selector
  Widget _buildOrderSourceSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: OrderSource.values.map((source) {
            final isSelected = _orderSource == source;
            return ChoiceChip(
              label: Text(source.displayName),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) setState(() => _orderSource = source);
              },
              selectedColor: AppColors.accent,
              backgroundColor: AppColors.cardSurface,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : AppColors.textPrimary,
              ),
            );
          }).toList(),
        ),
        if (_orderSource == OrderSource.other) ...[
          const SizedBox(height: 12),
          LaventTextField(
            label: 'اسم الجهة',
            controller: _orderSourceOtherController,
            hintText: 'أدخل اسم الجهة',
          ),
        ],
      ],
    );
  }

  /// Initial Payment Section
  Widget _buildInitialPaymentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LaventTextField(
          label: 'المبلغ المدفوع مسبقاً',
          controller: _initialPaymentController,
          keyboardType: TextInputType.number,
          validator: (v) {
            if (v == null || v.isEmpty) return null;
            final value = double.tryParse(v);
            if (value == null) return 'أدخل رقم صحيح';
            if (value > 0 && value < 3000) return 'الحد الأدنى 3000 ر.ي';
            // Check if initial payment exceeds total price
            final totalPrice = double.tryParse(_totalPriceController.text) ?? 0;
            if (totalPrice > 0 && value > totalPrice) {
              return 'المبلغ المدفوع يتجاوز إجمالي الطلب';
            }
            return null;
          },
          suffixIcon: const Padding(
            padding: EdgeInsets.all(12),
            child: Text('ر.ي'),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'طريقة الدفع المسبق',
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 8),
        _buildPaymentMethodSelector(),
        if (_initialPaymentMethod == PaymentMethod.wallet) ...[
          const SizedBox(height: 16),
          _buildWalletSelector(),
        ],
      ],
    );
  }

  /// Payment Method Selector (Cash / Wallet)
  Widget _buildPaymentMethodSelector() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: PaymentMethod.values.map((method) {
          final isSelected = _initialPaymentMethod == method;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _initialPaymentMethod = method),
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
                      method == PaymentMethod.cash ? Icons.payments_outlined : Icons.account_balance_wallet_outlined,
                      size: 20,
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                    ),
                    const SizedBox(width: 8),
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
    );
  }

  /// Wallet Selector (Yemeni Wallets)
  Widget _buildWalletSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'اختر المحفظة',
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
        ),
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
            controller: _walletNameOtherController,
            hintText: 'أدخل اسم المحفظة',
          ),
        ],
      ],
    );
  }

  Future<void> _saveOrder() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final db = ref.read(databaseProvider);

      // Get wallet name based on selection
      String? walletName;
      String? walletNameOther;
      if (_initialPaymentMethod == PaymentMethod.wallet) {
        walletName = _walletType.name;
        if (_walletType == WalletType.other) {
          walletNameOther = Validators.clean(_walletNameOtherController.text);
        }
      }

      // Get order source other
      String? orderSourceOther;
      if (_orderSource == OrderSource.other) {
        orderSourceOther = Validators.clean(_orderSourceOtherController.text);
      }

      if (_isEditMode && _existingOrder != null) {
        // Update existing order
        await db.updateOrderById(
          _existingOrder!.id,
          OrdersCompanion(
            id: drift.Value(_existingOrder!.id),
            orderNumber: drift.Value(_existingOrder!.orderNumber),
            clientName: drift.Value(Validators.clean(_clientNameController.text)),
            clientPhone: drift.Value(Validators.clean(_clientPhoneController.text)),
            clientAddress: drift.Value(
                Validators.clean(_clientAddressController.text).isEmpty
                    ? null
                    : Validators.clean(_clientAddressController.text)),
            abayaType: drift.Value(Validators.clean(_abayaTypeController.text)),
            abayaNumber: drift.Value(
                Validators.clean(_abayaNumberController.text).isEmpty
                    ? null
                    : Validators.clean(_abayaNumberController.text)),
            totalPrice: drift.Value(Validators.parseDouble(_totalPriceController.text)),
            initialPayment: drift.Value(Validators.parseDouble(_initialPaymentController.text)),
            initialPaymentMethod: drift.Value(_initialPaymentMethod.name),
            orderDate: drift.Value(_orderDate),
            deliveryDate: drift.Value(_deliveryDate),
            status: drift.Value(_status.name),
            // Order source
            orderSource: drift.Value(_orderSource.name),
            orderSourceOther: drift.Value(orderSourceOther),
            // Wallet
            walletName: drift.Value(walletName),
            walletNameOther: drift.Value(walletNameOther),
            // Measurements
            measurementType: drift.Value(_measurementType.name),
            generalSize: drift.Value(
                Validators.clean(_generalSizeController.text).isEmpty
                    ? null
                    : Validators.clean(_generalSizeController.text)),
            measurementNotes: drift.Value(
                Validators.clean(_measurementNotesController.text).isEmpty
                    ? null
                    : Validators.clean(_measurementNotesController.text)),
            length: drift.Value(Validators.parseDouble(_lengthController.text)),
            shoulder: drift.Value(Validators.parseDouble(_shoulderController.text)),
            sleeve: drift.Value(Validators.parseDouble(_sleeveController.text)),
            chest: drift.Value(Validators.parseDouble(_chestController.text)),
            waist: drift.Value(Validators.parseDouble(_waistController.text)),
            orderNotes: drift.Value(Validators.clean(_notesController.text).isEmpty
                ? null
                : Validators.clean(_notesController.text)),
            updatedAt: drift.Value(DateTime.now()),
          ),
        );

        if (mounted) {
          AppToast.success(context, 'تم تحديث الطلب بنجاح ✅');
          Navigator.pop(context);
        }
      } else {
        // Create new order
        final orderNumber = await db.getNextOrderNumber();

        final orderId = await db.insertOrder(OrdersCompanion.insert(
          orderNumber: orderNumber,
          orderDate: _orderDate,
          deliveryDate: drift.Value(_deliveryDate),
          totalPrice: Validators.parseDouble(_totalPriceController.text),
          initialPayment: drift.Value(Validators.parseDouble(_initialPaymentController.text)),
          initialPaymentMethod: drift.Value(_initialPaymentMethod.name),
          clientName: Validators.clean(_clientNameController.text),
          clientPhone: Validators.clean(_clientPhoneController.text),
          clientAddress: drift.Value(
              Validators.clean(_clientAddressController.text).isEmpty
                  ? null
                  : Validators.clean(_clientAddressController.text)),
          abayaType: Validators.clean(_abayaTypeController.text),
          abayaNumber: drift.Value(
              Validators.clean(_abayaNumberController.text).isEmpty
                  ? null
                  : Validators.clean(_abayaNumberController.text)),
          // Order source
          orderSource: drift.Value(_orderSource.name),
          orderSourceOther: drift.Value(orderSourceOther),
          // Wallet
          walletName: drift.Value(walletName),
          walletNameOther: drift.Value(walletNameOther),
          // Measurements
          measurementType: drift.Value(_measurementType.name),
          generalSize: drift.Value(
              Validators.clean(_generalSizeController.text).isEmpty
                  ? null
                  : Validators.clean(_generalSizeController.text)),
          measurementNotes: drift.Value(
              Validators.clean(_measurementNotesController.text).isEmpty
                  ? null
                  : Validators.clean(_measurementNotesController.text)),
          length: drift.Value(Validators.parseDouble(_lengthController.text)),
          shoulder: drift.Value(Validators.parseDouble(_shoulderController.text)),
          sleeve: drift.Value(Validators.parseDouble(_sleeveController.text)),
          chest: drift.Value(Validators.parseDouble(_chestController.text)),
          waist: drift.Value(Validators.parseDouble(_waistController.text)),
          orderNotes: drift.Value(Validators.clean(_notesController.text).isEmpty
              ? null
              : Validators.clean(_notesController.text)),
        ));

        // Schedule delivery reminders if delivery date is set
        if (_deliveryDate != null) {
          await NotificationService().scheduleDeliveryReminders(
            orderId: orderId,
            orderNumber: orderNumber,
            clientName: Validators.clean(_clientNameController.text),
            deliveryDate: _deliveryDate!,
          );
        }

        if (mounted) {
          AppToast.success(context, 'تم إنشاء الطلب $orderNumber ✅');
          Navigator.pop(context);
        }
      }
    } catch (e) {
      if (mounted) {
        AppToast.error(context, 'حدث خطأ: $e');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _confirmDelete() async {
    final confirmed = await AppDialog.confirmArchive(
      context,
      message: 'سيتم نقل الطلب إلى الأرشيف. يمكنك استعادته لاحقاً من الإعدادات.',
    );
    
    if (confirmed) {
      await _archiveOrder();
    }
  }

  Future<void> _archiveOrder() async {
    if (widget.orderId == null) return;

    setState(() => _isLoading = true);
    try {
      final db = ref.read(databaseProvider);
      await db.archiveOrder(widget.orderId!);

      // Cancel any scheduled notifications for this order
      await NotificationService().cancelOrderReminders(widget.orderId!);

      if (mounted) {
        AppToast.withUndo(
          context,
          message: 'تم أرشفة الطلب',
          onUndo: () async {
            await db.unarchiveOrder(widget.orderId!);
            ref.invalidate(allOrdersProvider);
          },
        );
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

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: AppTextStyles.headlineSmall.copyWith(
          color: AppColors.accent,
        ),
      ),
    );
  }
}
