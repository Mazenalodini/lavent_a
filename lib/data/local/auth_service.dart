import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// خدمة المصادقة المحلية - Local Authentication Service
/// تخزين آمن لبيانات المستخدم مع تشفير كلمة المرور
class AuthService {
  static const _storage = FlutterSecureStorage();
  
  // Keys for secure storage
  static const _keyIsSetup = 'auth_is_setup';
  static const _keyUsername = 'auth_username';
  static const _keyPasswordHash = 'auth_password_hash';
  static const _keySalt = 'auth_salt';
  static const _keyBiometricEnabled = 'auth_biometric_enabled';
  static const _keyAutoLockMinutes = 'auth_auto_lock_minutes';
  static const _keyLastActivity = 'auth_last_activity';

  /// التحقق من إعداد التطبيق لأول مرة
  static Future<bool> isSetupComplete() async {
    final value = await _storage.read(key: _keyIsSetup);
    return value == 'true';
  }

  /// إعداد حساب المستخدم لأول مرة
  static Future<void> setupAccount(String username, String password) async {
    // Generate random salt
    final salt = _generateSalt();
    
    // Hash password with salt
    final hash = _hashPassword(password, salt);
    
    // Store credentials securely
    await _storage.write(key: _keyUsername, value: username);
    await _storage.write(key: _keyPasswordHash, value: hash);
    await _storage.write(key: _keySalt, value: salt);
    await _storage.write(key: _keyIsSetup, value: 'true');
    await _storage.write(key: _keyAutoLockMinutes, value: '5');
    
    // Update last activity
    await updateLastActivity();
  }

  /// تسجيل الدخول
  static Future<bool> login(String username, String password) async {
    final storedUsername = await _storage.read(key: _keyUsername);
    final storedHash = await _storage.read(key: _keyPasswordHash);
    final storedSalt = await _storage.read(key: _keySalt);
    
    if (storedUsername == null || storedHash == null || storedSalt == null) {
      return false;
    }
    
    // Verify username
    if (username != storedUsername) {
      return false;
    }
    
    // Verify password
    final hash = _hashPassword(password, storedSalt);
    if (hash != storedHash) {
      return false;
    }
    
    // Update last activity
    await updateLastActivity();
    
    return true;
  }

  /// الحصول على اسم المستخدم
  static Future<String?> getUsername() async {
    return await _storage.read(key: _keyUsername);
  }

  /// تحديث وقت آخر نشاط
  static Future<void> updateLastActivity() async {
    await _storage.write(
      key: _keyLastActivity,
      value: DateTime.now().millisecondsSinceEpoch.toString(),
    );
  }

  /// التحقق من انتهاء مهلة الخمول
  static Future<bool> isSessionExpired() async {
    final lastActivityStr = await _storage.read(key: _keyLastActivity);
    final autoLockStr = await _storage.read(key: _keyAutoLockMinutes);
    
    if (lastActivityStr == null) return true;
    
    final lastActivity = DateTime.fromMillisecondsSinceEpoch(
      int.parse(lastActivityStr),
    );
    final autoLockMinutes = int.tryParse(autoLockStr ?? '5') ?? 5;
    
    // If auto-lock is 0, session never expires
    if (autoLockMinutes == 0) return false;
    
    final now = DateTime.now();
    final difference = now.difference(lastActivity).inMinutes;
    
    return difference >= autoLockMinutes;
  }

  /// الحصول على مدة القفل التلقائي
  static Future<int> getAutoLockMinutes() async {
    final value = await _storage.read(key: _keyAutoLockMinutes);
    return int.tryParse(value ?? '5') ?? 5;
  }

  /// تعيين مدة القفل التلقائي
  static Future<void> setAutoLockMinutes(int minutes) async {
    await _storage.write(key: _keyAutoLockMinutes, value: minutes.toString());
  }

  /// هل البصمة مفعلة
  static Future<bool> isBiometricEnabled() async {
    final value = await _storage.read(key: _keyBiometricEnabled);
    return value == 'true';
  }

  /// تفعيل/تعطيل البصمة
  static Future<void> setBiometricEnabled(bool enabled) async {
    await _storage.write(key: _keyBiometricEnabled, value: enabled.toString());
  }

  /// تغيير كلمة المرور
  static Future<bool> changePassword(String oldPassword, String newPassword) async {
    final storedHash = await _storage.read(key: _keyPasswordHash);
    final storedSalt = await _storage.read(key: _keySalt);
    
    if (storedHash == null || storedSalt == null) return false;
    
    // Verify old password
    final oldHash = _hashPassword(oldPassword, storedSalt);
    if (oldHash != storedHash) return false;
    
    // Generate new salt and hash
    final newSalt = _generateSalt();
    final newHash = _hashPassword(newPassword, newSalt);
    
    await _storage.write(key: _keyPasswordHash, value: newHash);
    await _storage.write(key: _keySalt, value: newSalt);
    
    return true;
  }

  /// إعادة تعيين كل شيء (للطوارئ)
  static Future<void> resetAll() async {
    await _storage.deleteAll();
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Private helpers
  // ─────────────────────────────────────────────────────────────────────────────

  static String _generateSalt() {
    final random = DateTime.now().microsecondsSinceEpoch.toString();
    return base64Encode(utf8.encode(random));
  }

  static String _hashPassword(String password, String salt) {
    final bytes = utf8.encode(password + salt);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
