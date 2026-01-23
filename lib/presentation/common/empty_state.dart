import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// عنصر لعرض حالات الفراغ بشكل جميل واحترافي
/// يستخدم عند عدم وجود بيانات أو في حالات خاصة
class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;
  final Color? iconColor;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onAction,
    this.iconColor,
  });

  /// حالة الطلبات الفارغة
  factory EmptyState.noOrders({VoidCallback? onCreateOrder}) {
    return EmptyState(
      icon: Icons.inbox_rounded,
      title: 'لا توجد طلبات',
      subtitle: 'ابدأ بإنشاء طلب جديد لعميلك',
      actionLabel: 'إنشاء طلب جديد',
      onAction: onCreateOrder,
    );
  }

  /// حالة السندات الفارغة
  factory EmptyState.noReceipts({VoidCallback? onCreateReceipt}) {
    return EmptyState(
      icon: Icons.receipt_long_rounded,
      title: 'لا توجد سندات قبض',
      subtitle: 'السندات تُضاف عند استلام مدفوعات من العملاء',
      actionLabel: 'إضافة سند قبض',
      onAction: onCreateReceipt,
    );
  }

  /// حالة الفواتير الفارغة
  factory EmptyState.noInvoices() {
    return const EmptyState(
      icon: Icons.receipt_rounded,
      title: 'لا توجد فواتير',
      subtitle: 'الفواتير تتوفر للطلبات المكتملة التي تم سداد كامل المبلغ',
    );
  }

  /// حالة نتائج البحث الفارغة
  factory EmptyState.noSearchResults() {
    return const EmptyState(
      icon: Icons.search_off_rounded,
      title: 'لم يتم العثور على نتائج',
      subtitle: 'جرب تغيير كلمات البحث أو الفلاتر',
    );
  }

  /// حالة الأرشيف الفارغ
  factory EmptyState.noArchivedOrders() {
    return const EmptyState(
      icon: Icons.archive_rounded,
      title: 'الأرشيف فارغ',
      subtitle: 'الطلبات المؤرشفة ستظهر هنا',
      iconColor: AppColors.textSecondary,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // أيقونة كبيرة
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: (iconColor ?? AppColors.accent).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 64,
                color: iconColor ?? AppColors.accent,
              ),
            ),
            const SizedBox(height: 24),

            // العنوان
            Text(
              title,
              style: AppTextStyles.headlineMedium,
              textAlign: TextAlign.center,
            ),

            // النص الفرعي
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],

            // زر الإجراء
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.add_rounded),
                label: Text(actionLabel!),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
