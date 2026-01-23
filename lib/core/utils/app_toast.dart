import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// نظام التنبيهات الموحد - Unified Toast/Snackbar System
/// يوفر رسائل جميلة واحترافية مع دعم RTL والأيقونات
class AppToast {
  AppToast._();

  /// إظهار رسالة نجاح
  static void success(BuildContext context, String message) {
    _show(
      context,
      message: message,
      icon: Icons.check_circle_rounded,
      backgroundColor: AppColors.success,
    );
  }

  /// إظهار رسالة خطأ
  static void error(BuildContext context, String message) {
    _show(
      context,
      message: message,
      icon: Icons.error_rounded,
      backgroundColor: AppColors.error,
    );
  }

  /// إظهار رسالة تحذير
  static void warning(BuildContext context, String message) {
    _show(
      context,
      message: message,
      icon: Icons.warning_rounded,
      backgroundColor: AppColors.warning,
      textColor: AppColors.textPrimary,
    );
  }

  /// إظهار رسالة معلومات
  static void info(BuildContext context, String message) {
    _show(
      context,
      message: message,
      icon: Icons.info_rounded,
      backgroundColor: AppColors.statusNew,
    );
  }

  /// إظهار رسالة مع زر تراجع
  static void withUndo(
    BuildContext context, {
    required String message,
    required VoidCallback onUndo,
    String undoLabel = 'تراجع',
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle_rounded, color: Colors.white, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: undoLabel,
          textColor: Colors.white,
          onPressed: onUndo,
        ),
      ),
    );
  }

  /// الدالة الأساسية لعرض التنبيه
  static void _show(
    BuildContext context, {
    required String message,
    required IconData icon,
    required Color backgroundColor,
    Color textColor = Colors.white,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: textColor, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: AppTextStyles.bodyMedium.copyWith(color: textColor),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

/// نظام الحوارات الموحد - Unified Dialog System
class AppDialog {
  AppDialog._();

  /// حوار تأكيد الحذف
  static Future<bool> confirmDelete(
    BuildContext context, {
    String title = 'تأكيد الحذف',
    required String message,
    String cancelLabel = 'إلغاء',
    String confirmLabel = 'حذف',
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        icon: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.error.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.delete_forever_rounded, color: AppColors.error, size: 40),
        ),
        title: Text(title, style: AppTextStyles.headlineSmall),
        content: Text(
          message,
          style: AppTextStyles.bodyMedium,
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(cancelLabel, style: TextStyle(color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(confirmLabel),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  /// حوار تأكيد الأرشفة
  static Future<bool> confirmArchive(
    BuildContext context, {
    String title = 'أرشفة الطلب',
    String message = 'سيتم نقل الطلب إلى الأرشيف ويمكن استعادته لاحقاً.',
    String cancelLabel = 'إلغاء',
    String confirmLabel = 'أرشفة',
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        icon: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.warning.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.archive_rounded, color: AppColors.warning, size: 40),
        ),
        title: Text(title, style: AppTextStyles.headlineSmall),
        content: Text(
          message,
          style: AppTextStyles.bodyMedium,
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(cancelLabel, style: TextStyle(color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.warning,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(confirmLabel),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  /// حوار التحذير
  static Future<bool> showWarning(
    BuildContext context, {
    required String title,
    required String message,
    String cancelLabel = 'إلغاء',
    String confirmLabel = 'متابعة',
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        icon: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.warning.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.warning_amber_rounded, color: AppColors.warning, size: 40),
        ),
        title: Text(title, style: AppTextStyles.headlineSmall),
        content: Text(
          message,
          style: AppTextStyles.bodyMedium,
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(cancelLabel, style: TextStyle(color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(confirmLabel),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  /// حوار تأكيد الحذف النهائي (من الأرشيف)
  static Future<bool> confirmPermanentDelete(
    BuildContext context, {
    String title = 'حذف نهائي',
    String message = 'هذا الإجراء لا يمكن التراجع عنه.',
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        icon: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.error.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.delete_forever_rounded, color: AppColors.error, size: 48),
        ),
        title: Text(title, style: AppTextStyles.headlineSmall.copyWith(color: AppColors.error)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: AppTextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning_rounded, color: AppColors.error, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'سيتم حذف الطلب وجميع السندات المرتبطة نهائياً',
                      style: AppTextStyles.bodySmall.copyWith(color: AppColors.error),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('إلغاء', style: TextStyle(color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('حذف نهائي'),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}
