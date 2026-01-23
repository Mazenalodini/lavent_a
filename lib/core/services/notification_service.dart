import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:drift/drift.dart';

import '../../data/local/database.dart';

/// خدمة الإشعارات والتذكيرات - Notification Service
/// تدير إشعارات التذكير قبل موعد التسليم وتحفظها في قاعدة البيانات
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;
  AppDatabase? _database;

  /// Set database reference for persistence
  void setDatabase(AppDatabase db) {
    _database = db;
  }

  /// تهيئة خدمة الإشعارات
  Future<void> initialize() async {
    if (_isInitialized) return;

    // Initialize timezone
    tz_data.initializeTimeZones();

    // Android settings
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS settings
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    _isInitialized = true;
  }

  /// طلب أذونات الإشعارات
  Future<bool> requestPermission() async {
    final android = _notifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    
    if (android != null) {
      final granted = await android.requestNotificationsPermission();
      return granted ?? false;
    }
    return true;
  }

  /// جدولة تذكير قبل موعد التسليم
  /// يُرسل إشعاراً قبل يوم وقبل يومين من موعد التسليم
  Future<void> scheduleDeliveryReminders({
    required int orderId,
    required String orderNumber,
    required String clientName,
    required DateTime deliveryDate,
  }) async {
    // Cancel any existing reminders for this order
    await cancelOrderReminders(orderId);

    final now = DateTime.now();

    // Reminder 2 days before
    final twoDaysBefore = deliveryDate.subtract(const Duration(days: 2));
    if (twoDaysBefore.isAfter(now)) {
      await _scheduleAndSaveNotification(
        id: orderId * 10 + 1,
        type: 'delivery_2days',
        title: 'تذكير: موعد تسليم قريب 📅',
        body: 'الطلب $orderNumber للعميل $clientName\nموعد التسليم بعد يومين',
        scheduledDate: twoDaysBefore,
        orderId: orderId,
        orderNumber: orderNumber,
      );
    }

    // Reminder 1 day before
    final oneDayBefore = deliveryDate.subtract(const Duration(days: 1));
    if (oneDayBefore.isAfter(now)) {
      await _scheduleAndSaveNotification(
        id: orderId * 10 + 2,
        type: 'delivery_1day',
        title: 'تذكير عاجل: موعد التسليم غداً! ⚠️',
        body: 'الطلب $orderNumber للعميل $clientName\nموعد التسليم غداً',
        scheduledDate: oneDayBefore,
        orderId: orderId,
        orderNumber: orderNumber,
      );
    }

    // Reminder on delivery day
    final deliveryMorning = DateTime(deliveryDate.year, deliveryDate.month, deliveryDate.day, 9, 0);
    if (deliveryMorning.isAfter(now)) {
      await _scheduleAndSaveNotification(
        id: orderId * 10 + 3,
        type: 'delivery_today',
        title: 'اليوم موعد التسليم! 🚚',
        body: 'الطلب $orderNumber للعميل $clientName\nلا تنسَ تسليم الطلب اليوم',
        scheduledDate: deliveryMorning,
        orderId: orderId,
        orderNumber: orderNumber,
      );
    }
  }

  /// إلغاء تذكيرات طلب معين
  Future<void> cancelOrderReminders(int orderId) async {
    await _notifications.cancel(orderId * 10 + 1);
    await _notifications.cancel(orderId * 10 + 2);
    await _notifications.cancel(orderId * 10 + 3);
    
    // Also remove from database
    await _database?.deleteNotificationsForOrder(orderId);
  }

  /// إظهار إشعار فوري
  Future<void> showInstantNotification({
    required String title,
    required String body,
    int? orderId,
    String? orderNumber,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'lavent_channel',
      'إشعارات لافينت',
      channelDescription: 'إشعارات تذكير بمواعيد التسليم',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      playSound: true,
      enableVibration: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(
      DateTime.now().millisecondsSinceEpoch.remainder(100000),
      title,
      body,
      details,
    );

    // Save to database
    await _database?.insertNotification(NotificationsCompanion(
      title: Value(title),
      body: Value(body),
      type: const Value('instant'),
      orderId: Value(orderId),
      orderNumber: Value(orderNumber),
      scheduledAt: Value(DateTime.now()),
      isDelivered: const Value(true),
    ));
  }

  /// جدولة وحفظ إشعار في قاعدة البيانات
  Future<void> _scheduleAndSaveNotification({
    required int id,
    required String type,
    required String title,
    required String body,
    required DateTime scheduledDate,
    int? orderId,
    String? orderNumber,
  }) async {
    // Schedule with system
    await _scheduleNotification(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduledDate,
    );

    // Save to database
    await _database?.insertNotification(NotificationsCompanion(
      title: Value(title),
      body: Value(body),
      type: Value(type),
      orderId: Value(orderId),
      orderNumber: Value(orderNumber),
      scheduledAt: Value(scheduledDate),
      isDelivered: const Value(false),
    ));
  }

  /// جدولة إشعار في وقت محدد
  Future<void> _scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'lavent_reminders',
      'تذكيرات التسليم',
      channelDescription: 'تذكيرات بمواعيد تسليم الطلبات',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      playSound: true,
      enableVibration: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  /// معالجة النقر على الإشعار
  void _onNotificationTapped(NotificationResponse response) {
    // يمكن فتح شاشة تفاصيل الطلب هنا
    // final payload = response.payload;
  }

  /// الحصول على جميع الإشعارات المجدولة
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _notifications.pendingNotificationRequests();
  }

  /// إلغاء جميع الإشعارات
  Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
    await _database?.deleteAllNotifications();
  }

  /// الحصول على plugin للإلغاء المباشر
  FlutterLocalNotificationsPlugin getPlugin() => _notifications;
}
