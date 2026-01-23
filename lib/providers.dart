import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'data/local/database.dart';
import 'data/models/enums.dart';

// ─────────────────────────────────────────────────────────────────────────────
// DATABASE PROVIDER
// ─────────────────────────────────────────────────────────────────────────────

/// Global database instance provider
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

// ─────────────────────────────────────────────────────────────────────────────
// ORDERS PROVIDERS
// ─────────────────────────────────────────────────────────────────────────────

/// Stream of all orders
final allOrdersProvider = StreamProvider<List<Order>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchAllOrders();
});

/// Stream of orders filtered by status
final ordersByStatusProvider =
    StreamProvider.family<List<Order>, OrderStatus>((ref, status) {
  final db = ref.watch(databaseProvider);
  return db.watchOrdersByStatus(status);
});

/// Stream of archived orders
final archivedOrdersProvider = StreamProvider<List<Order>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchArchivedOrders();
});

/// Search orders by query
final ordersSearchProvider =
    StreamProvider.family<List<Order>, String>((ref, query) {
  final db = ref.watch(databaseProvider);
  if (query.isEmpty) {
    return db.watchAllOrders();
  }
  return db.searchOrders(query);
});

/// Get single order by ID
final orderByIdProvider =
    FutureProvider.family<Order?, int>((ref, id) async {
  final db = ref.watch(databaseProvider);
  return db.getOrderById(id);
});

// ─────────────────────────────────────────────────────────────────────────────
// RECEIPTS PROVIDERS
// ─────────────────────────────────────────────────────────────────────────────

/// Stream of all receipts
final allReceiptsProvider = StreamProvider<List<Receipt>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchAllReceipts();
});

/// Stream of receipts for a specific order
final receiptsForOrderProvider =
    StreamProvider.family<List<Receipt>, int>((ref, orderId) {
  final db = ref.watch(databaseProvider);
  return db.watchReceiptsForOrder(orderId);
});

/// Get total paid for an order
final totalPaidForOrderProvider =
    FutureProvider.family<double, int>((ref, orderId) async {
  final db = ref.watch(databaseProvider);
  return db.getTotalPaidForOrder(orderId);
});

// ─────────────────────────────────────────────────────────────────────────────
// DASHBOARD PROVIDERS
// ─────────────────────────────────────────────────────────────────────────────

/// Dashboard statistics
final dashboardStatsProvider = FutureProvider<DashboardStats>((ref) async {
  final db = ref.watch(databaseProvider);

  final newCount = await db.countOrdersByStatus(OrderStatus.newOrder);
  final processingCount = await db.countOrdersByStatus(OrderStatus.processing);
  final deliveredCount = await db.countOrdersByStatus(OrderStatus.delivered);
  final totalIncome = await db.getTotalIncome();
  final todayIncome = await db.getTodayIncome();

  return DashboardStats(
    newOrders: newCount,
    processingOrders: processingCount,
    deliveredOrders: deliveredCount,
    totalIncome: totalIncome,
    todayIncome: todayIncome,
  );
});

/// Dashboard statistics data class
class DashboardStats {
  final int newOrders;
  final int processingOrders;
  final int deliveredOrders;
  final double totalIncome;
  final double todayIncome;

  DashboardStats({
    required this.newOrders,
    required this.processingOrders,
    required this.deliveredOrders,
    required this.totalIncome,
    required this.todayIncome,
  });

  int get totalActiveOrders => newOrders + processingOrders;
  int get totalOrders => newOrders + processingOrders + deliveredOrders;
}

// ─────────────────────────────────────────────────────────────────────────────
// FILTER STATE PROVIDERS
// ─────────────────────────────────────────────────────────────────────────────

/// Current search query for orders
final ordersSearchQueryProvider = StateProvider<String>((ref) => '');

/// Current status filter for orders (null means all)
final ordersStatusFilterProvider = StateProvider<OrderStatus?>((ref) => null);

/// Filtered orders based on search and status
final filteredOrdersProvider = StreamProvider<List<Order>>((ref) {
  final db = ref.watch(databaseProvider);
  final query = ref.watch(ordersSearchQueryProvider);
  final statusFilter = ref.watch(ordersStatusFilterProvider);

  if (query.isNotEmpty) {
    return db.searchOrders(query);
  } else if (statusFilter != null) {
    return db.watchOrdersByStatus(statusFilter);
  } else {
    return db.watchAllOrders();
  }
});
