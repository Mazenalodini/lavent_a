import 'package:intl/intl.dart';

/// Utility class for formatting values
class Formatters {
  Formatters._();

  // ─────────────────────────────────────────────────────────────────────────────
  // CURRENCY
  // ─────────────────────────────────────────────────────────────────────────────

  static final _currencyFormat = NumberFormat('#,##0.00', 'ar_SA');

  /// Format amount as currency with YER symbol
  static String currency(double amount) {
    return '${_currencyFormat.format(amount)} ر.ي';
  }

  /// Format amount as currency without symbol
  static String currencyNoSymbol(double amount) {
    return _currencyFormat.format(amount);
  }

  /// Format amount as compact currency (for small spaces)
  static String currencyCompact(double amount) {
    if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(1)}م ر.ي';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)}ك ر.ي';
    }
    return '${amount.toStringAsFixed(0)} ر.ي';
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // DATE & TIME
  // ─────────────────────────────────────────────────────────────────────────────

  static final _dateFormat = DateFormat('yyyy/MM/dd', 'ar_SA');
  static final _dateTimeFormat = DateFormat('yyyy/MM/dd HH:mm', 'ar_SA');
  static final _shortDateFormat = DateFormat('dd/MM', 'ar_SA');

  /// Format date (e.g., 2024/01/21)
  static String date(DateTime date) {
    return _dateFormat.format(date);
  }

  /// Format date and time
  static String dateTime(DateTime dateTime) {
    return _dateTimeFormat.format(dateTime);
  }

  /// Format short date (e.g., 21/01)
  static String shortDate(DateTime date) {
    return _shortDateFormat.format(date);
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // PHONE
  // ─────────────────────────────────────────────────────────────────────────────

  /// Format phone number for display
  static String phone(String phone) {
    // Remove any non-digit characters
    final digits = phone.replaceAll(RegExp(r'\D'), '');

    if (digits.length == 10 && digits.startsWith('05')) {
      // Saudi mobile format: 05XX XXX XXXX
      return '${digits.substring(0, 4)} ${digits.substring(4, 7)} ${digits.substring(7)}';
    }

    return phone; // Return as-is if not matching expected format
  }
}
