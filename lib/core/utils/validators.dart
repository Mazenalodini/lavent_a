/// Utility class for input validation
class Validators {
  Validators._();

  /// Validate required field
  static String? required(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return fieldName != null ? '$fieldName مطلوب' : 'هذا الحقل مطلوب';
    }
    return null;
  }

  /// Validate phone number (Saudi format)
  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'رقم الجوال مطلوب';
    }

    // Remove any non-digit characters
    final digits = value.replaceAll(RegExp(r'\D'), '');

    // Saudi mobile: starts with 05 and is 10 digits
    if (!RegExp(r'^05\d{8}$').hasMatch(digits)) {
      return 'رقم الجوال غير صحيح (يجب أن يبدأ بـ 05)';
    }

    return null;
  }

  /// Validate positive number
  static String? positiveNumber(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return fieldName != null ? '$fieldName مطلوب' : 'هذا الحقل مطلوب';
    }

    final number = double.tryParse(value);
    if (number == null) {
      return 'يرجى إدخال رقم صحيح';
    }

    if (number < 0) {
      return 'يجب أن يكون الرقم موجبًا';
    }

    return null;
  }

  /// Validate amount doesn't exceed maximum
  static String? amountNotExceeding(
      String? value, double maxAmount, String? fieldName) {
    final baseValidation = positiveNumber(value, fieldName);
    if (baseValidation != null) return baseValidation;

    final number = double.parse(value!);
    if (number > maxAmount) {
      return 'المبلغ أكبر من المتبقي (${maxAmount.toStringAsFixed(2)})';
    }

    return null;
  }

  /// Parse double from string safely
  static double parseDouble(String? value, [double defaultValue = 0.0]) {
    if (value == null || value.trim().isEmpty) return defaultValue;
    return double.tryParse(value) ?? defaultValue;
  }

  /// Trim and clean string input
  static String clean(String? value) {
    return value?.trim() ?? '';
  }

  /// Validate delivery date is not before order date
  static String? deliveryDateAfterOrderDate(DateTime? deliveryDate, DateTime orderDate) {
    if (deliveryDate == null) return null;
    if (deliveryDate.isBefore(orderDate)) {
      return 'تاريخ التسليم لا يمكن أن يكون قبل تاريخ الطلب';
    }
    return null;
  }

  /// Validate amount is not greater than maximum
  static String? amountNotGreaterThan(String? value, double maxAmount) {
    if (value == null || value.trim().isEmpty) return null;
    final number = double.tryParse(value);
    if (number == null) return 'يرجى إدخال رقم صحيح';
    if (number > maxAmount) {
      return 'المبلغ أكبر من المتبقي. أدخل مبلغاً لا يتجاوز ${maxAmount.toStringAsFixed(0)}';
    }
    return null;
  }
}
