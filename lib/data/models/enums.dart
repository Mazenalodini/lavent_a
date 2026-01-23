/// Order Status Enum
enum OrderStatus {
  /// New order - just created
  newOrder('جديد'),

  /// In progress - being worked on
  processing('قيد التنفيذ'),

  /// Delivered to customer
  delivered('تم التسليم');

  final String displayName;
  const OrderStatus(this.displayName);

  /// Get status from string name
  static OrderStatus fromName(String name) {
    return OrderStatus.values.firstWhere(
      (e) => e.name == name,
      orElse: () => OrderStatus.newOrder,
    );
  }
}

/// Payment Method Enum (نقدي أو محفظة)
enum PaymentMethod {
  /// Cash payment
  cash('نقدي'),

  /// Wallet payment
  wallet('محفظة');

  final String displayName;
  const PaymentMethod(this.displayName);

  /// Get method from string name
  static PaymentMethod fromName(String name) {
    return PaymentMethod.values.firstWhere(
      (e) => e.name == name,
      orElse: () => PaymentMethod.cash,
    );
  }
}

/// Measurement Type Enum (مقاس عام أو مقاس خاص)
enum MeasurementType {
  /// General measurement - single size value
  general('مقاس عام'),

  /// Custom measurement - individual measurements
  custom('مقاس خاص');

  final String displayName;
  const MeasurementType(this.displayName);

  /// Get type from string name
  static MeasurementType fromName(String name) {
    return MeasurementType.values.firstWhere(
      (e) => e.name == name,
      orElse: () => MeasurementType.general,
    );
  }
}

/// Order Source Enum (جهة الطلب)
enum OrderSource {
  whatsapp('واتساب'),
  telegram('تيليجرام'),
  instagram('انستجرام'),
  tiktok('تيك توك'),
  other('أخرى');

  final String displayName;
  const OrderSource(this.displayName);

  /// Get source from string name
  static OrderSource fromName(String name) {
    return OrderSource.values.firstWhere(
      (e) => e.name == name,
      orElse: () => OrderSource.whatsapp,
    );
  }
}

/// Wallet Type Enum (المحافظ اليمنية)
enum WalletType {
  kareemi('كريمي'),
  jawali('جوالي'),
  jeeb('جيب'),
  onecash('ون كاش'),
  floosak('فلوسك'),
  mahfazati('محفظتي'),
  other('أخرى');

  final String displayName;
  const WalletType(this.displayName);

  /// Get wallet from string name
  static WalletType fromName(String name) {
    return WalletType.values.firstWhere(
      (e) => e.name == name,
      orElse: () => WalletType.kareemi,
    );
  }
}
