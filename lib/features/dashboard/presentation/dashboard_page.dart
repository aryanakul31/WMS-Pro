import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wms_pro/core/theme/app_colors.dart';
import 'package:wms_pro/core/theme/app_text_styles.dart';
import 'package:wms_pro/features/auth/presentation/auth_controller.dart';
import 'package:wms_pro/l10n/app_localizations.dart';
import 'dashboard_controller.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.dashboard)),
      body: Obx(() {
        final auth = Get.find<AuthController>();
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.error.value != null) {
          return _ErrorState(
            message: controller.error.value!,
            onRetry: controller.load,
          );
        }
        return RefreshIndicator(
          onRefresh: controller.load,
          color: AppColors.blue60,
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              _GreetingBanner(),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      label: l10n.inventory,
                      value: '${controller.totalItems.value}',
                      icon: Icons.inventory_2_rounded,
                    ),
                  ),
                  if (auth.isAdmin) ...[
                    const SizedBox(width: 1),
                    Expanded(
                      child: _StatCard(
                        label: l10n.invoices,
                        value: '${controller.totalInvoices.value}',
                        icon: Icons.receipt_long_rounded,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _GreetingBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final auth = Get.find<AuthController>();
    return Obx(() {
      final name = auth.currentUser.value?.name ?? '';
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.hello(name), style: AppTextStyles.heading2),
          const SizedBox(height: 4),
          Text(
            auth.isAdmin ? l10n.roleAdmin : l10n.roleVendor,
            style: AppTextStyles.label,
          ),
        ],
      );
    });
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Container(
        height: 160,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.blue60, size: 24),
            const Spacer(),
            Text(value, style: AppTextStyles.heading1),
            const SizedBox(height: 4),
            Text(label, style: AppTextStyles.label),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message, style: AppTextStyles.bodyMedium),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: onRetry, child: Text(l10n.tryAgain)),
        ],
      ),
    );
  }
}
