import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wms_pro/core/theme/app_colors.dart';
import 'package:wms_pro/core/theme/app_text_styles.dart';
import 'package:wms_pro/features/auth/presentation/auth_controller.dart';
import 'inventory_controller.dart';

class ItemListPage extends GetView<InventoryController> {
  const ItemListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inventory')),
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
                    child: const Text('Try Again')),
              ],
            ),
          );
        }
        if (controller.items.isEmpty) {
          return Center(
            child: Text('No items yet', style: AppTextStyles.bodyMedium),
          );
        }
        return RefreshIndicator(
          onRefresh: controller.loadItems,
          color: AppColors.redNCS,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: controller.items.length,
            itemBuilder: (_, i) {
              final item = controller.items[i];
              return Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  title: Text(item.name, style: AppTextStyles.bodyLarge),
                  subtitle: Text(
                    'SKU: ${item.sku}  ·  ${item.location}',
                    style: AppTextStyles.bodySmall,
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${item.quantity} ${item.unit}',
                        style: AppTextStyles.heading3.copyWith(
                          color: item.quantity < 5
                              ? AppColors.redNCS
                              : AppColors.mustardYellow,
                        ),
                      ),
                    ],
                  ),
                  onTap: Get.find<AuthController>().isAdmin
                      ? () => controller.openEdit(item)
                      : null,
                ),
              );
            },
          ),
        );
      }),
      floatingActionButton: Obx(() {
        if (!Get.find<AuthController>().isAdmin) return const SizedBox.shrink();
        return FloatingActionButton(
          onPressed: controller.openAdd,
          child: const Icon(Icons.add),
        );
      }),
    );
  }
}
