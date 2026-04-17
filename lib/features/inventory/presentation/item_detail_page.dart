import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wms_pro/core/theme/app_colors.dart';
import 'package:wms_pro/core/theme/app_text_styles.dart';
import 'inventory_controller.dart';

class ItemDetailPage extends GetView<InventoryController> {
  const ItemDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isEdit = controller.selectedItem.value != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Item' : 'Add Item'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _field(controller.skuController, 'SKU'),
            const SizedBox(height: 14),
            _field(controller.nameController, 'Item Name'),
            const SizedBox(height: 14),
            _field(controller.descriptionController, 'Description',
                maxLines: 3),
            const SizedBox(height: 14),
            _field(
              controller.quantityController,
              'Quantity',
              inputType: TextInputType.number,
            ),
            const SizedBox(height: 14),
            _field(controller.unitController, 'Unit (e.g. pcs, kg)'),
            const SizedBox(height: 14),
            _field(controller.locationController, 'Location'),
            const SizedBox(height: 14),
            _field(controller.barcodeController, 'Barcode'),
            const SizedBox(height: 12),
            Obx(() {
              final err = controller.error.value;
              if (err == null) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(err,
                    style: AppTextStyles.bodySmall
                        .copyWith(color: AppColors.redNCS)),
              );
            }),
            const SizedBox(height: 20),
            Obx(() => ElevatedButton(
                  onPressed:
                      controller.isLoading.value ? null : controller.save,
                  child: controller.isLoading.value
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: AppColors.white),
                        )
                      : const Text('Save'),
                )),
            if (isEdit) ...[
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () async {
                  final confirmed = await _confirmDelete(context);
                  if (confirmed == true) {
                    await controller
                        .delete(controller.selectedItem.value!.id);
                    Get.back();
                  }
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.redNCS,
                  side: const BorderSide(color: AppColors.redNCS),
                ),
                child: const Text('Delete Item'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController ctrl,
    String label, {
    TextInputType inputType = TextInputType.text,
    int maxLines = 1,
  }) =>
      TextField(
        controller: ctrl,
        keyboardType: inputType,
        maxLines: maxLines,
        style: AppTextStyles.bodyLarge,
        decoration: InputDecoration(labelText: label),
      );

  Future<bool?> _confirmDelete(BuildContext context) => showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Delete Item'),
          content: const Text('This cannot be undone.'),
          actions: [
            TextButton(
                onPressed: () => Get.back(result: false),
                child: const Text('Cancel')),
            TextButton(
                onPressed: () => Get.back(result: true),
                child: Text('Delete',
                    style: TextStyle(color: AppColors.redNCS))),
          ],
        ),
      );
}
