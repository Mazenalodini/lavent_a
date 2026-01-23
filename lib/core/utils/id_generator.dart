import 'dart:math';
import '../constants/app_constants.dart';

/// Utility class for generating unique IDs
class IdGenerator {
  IdGenerator._();

  static final _random = Random();

  /// Generate a unique order number in format LA########
  /// Example: LA00012345
  static String generateOrderNumber() {
    // Generate 8 random digits
    final number = _random.nextInt(99999999);
    final paddedNumber =
        number.toString().padLeft(AppConstants.orderNumberDigits, '0');
    return '${AppConstants.orderNumberPrefix}$paddedNumber';
  }

  /// Generate a unique receipt number in format RCP########
  static String generateReceiptNumber() {
    final number = _random.nextInt(99999999);
    final paddedNumber = number.toString().padLeft(8, '0');
    return 'RCP$paddedNumber';
  }

  /// Validate order number format
  static bool isValidOrderNumber(String orderNumber) {
    final pattern = RegExp(
        r'^' + AppConstants.orderNumberPrefix + r'\d{' + AppConstants.orderNumberDigits.toString() + r'}$');
    return pattern.hasMatch(orderNumber);
  }
}
