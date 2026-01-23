import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/app_toast.dart';
import '../../../data/local/auth_service.dart';
import '../../common/lavent_button.dart';
import '../../common/lavent_text_field.dart';

/// شاشة تسجيل الدخول
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
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
                      'LAVENT',
                      style: AppTextStyles.headlineLarge.copyWith(
                        fontSize: 32,
                        letterSpacing: 4,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'مدير طلبات العبايات الفاخرة',
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
                      return null;
                    },
                  ),

                  const SizedBox(height: 32),

                  // Login Button
                  LaventButton(
                    label: 'تسجيل الدخول',
                    icon: Icons.login_rounded,
                    isLoading: _isLoading,
                    fullWidth: true,
                    onPressed: _login,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final success = await AuthService.login(
        _usernameController.text.trim(),
        _passwordController.text,
      );

      if (!mounted) return;

      if (success) {
        AppToast.success(context, 'مرحباً بك ✅');
        Navigator.pushReplacementNamed(context, '/');
      } else {
        AppToast.error(context, 'بيانات الدخول غير صحيحة');
      }
    } catch (e) {
      if (mounted) {
        AppToast.error(context, 'حدث خطأ غير متوقع. حاول مرة أخرى.');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}
