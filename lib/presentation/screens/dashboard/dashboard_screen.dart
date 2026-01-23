import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/formatters.dart';
import '../../../providers.dart';
import '../../common/lavent_card.dart';
import '../notifications/notifications_screen.dart';


class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(dashboardStatsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة التحكم'),
        actions: const [
          NotificationBell(),
          SizedBox(width: 8),
        ],
      ),
      drawer: _buildDrawer(context),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(dashboardStatsProvider);
        },
        child: statsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('خطأ: $err')),
          data: (stats) => _buildDashboard(context, stats),
        ),
      ),
    );
  }

  Widget _buildDashboard(BuildContext context, DashboardStats stats) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Header
          Text(
            'مرحباً بك',
            style: AppTextStyles.headlineLarge,
          ),
          const SizedBox(height: 4),
          Text(
            'إليك ملخص أعمال اليوم',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),

          // Stats Grid
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.1,
            children: [
              _StatCardItem(
                icon: Icons.shopping_bag_rounded,
                value: stats.totalActiveOrders.toString(),
                label: 'طلبات نشطة',
                color: AppColors.accent,
              ),
              _StatCardItem(
                icon: Icons.fiber_new_rounded,
                value: stats.newOrders.toString(),
                label: 'طلبات جديدة',
                color: AppColors.statusNew,
              ),
              _StatCardItem(
                icon: Icons.pending_actions_rounded,
                value: stats.processingOrders.toString(),
                label: 'قيد التنفيذ',
                color: AppColors.statusProcessing,
              ),
              _StatCardItem(
                icon: Icons.check_circle_rounded,
                value: stats.deliveredOrders.toString(),
                label: 'تم التسليم',
                color: AppColors.statusDelivered,
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Income Cards
          LaventCard(
            margin: EdgeInsets.zero,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'إيرادات اليوم',
                        style: AppTextStyles.bodySmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        Formatters.currency(stats.todayIncome),
                        style: AppTextStyles.price,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 60,
                  color: AppColors.divider,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'إجمالي الإيرادات',
                          style: AppTextStyles.bodySmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          Formatters.currency(stats.totalIncome),
                          style: AppTextStyles.headlineSmall.copyWith(
                            color: AppColors.statusDelivered,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Quick Actions
          Text(
            'إجراءات سريعة',
            style: AppTextStyles.headlineSmall,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _QuickActionButton(
                  icon: Icons.add_shopping_cart_rounded,
                  label: 'طلب جديد',
                  onTap: () {
                    Navigator.pushNamed(context, '/orders/new');
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _QuickActionButton(
                  icon: Icons.receipt_long_rounded,
                  label: 'سند قبض',
                  onTap: () {
                    Navigator.pushNamed(context, '/receipts');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.surfaceSecondary.withOpacity(0.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.storefront_rounded,
                      color: AppColors.accent,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'لافينت',
                    style: AppTextStyles.headlineMedium,
                  ),
                  Text(
                    'إدارة الطلبات والفواتير',
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Menu Items
            _DrawerItem(
              icon: Icons.dashboard_rounded,
              label: 'لوحة التحكم',
              isSelected: true,
              onTap: () => Navigator.pop(context),
            ),
            _DrawerItem(
              icon: Icons.shopping_bag_rounded,
              label: 'الطلبات',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/orders');
              },
            ),
            _DrawerItem(
              icon: Icons.receipt_long_rounded,
              label: 'سندات القبض',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/receipts');
              },
            ),
            _DrawerItem(
              icon: Icons.picture_as_pdf_rounded,
              label: 'الفواتير',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/invoices');
              },
            ),
            const Divider(),
            _DrawerItem(
              icon: Icons.settings_rounded,
              label: 'الإعدادات',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/settings');
              },
            ),

            const Spacer(),

            // Version
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'الإصدار 1.0.0',
                style: AppTextStyles.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCardItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatCardItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return LaventCard(
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: AppTextStyles.headlineMedium.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(label, style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return LaventCard(
      margin: EdgeInsets.zero,
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.accent),
          const SizedBox(width: 8),
          Text(
            label,
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.label,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppColors.accent : AppColors.textSecondary,
      ),
      title: Text(
        label,
        style: AppTextStyles.bodyLarge.copyWith(
          color: isSelected ? AppColors.accent : AppColors.textPrimary,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
      selected: isSelected,
      selectedTileColor: AppColors.accent.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      onTap: onTap,
    );
  }
}
