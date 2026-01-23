import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/local/database.dart';
import '../../../data/models/enums.dart';
import '../../../providers.dart';
import '../../common/status_badge.dart';
import '../../common/lavent_card.dart';

class OrdersListScreen extends ConsumerStatefulWidget {
  const OrdersListScreen({super.key});

  @override
  ConsumerState<OrdersListScreen> createState() => _OrdersListScreenState();
}

class _OrdersListScreenState extends ConsumerState<OrdersListScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ordersAsync = ref.watch(filteredOrdersProvider);
    final statusFilter = ref.watch(ordersStatusFilterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('الطلبات'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded),
            onPressed: () => _showFilterSheet(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/orders/new'),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'بحث بالاسم أو رقم الطلب...',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          ref.read(ordersSearchQueryProvider.notifier).state =
                              '';
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                ref.read(ordersSearchQueryProvider.notifier).state = value;
              },
            ),
          ),

          // Status Filter Chips
          if (statusFilter == null)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _StatusChip(
                    status: OrderStatus.newOrder,
                    onTap: () => _setStatusFilter(OrderStatus.newOrder),
                  ),
                  const SizedBox(width: 8),
                  _StatusChip(
                    status: OrderStatus.processing,
                    onTap: () => _setStatusFilter(OrderStatus.processing),
                  ),
                  const SizedBox(width: 8),
                  _StatusChip(
                    status: OrderStatus.delivered,
                    onTap: () => _setStatusFilter(OrderStatus.delivered),
                  ),
                ],
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Chip(
                    label: Text(statusFilter.displayName),
                    deleteIcon: const Icon(Icons.close, size: 18),
                    onDeleted: () {
                      ref.read(ordersStatusFilterProvider.notifier).state =
                          null;
                    },
                  ),
                ],
              ),
            ),

          const SizedBox(height: 8),

          // Orders List
          Expanded(
            child: ordersAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('خطأ: $err')),
              data: (orders) {
                if (orders.isEmpty) {
                  return _buildEmptyState();
                }
                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 80),
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    return _OrderCard(order: orders[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _setStatusFilter(OrderStatus status) {
    ref.read(ordersStatusFilterProvider.notifier).state = status;
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('عرض الكل', style: AppTextStyles.bodyLarge),
              onTap: () {
                ref.read(ordersStatusFilterProvider.notifier).state = null;
                Navigator.pop(context);
              },
            ),
            ...OrderStatus.values.map(
              (status) => ListTile(
                leading: StatusBadge(status: status, compact: true),
                title:
                    Text(status.displayName, style: AppTextStyles.bodyLarge),
                onTap: () {
                  ref.read(ordersStatusFilterProvider.notifier).state = status;
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 80,
            color: AppColors.textSecondary.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'لا توجد طلبات',
            style: AppTextStyles.headlineSmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'اضغط + لإضافة طلب جديد',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final OrderStatus status;
  final VoidCallback onTap;

  const _StatusChip({required this.status, required this.onTap});

  Color get _color {
    switch (status) {
      case OrderStatus.newOrder:
        return AppColors.statusNew;
      case OrderStatus.processing:
        return AppColors.statusProcessing;
      case OrderStatus.delivered:
        return AppColors.statusDelivered;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(status.displayName),
      labelStyle: AppTextStyles.labelSmall.copyWith(color: _color),
      backgroundColor: _color.withOpacity(0.1),
      side: BorderSide.none,
      onPressed: onTap,
    );
  }
}

class _OrderCard extends ConsumerWidget {
  final Order order;

  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalPaidAsync = ref.watch(totalPaidForOrderProvider(order.id));
    final status = OrderStatus.fromName(order.status);

    return LaventCard(
      onTap: () {
        Navigator.pushNamed(context, '/orders/detail', arguments: order.id);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.clientName,
                      style: AppTextStyles.headlineSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      order.orderNumber,
                      style: AppTextStyles.orderNumber,
                    ),
                  ],
                ),
              ),
              // Status badge with popup menu for quick change
              PopupMenuButton<OrderStatus>(
                onSelected: (newStatus) => _updateStatus(context, ref, newStatus),
                child: StatusBadge(status: status),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: OrderStatus.newOrder,
                    child: Row(
                      children: [
                        Icon(Icons.fiber_new_rounded, 
                            color: AppColors.statusNew, size: 20),
                        const SizedBox(width: 8),
                        const Text('جديد'),
                        if (status == OrderStatus.newOrder)
                          const Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Icon(Icons.check, size: 18),
                          ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: OrderStatus.processing,
                    child: Row(
                      children: [
                        Icon(Icons.pending_actions_rounded, 
                            color: AppColors.statusProcessing, size: 20),
                        const SizedBox(width: 8),
                        const Text('قيد التنفيذ'),
                        if (status == OrderStatus.processing)
                          const Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Icon(Icons.check, size: 18),
                          ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: OrderStatus.delivered,
                    child: Row(
                      children: [
                        Icon(Icons.check_circle_rounded, 
                            color: AppColors.statusDelivered, size: 20),
                        const SizedBox(width: 8),
                        const Text('تم التسليم'),
                        if (status == OrderStatus.delivered)
                          const Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Icon(Icons.check, size: 18),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 12),

          // Details Row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('نوع العباية', style: AppTextStyles.bodySmall),
                    Text(order.abayaType, style: AppTextStyles.bodyMedium),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('تاريخ التسليم', style: AppTextStyles.bodySmall),
                    Text(
                      order.deliveryDate != null
                          ? Formatters.date(order.deliveryDate!)
                          : '-',
                      style: AppTextStyles.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Price Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Formatters.currency(order.totalPrice),
                style: AppTextStyles.price,
              ),
              totalPaidAsync.when(
                loading: () => const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                error: (_, __) => const SizedBox.shrink(),
                data: (totalPaid) {
                  final remaining = order.totalPrice - totalPaid;
                  if (remaining > 0) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.error.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'متبقي: ${Formatters.currencyNoSymbol(remaining)}',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    );
                  }
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.statusDelivered.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'مكتمل',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.statusDelivered,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _updateStatus(BuildContext context, WidgetRef ref, OrderStatus newStatus) async {
  if (OrderStatus.fromName(order.status) == newStatus) return;

  // Check if trying to set status to delivered
  if (newStatus == OrderStatus.delivered) {
    final db = ref.read(databaseProvider);
    final totalPaid = await db.getTotalPaidForOrder(order.id);
    final remaining = order.totalPrice - totalPaid;

    if (remaining > 0) {
      // Show warning - cannot deliver with remaining balance
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            icon: Icon(Icons.warning_amber_rounded, color: AppColors.warning, size: 48),
            title: const Text('لا يمكن تغيير الحالة'),
            content: Text(
              'لا يمكن تغيير حالة الطلب إلى "تم التسليم" لأن هناك مبلغ متبقي: ${Formatters.currency(remaining)}',
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('حسناً'),
              ),
            ],
          ),
        );
      }
      return;
    }
  }

  try {
    final db = ref.read(databaseProvider);
    await db.updateOrderById(
      order.id,
      OrdersCompanion(
        status: drift.Value(newStatus.name),
        updatedAt: drift.Value(DateTime.now()),
      ),
    );

    ref.invalidate(allOrdersProvider);
    ref.invalidate(filteredOrdersProvider);
    ref.invalidate(dashboardStatsProvider);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم تغيير الحالة إلى ${newStatus.displayName}')),
      );
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ: $e')),
      );
    }
  }
}
}
