/// Lavent Luxury Abaya Manager - Application Constants
class AppConstants {
  AppConstants._();

  // ─────────────────────────────────────────────────────────────────────────────
  // APP INFO
  // ─────────────────────────────────────────────────────────────────────────────

  static const String appName = 'لافينت';
  static const String appNameEn = 'Lavent';
  static const String appTagline = 'إدارة الطلبات والفواتير';
  static const String version = '1.0.0';

  // ─────────────────────────────────────────────────────────────────────────────
  // ORDER NUMBER FORMAT
  // ─────────────────────────────────────────────────────────────────────────────

  /// Prefix for order numbers
  static const String orderNumberPrefix = 'LA';

  /// Length of numeric part of order number (8 digits)
  static const int orderNumberDigits = 8;

  // ─────────────────────────────────────────────────────────────────────────────
  // DATABASE
  // ─────────────────────────────────────────────────────────────────────────────

  static const String databaseName = 'lavent_database.db';
  static const int databaseVersion = 1;

  // ─────────────────────────────────────────────────────────────────────────────
  // BACKUP
  // ─────────────────────────────────────────────────────────────────────────────

  static const String backupFileExtension = '.lavent';
  static const String backupMimeType = 'application/json';

  // ─────────────────────────────────────────────────────────────────────────────
  // UI STRINGS (Arabic)
  // ─────────────────────────────────────────────────────────────────────────────

  // Navigation
  static const String navDashboard = 'لوحة التحكم';
  static const String navOrders = 'الطلبات';
  static const String navReceipts = 'سندات القبض';
  static const String navInvoices = 'الفواتير';
  static const String navSettings = 'الإعدادات';

  // Order Status
  static const String statusNew = 'جديد';
  static const String statusProcessing = 'قيد التنفيذ';
  static const String statusDelivered = 'تم التسليم';

  // Payment Methods
  static const String paymentCash = 'نقدي';
  static const String paymentCard = 'بطاقة';
  static const String paymentTransfer = 'تحويل';

  // Form Labels
  static const String labelOrderNumber = 'رقم الطلب';
  static const String labelOrderDate = 'تاريخ الطلب';
  static const String labelDeliveryDate = 'تاريخ التسليم';
  static const String labelStatus = 'الحالة';
  static const String labelTotalPrice = 'السعر الإجمالي';
  static const String labelPaidAmount = 'المبلغ المدفوع';
  static const String labelRemainingAmount = 'المبلغ المتبقي';
  static const String labelPaymentMethod = 'طريقة الدفع';
  static const String labelNotes = 'ملاحظات';

  // Client
  static const String labelClientName = 'اسم العميل';
  static const String labelClientPhone = 'رقم الجوال';
  static const String labelClientAddress = 'العنوان';

  // Abaya
  static const String labelAbayaType = 'نوع العباية';
  static const String labelAbayaNumber = 'رقم العباية';
  static const String labelLength = 'الطول';
  static const String labelShoulderWidth = 'عرض الكتف';
  static const String labelSleeveLength = 'طول الكم';
  static const String labelChest = 'الصدر';
  static const String labelWaist = 'الخصر';

  // Buttons
  static const String btnSave = 'حفظ';
  static const String btnCancel = 'إلغاء';
  static const String btnAdd = 'إضافة';
  static const String btnEdit = 'تعديل';
  static const String btnDelete = 'حذف';
  static const String btnPrint = 'طباعة';
  static const String btnAddReceipt = 'إضافة سند قبض';
  static const String btnPrintInvoice = 'طباعة الفاتورة';
  static const String btnBackup = 'نسخ احتياطي';
  static const String btnRestore = 'استعادة';

  // Messages
  static const String msgOrderCreated = 'تم إنشاء الطلب بنجاح';
  static const String msgOrderUpdated = 'تم تحديث الطلب بنجاح';
  static const String msgReceiptAdded = 'تم إضافة سند القبض بنجاح';
  static const String msgBackupSuccess = 'تم إنشاء النسخة الاحتياطية بنجاح';
  static const String msgRestoreSuccess = 'تمت الاستعادة بنجاح';

  // Errors
  static const String errRequired = 'هذا الحقل مطلوب';
  static const String errInvalidPhone = 'رقم الجوال غير صحيح';
  static const String errAmountExceedsRemaining = 'المبلغ أكبر من المتبقي';
  static const String errCannotAddReceiptDelivered =
      'لا يمكن إضافة سند لطلب تم تسليمه';
  static const String errCannotPrintInvoice =
      'لا يمكن طباعة الفاتورة - يجب سداد المبلغ المتبقي';

  // Confirmations
  static const String confirmDelete = 'هل أنت متأكد من الحذف؟';
  static const String confirmDeleteOrder =
      'سيتم حذف الطلب وجميع السندات المرتبطة به';

  // ─────────────────────────────────────────────────────────────────────────────
  // CURRENCY
  // ─────────────────────────────────────────────────────────────────────────────

  static const String currencyCode = 'SAR';
  static const String currencySymbol = 'ر.ي';
}
