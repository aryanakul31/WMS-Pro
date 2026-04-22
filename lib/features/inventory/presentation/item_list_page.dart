import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wms_pro/core/theme/app_colors.dart';
import 'package:wms_pro/core/theme/app_text_styles.dart';
import 'package:wms_pro/features/auth/presentation/auth_controller.dart';
import 'package:wms_pro/l10n/app_localizations.dart';
import 'inventory_controller.dart';

class ItemListPage extends GetView<InventoryController> {
  const ItemListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.inventory)),
      body: Obx(() {
        if (controller.isLoading.value && controller.items.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.error.value != null && controller.items.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(controller.error.value!, style: AppTextStyles.bodyMedium),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.loadItems,
                  child: Text(l10n.tryAgain),
                ),
              ],
            ),
          );
        }
        if (controller.items.isEmpty) {
          return Center(
            child: Text(l10n.noItems, style: AppTextStyles.bodyMedium),
          );
        }
        return RefreshIndicator(
          onRefresh: controller.loadItems,
          color: AppColors.blue60,
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: controller.items.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (_, i) {
              final item = controller.items[i];
              return Material(
                color: AppColors.background,
                child: InkWell(
                  onTap: Get.find<AuthController>().isAdmin
                      ? () => controller.openEdit(item)
                      : null,
                  hoverColor: AppColors.layer01Hover,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.name, style: AppTextStyles.bodyLarge),
                              const SizedBox(height: 4),
                              Text(
                                '${l10n.sku}: ${item.sku}  ·  ${item.location}',
                                style: AppTextStyles.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${item.quantity} ${item.unit}',
                              style: AppTextStyles.heading3.copyWith(
                                color: item.quantity < 5
                                    ? AppColors.danger
                                    : AppColors.text01,
                              ),
                            ),
                            if (item.quantity < 5)
                              Text(
                                l10n.lowStockAlert,
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.danger,
                                  fontSize: 10,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.chevron_right_rounded,
                          color: AppColors.text03,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
      floatingActionButton: Obx(() {
        if (!Get.find<AuthController>().isAdmin) return const SizedBox.shrink();
        return FloatingActionButton(
          heroTag: 'fab_inventory',
          onPressed: controller.openAdd,
          child: const Icon(Icons.add),
        );
      }),
    );
  }
}
