
// Run: flutter pub run build_runner build

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../models/enums.dart';

part 'database.g.dart';

// ─────────────────────────────────────────────────────────────────────────────
// TABLE: Orders
// Based on PRD v1.0
// ─────────────────────────────────────────────────────────────────────────────
class Orders extends Table {
  // Core Fields
  IntColumn get id => integer().autoIncrement()();
  TextColumn get orderNumber => text().unique()(); // LA########
  DateTimeColumn get orderDate => dateTime()();
  DateTimeColumn get deliveryDate => dateTime().nullable()();
  TextColumn get status => text().withDefault(const Constant('newOrder'))();

  // Financials
  RealColumn get totalPrice => real()();
  RealColumn get initialPayment => real().withDefault(const Constant(0.0))();
  TextColumn get initialPaymentMethod => text().withDefault(const Constant('cash'))();

  // Client Details
  TextColumn get clientName => text()();
  TextColumn get clientPhone => text()();
  TextColumn get clientAddress => text().nullable()();

  // Product Details
  TextColumn get abayaType => text()();
  TextColumn get abayaNumber => text().nullable()();
  TextColumn get orderNotes => text().nullable()(); // Details for the order

  // Order Source (جهة الطلب)
  TextColumn get orderSource => text().withDefault(const Constant('whatsapp'))();
  TextColumn get orderSourceOther => text().nullable()(); // Custom source if 'other' selected

  // Wallet Details (if payment method is wallet)
  TextColumn get walletName => text().nullable()(); // كريمي، جوالي، جيب، ون كاش
  TextColumn get walletNameOther => text().nullable()(); // Custom wallet if 'other' selected

  // Measurements
  TextColumn get measurementType => text().withDefault(const Constant('general'))(); // general or custom
  TextColumn get generalSize => text().nullable()(); // For general measurement (e.g., "52")
  TextColumn get measurementNotes => text().nullable()(); // Notes for measurements
  RealColumn get length => real().nullable()();
  RealColumn get shoulder => real().nullable()();
  RealColumn get sleeve => real().nullable()();
  RealColumn get chest => real().nullable()();
  RealColumn get waist => real().nullable()();

  // Archive (soft delete)
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();

  // Timestamps
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}


// ─────────────────────────────────────────────────────────────────────────────
// TABLE: Receipts
// Based on PRD v1.0
// ─────────────────────────────────────────────────────────────────────────────
class Receipts extends Table {
  // Core Fields
  IntColumn get id => integer().autoIncrement()();
  TextColumn get receiptNumber => text().unique()();
  IntColumn get orderId => integer().references(Orders, #id, onDelete: KeyAction.cascade)();

  // Financials
  RealColumn get amount => real()();
  DateTimeColumn get date => dateTime()();
  TextColumn get paymentMethod => text().withDefault(const Constant('cash'))();

  // Details
  TextColumn get notes => text().nullable()();

  // Timestamps
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}


// ─────────────────────────────────────────────────────────────────────────────
// TABLE: Notifications (الإشعارات والتذكيرات)
// For tracking notification history and read/unread status
// ─────────────────────────────────────────────────────────────────────────────
class Notifications extends Table {
  // Core Fields
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();  // عنوان الإشعار
  TextColumn get body => text()();   // محتوى الإشعار
  TextColumn get type => text()();   // delivery_2days, delivery_1day, delivery_today, payment, custom
  
  // Relations
  IntColumn get orderId => integer().nullable()();  // ربط بالطلب (اختياري)
  TextColumn get orderNumber => text().nullable()(); // رقم الطلب للعرض
  
  // Timing
  DateTimeColumn get scheduledAt => dateTime()();   // وقت التذكير المجدول
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  
  // Status
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();
  BoolColumn get isDelivered => boolean().withDefault(const Constant(false))();
}


// ─────────────────────────────────────────────────────────────────────────────
// DATABASE CLASS
// ─────────────────────────────────────────────────────────────────────────────
@DriftDatabase(tables: [Orders, Receipts, Notifications])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  // YOU MUST INCREMENT THE SCHEMA VERSION WHEN YOU CHANGE THE DB STRUCTURE
  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    onUpgrade: (m, from, to) async {
      // For schema upgrades, drop and recreate tables
      // WARNING: This will delete all existing data on upgrade.
      if (from < 4) {
        // Drop tables using raw SQL
        await m.deleteTable('receipts');
        await m.deleteTable('orders');
        await m.createAll();
      }
      if (from < 5) {
        // Add notifications table
        await m.createTable(notifications);
      }
    },
  );


  // ------------------- Order CRUD & Queries -------------------

  // Watch active (non-archived) orders
  Stream<List<Order>> watchAllOrders() => 
      (select(orders)
        ..where((t) => t.isArchived.equals(false))
        ..orderBy([(t) => OrderingTerm.desc(t.orderDate)]))
      .watch();

  // Watch archived orders
  Stream<List<Order>> watchArchivedOrders() => 
      (select(orders)
        ..where((t) => t.isArchived.equals(true))
        ..orderBy([(t) => OrderingTerm.desc(t.orderDate)]))
      .watch();

  Future<Order?> getOrderById(int id) => (select(orders)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<int> insertOrder(OrdersCompanion order) => into(orders).insert(order);

  Future<bool> updateOrder(OrdersCompanion order) => update(orders).replace(order);

  Future<int> deleteOrder(int id) => (delete(orders)..where((t) => t.id.equals(id))).go();

  Future<bool> updateOrderById(int id, OrdersCompanion order) =>
      (update(orders)..where((t) => t.id.equals(id))).write(order).then((rows) => rows > 0);

  // Archive/Unarchive order
  Future<bool> archiveOrder(int id) => updateOrderById(id, OrdersCompanion(
    isArchived: const Value(true),
    updatedAt: Value(DateTime.now()),
  ));

  Future<bool> unarchiveOrder(int id) => updateOrderById(id, OrdersCompanion(
    isArchived: const Value(false),
    updatedAt: Value(DateTime.now()),
  ));

  Stream<List<Order>> watchOrdersByStatus(OrderStatus status) =>
      (select(orders)
            ..where((t) => t.status.equals(status.name) & t.isArchived.equals(false))
            ..orderBy([(t) => OrderingTerm.desc(t.orderDate)]))
          .watch();

  Future<String> getNextOrderNumber() async {
    final query = select(orders)
      ..orderBy([(t) => OrderingTerm.desc(t.id)])
      ..limit(1);
    final lastOrder = await query.getSingleOrNull();
    if (lastOrder == null) {
      return 'LA00000001';
    }
    final lastNumber = int.tryParse(lastOrder.orderNumber.substring(2)) ?? 0;
    final nextNumber = (lastNumber + 1).toString().padLeft(8, '0');
    return 'LA$nextNumber';
  }


  // ------------------- Receipt CRUD & Queries -------------------

  Stream<List<Receipt>> watchReceiptsForOrder(int orderId) =>
    (select(receipts)
      ..where((t) => t.orderId.equals(orderId))
      ..orderBy([(t) => OrderingTerm.desc(t.date)]))
    .watch();

  Future<int> insertReceipt(ReceiptsCompanion receipt) => into(receipts).insert(receipt);

  Future<int> deleteReceipt(int id) => (delete(receipts)..where((t) => t.id.equals(id))).go();


  // ------------------- Dashboard & Financial Queries -------------------

  Future<double> getTotalPaidForOrder(int orderId) async {
    final order = await getOrderById(orderId);
    if (order == null) return 0.0;

    final sumExpr = receipts.amount.sum();
    final query = selectOnly(receipts)
      ..addColumns([sumExpr])
      ..where(receipts.orderId.equals(orderId));
    final result = await query.getSingleOrNull();
    final receiptsSum = result?.read(sumExpr) ?? 0.0;

    return order.initialPayment + receiptsSum;
  }

  /// Search orders by client name, phone, or order number
  Stream<List<Order>> searchOrders(String query) {
    final lowerQuery = '%${query.toLowerCase()}%';
    return (select(orders)
          ..where((t) =>
              t.clientName.lower().like(lowerQuery) |
              t.clientPhone.like(lowerQuery) |
              t.orderNumber.lower().like(lowerQuery))
          ..orderBy([(t) => OrderingTerm.desc(t.orderDate)]))
        .watch();
  }

  /// Watch all receipts
  Stream<List<Receipt>> watchAllReceipts() =>
      (select(receipts)..orderBy([(t) => OrderingTerm.desc(t.date)])).watch();

  /// Count orders by status
  Future<int> countOrdersByStatus(OrderStatus status) async {
    final countExpr = orders.id.count();
    final query = selectOnly(orders)
      ..addColumns([countExpr])
      ..where(orders.status.equals(status.name));
    final result = await query.getSingleOrNull();
    return result?.read(countExpr) ?? 0;
  }

  /// Get total income (sum of all orders totalPrice where status is delivered)
  Future<double> getTotalIncome() async {
    final sumExpr = orders.totalPrice.sum();
    final query = selectOnly(orders)
      ..addColumns([sumExpr])
      ..where(orders.status.equals(OrderStatus.delivered.name));
    final result = await query.getSingleOrNull();
    return result?.read(sumExpr) ?? 0.0;
  }

  /// Get today's income (receipts + initial payments from orders created today)
  Future<double> getTodayIncome() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    // Sum receipts from today
    final receiptsSum = receipts.amount.sum();
    final receiptsQuery = selectOnly(receipts)
      ..addColumns([receiptsSum])
      ..where(receipts.date.isBiggerOrEqualValue(startOfDay) &
          receipts.date.isSmallerThanValue(endOfDay));
    final receiptsResult = await receiptsQuery.getSingleOrNull();
    final todayReceipts = receiptsResult?.read(receiptsSum) ?? 0.0;

    // Sum initial payments from orders created today
    final initialSum = orders.initialPayment.sum();
    final ordersQuery = selectOnly(orders)
      ..addColumns([initialSum])
      ..where(orders.orderDate.isBiggerOrEqualValue(startOfDay) &
          orders.orderDate.isSmallerThanValue(endOfDay) &
          orders.isArchived.equals(false));
    final ordersResult = await ordersQuery.getSingleOrNull();
    final todayInitialPayments = ordersResult?.read(initialSum) ?? 0.0;

    return todayReceipts + todayInitialPayments;
  }

  /// Export all data as JSON
  Future<Map<String, dynamic>> exportData() async {
    final allOrders = await select(orders).get();
    final allReceipts = await select(receipts).get();

    return {
      'version': 1,
      'exportedAt': DateTime.now().toIso8601String(),
      'orders': allOrders.map((o) => {
            'id': o.id,
            'orderNumber': o.orderNumber,
            'orderDate': o.orderDate.toIso8601String(),
            'deliveryDate': o.deliveryDate?.toIso8601String(),
            'status': o.status,
            'totalPrice': o.totalPrice,
            'initialPayment': o.initialPayment,
            'initialPaymentMethod': o.initialPaymentMethod,
            'clientName': o.clientName,
            'clientPhone': o.clientPhone,
            'clientAddress': o.clientAddress,
            'abayaType': o.abayaType,
            'abayaNumber': o.abayaNumber,
            'orderNotes': o.orderNotes,
            'orderSource': o.orderSource,
            'orderSourceOther': o.orderSourceOther,
            'walletName': o.walletName,
            'walletNameOther': o.walletNameOther,
            'measurementType': o.measurementType,
            'generalSize': o.generalSize,
            'measurementNotes': o.measurementNotes,
            'length': o.length,
            'shoulder': o.shoulder,
            'sleeve': o.sleeve,
            'chest': o.chest,
            'waist': o.waist,
            'createdAt': o.createdAt.toIso8601String(),
            'updatedAt': o.updatedAt.toIso8601String(),
          }).toList(),
      'receipts': allReceipts.map((r) => {
            'id': r.id,
            'receiptNumber': r.receiptNumber,
            'orderId': r.orderId,
            'amount': r.amount,
            'date': r.date.toIso8601String(),
            'paymentMethod': r.paymentMethod,
            'notes': r.notes,
            'createdAt': r.createdAt.toIso8601String(),
          }).toList(),
    };
  }

  /// Import data from JSON (clears existing data first)
  Future<void> importData(Map<String, dynamic> data) async {
    await transaction(() async {
      // Clear existing data
      await delete(receipts).go();
      await delete(orders).go();

      // Import orders
      final ordersData = data['orders'] as List<dynamic>? ?? [];
      for (final o in ordersData) {
        await into(orders).insert(OrdersCompanion.insert(
          orderNumber: o['orderNumber'] as String,
          orderDate: DateTime.parse(o['orderDate'] as String),
          deliveryDate: Value(o['deliveryDate'] != null
              ? DateTime.parse(o['deliveryDate'] as String)
              : null),
          status: Value(o['status'] as String),
          totalPrice: (o['totalPrice'] as num).toDouble(),
          initialPayment: Value((o['initialPayment'] as num?)?.toDouble() ?? 0.0),
          initialPaymentMethod: Value(o['initialPaymentMethod'] as String? ?? 'cash'),
          clientName: o['clientName'] as String,
          clientPhone: o['clientPhone'] as String,
          clientAddress: Value(o['clientAddress'] as String?),
          abayaType: o['abayaType'] as String,
          abayaNumber: Value(o['abayaNumber'] as String?),
          orderNotes: Value(o['orderNotes'] as String?),
          orderSource: Value(o['orderSource'] as String? ?? 'whatsapp'),
          orderSourceOther: Value(o['orderSourceOther'] as String?),
          walletName: Value(o['walletName'] as String?),
          walletNameOther: Value(o['walletNameOther'] as String?),
          measurementType: Value(o['measurementType'] as String? ?? 'general'),
          generalSize: Value(o['generalSize'] as String?),
          measurementNotes: Value(o['measurementNotes'] as String?),
          length: Value((o['length'] as num?)?.toDouble()),
          shoulder: Value((o['shoulder'] as num?)?.toDouble()),
          sleeve: Value((o['sleeve'] as num?)?.toDouble()),
          chest: Value((o['chest'] as num?)?.toDouble()),
          waist: Value((o['waist'] as num?)?.toDouble()),
        ));
      }

      // Import receipts
      final receiptsData = data['receipts'] as List<dynamic>? ?? [];
      for (final r in receiptsData) {
        await into(receipts).insert(ReceiptsCompanion.insert(
          receiptNumber: r['receiptNumber'] as String,
          orderId: r['orderId'] as int,
          amount: (r['amount'] as num).toDouble(),
          date: DateTime.parse(r['date'] as String),
          paymentMethod: Value(r['paymentMethod'] as String? ?? 'cash'),
          notes: Value(r['notes'] as String?),
        ));
      }
    });
  }


  // ------------------- Notification CRUD & Queries -------------------

  /// Insert a new notification
  Future<int> insertNotification(NotificationsCompanion notification) =>
      into(notifications).insert(notification);

  /// Watch all notifications (newest first)
  Stream<List<Notification>> watchAllNotifications() =>
      (select(notifications)..orderBy([(t) => OrderingTerm.desc(t.scheduledAt)]))
          .watch();

  /// Watch notifications filtered by date range (newest first)
  Stream<List<Notification>> watchNotificationsFiltered({
    DateTime? startDate,
    DateTime? endDate,
  }) {
    final query = select(notifications);
    
    if (startDate != null) {
      query.where((t) => t.scheduledAt.isBiggerOrEqualValue(startDate));
    }
    if (endDate != null) {
      query.where((t) => t.scheduledAt.isSmallerOrEqualValue(endDate));
    }
    
    query.orderBy([(t) => OrderingTerm.desc(t.scheduledAt)]);
    return query.watch();
  }

  /// Watch unread notifications count
  Stream<int> watchUnreadCount() {
    final query = selectOnly(notifications)
      ..addColumns([notifications.id.count()])
      ..where(notifications.isRead.equals(false));
    
    return query.map((row) => row.read(notifications.id.count()) ?? 0).watchSingle();
  }

  /// Get unread count synchronously
  Future<int> getUnreadCount() async {
    final query = selectOnly(notifications)
      ..addColumns([notifications.id.count()])
      ..where(notifications.isRead.equals(false));
    
    final result = await query.getSingle();
    return result.read(notifications.id.count()) ?? 0;
  }

  /// Mark all notifications as read
  Future<int> markAllNotificationsAsRead() {
    return (update(notifications)
      ..where((t) => t.isRead.equals(false)))
      .write(const NotificationsCompanion(isRead: Value(true)));
  }

  /// Mark a single notification as read
  Future<bool> markNotificationAsRead(int id) async {
    final rows = await (update(notifications)..where((t) => t.id.equals(id)))
        .write(const NotificationsCompanion(isRead: Value(true)));
    return rows > 0;
  }

  /// Mark notification as delivered (when system notification fires)
  Future<bool> markNotificationAsDelivered(int id) async {
    final rows = await (update(notifications)..where((t) => t.id.equals(id)))
        .write(const NotificationsCompanion(isDelivered: Value(true)));
    return rows > 0;
  }

  /// Delete a notification
  Future<int> deleteNotification(int id) =>
      (delete(notifications)..where((t) => t.id.equals(id))).go();

  /// Delete all notifications
  Future<int> deleteAllNotifications() => delete(notifications).go();

  /// Delete old notifications (older than specified days)
  Future<int> deleteOldNotifications(int daysOld) {
    final cutoffDate = DateTime.now().subtract(Duration(days: daysOld));
    return (delete(notifications)
      ..where((t) => t.scheduledAt.isSmallerThanValue(cutoffDate)))
      .go();
  }

  /// Cancel notifications for a specific order
  Future<int> deleteNotificationsForOrder(int orderId) =>
      (delete(notifications)..where((t) => t.orderId.equals(orderId))).go();
}


// ─────────────────────────────────────────────────────────────────────────────
// DATABASE CONNECTION
// ─────────────────────────────────────────────────────────────────────────────
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'lavent_database.db'));
    return NativeDatabase.createInBackground(file);
  });
}
