import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/app_toast.dart';
import '../../../data/local/auth_service.dart';
import '../../common/lavent_button.dart';
import '../../common/lavent_text_field.dart';

/// شاشة إعداد الحساب لأول مرة
class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset(
                      'assets/images/logol.png',
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Title
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [
                        AppColors.accent,
                        AppColors.accentSecondary,
                      ],
                    ).createShader(bounds),
                    child: Text(
                      'مرحباً بك',
                      style: AppTextStyles.headlineLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'أنشئ حسابك للبدء في لافينت',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Username Field
                  LaventTextField(
                    label: 'اسم المستخدم',
                    controller: _usernameController,
                    prefixIcon: const Icon(Icons.person_rounded),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'اسم المستخدم مطلوب';
                      if (v.length < 3) return 'اسم المستخدم قصير جداً';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Password Field
                  LaventTextField(
                    label: 'كلمة المرور',
                    controller: _passwordController,
                    prefixIcon: const Icon(Icons.lock_rounded),
                    obscureText: _obscurePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                      ),
                      onPressed: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'كلمة المرور مطلوبة';
                      if (v.length < 4) return 'كلمة المرور قصيرة جداً (4 أحرف على الأقل)';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Confirm Password Field
                  LaventTextField(
                    label: 'تأكيد كلمة المرور',
                    controller: _confirmPasswordController,
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    obscureText: _obscureConfirmPassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                      ),
                      onPressed: () {
                        setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
                      },
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'تأكيد كلمة المرور مطلوب';
                      if (v != _passwordController.text) return 'كلمتا المرور غير متطابقتين';
                      return null;
                    },
                  ),

                  const SizedBox(height: 32),

                  // Setup Button
                  LaventButton(
                    label: 'إنشاء الحساب',
                    icon: Icons.check_rounded,
                    isLoading: _isLoading,
                    fullWidth: true,
                    onPressed: _setup,
                  ),

                  const SizedBox(height: 24),

                  // Info
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.statusNew.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_rounded, color: AppColors.statusNew, size: 22),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'سيتم تخزين بياناتك بشكل آمن ومشفر على جهازك',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.statusNew,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _setup() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await AuthService.setupAccount(
        _usernameController.text.trim(),
        _passwordController.text,
      );

      if (!mounted) return;

      AppToast.success(context, 'تم إنشاء حسابك بنجاح ✅');
      Navigator.pushReplacementNamed(context, '/');
    } catch (e) {
      if (mounted) {
        AppToast.error(context, 'حدث خطأ. حاول مرة أخرى.');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}
