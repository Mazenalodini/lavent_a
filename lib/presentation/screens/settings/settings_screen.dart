import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/utils/app_toast.dart';
import '../../../data/local/auth_service.dart';
import '../../../providers.dart';
import '../../common/lavent_button.dart';
import '../../common/lavent_card.dart';
import '../../common/lavent_text_field.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    final isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Info
            LaventCard(
              margin: EdgeInsets.zero,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppConstants.appName,
                          style: AppTextStyles.headlineMedium),
                      Text(AppConstants.appTagline,
                          style: AppTextStyles.bodySmall),
                      const SizedBox(height: 4),
                      Text(
                        'الإصدار ${AppConstants.version}',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Appearance Section
            Text('المظهر', style: AppTextStyles.headlineSmall),
            const SizedBox(height: 16),

            LaventCard(
              margin: EdgeInsets.zero,
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: (isDark ? AppColors.accentSecondary : AppColors.accent).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                    color: isDark ? AppColors.accentSecondary : AppColors.accent,
                  ),
                ),
                title: const Text('الوضع الليلي'),
                subtitle: Text(isDark ? 'مُفعّل' : 'مُعطّل'),
                trailing: Switch(
                  value: isDark,
                  activeColor: AppColors.accent,
                  onChanged: (value) {
                    ref.read(themeModeProvider.notifier).toggleTheme();
                  },
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Account Settings Section
            Text('إعدادات الحساب', style: AppTextStyles.headlineSmall),
            const SizedBox(height: 16),

            LaventCard(
              margin: EdgeInsets.zero,
              child: Column(
                children: [
                  // Change Password
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.lock_rounded, color: AppColors.accent),
                    ),
                    title: const Text('تغيير كلمة المرور'),
                    subtitle: const Text('تعديل كلمة المرور الحالية'),
                    trailing: Icon(Icons.chevron_left_rounded, color: AppColors.textSecondary),
                    onTap: () => _showChangePasswordDialog(),
                  ),
                  const Divider(),
                  // Logout
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.error.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.logout_rounded, color: AppColors.error),
                    ),
                    title: Text('تسجيل الخروج', style: TextStyle(color: AppColors.error)),
                    subtitle: const Text('الخروج من الحساب'),
                    onTap: () => _logout(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Archive Section
            Text('الأرشيف', style: AppTextStyles.headlineSmall),
            const SizedBox(height: 16),

            LaventCard(
              margin: EdgeInsets.zero,
              onTap: () => Navigator.pushNamed(context, '/orders/archived'),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.textSecondary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.archive_rounded, color: AppColors.textSecondary),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('الطلبات المؤرشفة', style: AppTextStyles.bodyLarge),
                        Text(
                          'عرض واستعادة الطلبات المؤرشفة',
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_left_rounded, color: AppColors.textSecondary),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Backup Section
            Text('النسخ الاحتياطي', style: AppTextStyles.headlineSmall),
            const SizedBox(height: 16),

            LaventCard(
              margin: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.backup_rounded, color: AppColors.accent),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('تصدير البيانات',
                                style: AppTextStyles.bodyLarge),
                            Text(
                              'حفظ جميع الطلبات والسندات في ملف JSON',
                              style: AppTextStyles.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  LaventButton(
                    label: AppConstants.btnBackup,
                    icon: Icons.download_rounded,
                    fullWidth: true,
                    isLoading: _isLoading,
                    onPressed: _exportData,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            LaventCard(
              margin: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.restore_rounded, color: AppColors.statusNew),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('استعادة البيانات',
                                style: AppTextStyles.bodyLarge),
                            Text(
                              'استيراد بيانات من ملف نسخة احتياطية',
                              style: AppTextStyles.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  LaventOutlinedButton(
                    label: AppConstants.btnRestore,
                    icon: Icons.upload_rounded,
                    fullWidth: true,
                    onPressed: _importData,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.warning_rounded,
                            color: AppColors.warning, size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'تحذير: الاستعادة ستحذف جميع البيانات الحالية',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.warning,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // About Section
            Text('حول التطبيق', style: AppTextStyles.headlineSmall),
            const SizedBox(height: 16),

            LaventCard(
              margin: EdgeInsets.zero,
              child: Column(
                children: [
                  _SettingsItem(
                    icon: Icons.info_outline,
                    title: 'تطبيق لافينت',
                    subtitle: 'إدارة طلبات وفواتير محل العبايات',
                  ),
                  const Divider(),
                  _SettingsItem(
                    icon: Icons.code,
                    title: 'النسخة',
                    subtitle: AppConstants.version,
                  ),
                  const Divider(),
                  _SettingsItem(
                    icon: Icons.storage,
                    title: 'قاعدة البيانات',
                    subtitle: 'SQLite (Drift) - تخزين محلي',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _exportData() async {
    setState(() => _isLoading = true);

    try {
      final db = ref.read(databaseProvider);
      final data = await db.exportData();
      final jsonString = const JsonEncoder.withIndent('  ').convert(data);

      // Get directory and create file
      final dir = await getApplicationDocumentsDirectory();
      final timestamp = DateTime.now()
          .toIso8601String()
          .replaceAll(':', '-')
          .substring(0, 19);
      final fileName = 'lavent_backup_$timestamp.json';
      final file = File('${dir.path}/$fileName');
      await file.writeAsBytes(utf8.encode(jsonString));

      // Share the file
      await Share.shareXFiles(
        [XFile(file.path)],
        subject: 'نسخة احتياطية - لافينت',
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(AppConstants.msgBackupSuccess)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _importData() async {
    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد الاستعادة'),
        content: const Text(
          'سيتم حذف جميع البيانات الحالية واستبدالها بالبيانات المستوردة. هل تريد المتابعة؟',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(AppConstants.btnCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              'متابعة',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result == null || result.files.single.path == null) return;

      setState(() => _isLoading = true);

      final file = File(result.files.single.path!);
      final jsonString = await file.readAsString();
      final data = jsonDecode(jsonString) as Map<String, dynamic>;

      final db = ref.read(databaseProvider);
      await db.importData(data);

      // Invalidate all providers to refresh data
      ref.invalidate(allOrdersProvider);
      ref.invalidate(allReceiptsProvider);
      ref.invalidate(dashboardStatsProvider);

      if (mounted) {
        AppToast.success(context, AppConstants.msgRestoreSuccess);
      }
    } catch (e) {
      if (mounted) {
        AppToast.error(context, 'خطأ في الاستعادة: $e');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showChangePasswordDialog() {
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.lock_rounded, color: AppColors.accent),
            const SizedBox(width: 8),
            const Text('تغيير كلمة المرور'),
          ],
        ),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LaventTextField(
                label: 'كلمة المرور الحالية',
                controller: oldPasswordController,
                obscureText: true,
                validator: (v) => v!.isEmpty ? 'مطلوب' : null,
              ),
              const SizedBox(height: 12),
              LaventTextField(
                label: 'كلمة المرور الجديدة',
                controller: newPasswordController,
                obscureText: true,
                validator: (v) {
                  if (v!.isEmpty) return 'مطلوب';
                  if (v.length < 4) return '4 أحرف على الأقل';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              LaventTextField(
                label: 'تأكيد كلمة المرور الجديدة',
                controller: confirmPasswordController,
                obscureText: true,
                validator: (v) {
                  if (v != newPasswordController.text) return 'كلمتا المرور غير متطابقتين';
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('إلغاء', style: TextStyle(color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () async {
              if (!formKey.currentState!.validate()) return;

              final success = await AuthService.changePassword(
                oldPasswordController.text,
                newPasswordController.text,
              );

              if (context.mounted) {
                Navigator.pop(context);
                if (success) {
                  AppToast.success(context, 'تم تغيير كلمة المرور بنجاح ✅');
                } else {
                  AppToast.error(context, 'كلمة المرور الحالية غير صحيحة');
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: Colors.white,
            ),
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }

  void _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        icon: Icon(Icons.logout_rounded, color: AppColors.warning, size: 48),
        title: const Text('تسجيل الخروج'),
        content: const Text('هل تريد تسجيل الخروج من الحساب؟'),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('إلغاء', style: TextStyle(color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.warning,
              foregroundColor: Colors.white,
            ),
            child: const Text('تسجيل الخروج'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      // Clear session by updating last activity to force re-login
      await AuthService.updateLastActivity();
      // Navigate to login
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _SettingsItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textSecondary, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.bodyMedium),
                Text(subtitle, style: AppTextStyles.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
