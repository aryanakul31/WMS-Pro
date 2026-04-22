import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wms_pro/core/theme/app_colors.dart';
import 'package:wms_pro/core/theme/app_text_styles.dart';
import 'package:wms_pro/l10n/app_localizations.dart';
import 'inventory_controller.dart';

class ItemDetailPage extends GetView<InventoryController> {
  const ItemDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isEdit = controller.selectedItem.value != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? l10n.editItem : l10n.addItem),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _field(controller.skuController, l10n.sku),
            const SizedBox(height: 24),
            _field(controller.nameController, l10n.itemName),
            const SizedBox(height: 24),
            _field(controller.descriptionController, l10n.description,
                maxLines: 3),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _field(
                    controller.quantityController,
                    l10n.quantity,
                    inputType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _field(controller.unitController, l10n.unit),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _field(controller.locationController, l10n.location),
            const SizedBox(height: 24),
            _field(controller.barcodeController, l10n.barcode),
            const SizedBox(height: 16),
            Obx(() {
              final err = controller.error.value;
              if (err == null) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  err,
                  style: AppTextStyles.bodySmall
                      .copyWith(color: AppColors.danger),
                ),
              );
            }),
            const SizedBox(height: 32),
            Obx(() => ElevatedButton(
                  onPressed:
                      controller.isLoading.value ? null : controller.save,
                  child: controller.isLoading.value
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.white,
                          ),
                        )
                      : Text(l10n.save),
                )),
            if (isEdit) ...[
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () async {
                  final confirmed = await _confirmDelete(context);
                  if (confirmed == true) {
                    await controller.delete(controller.selectedItem.value!.id);
                    Get.back();
                  }
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.danger,
                  side: const BorderSide(color: AppColors.danger),
                ),
                child: Text(l10n.deleteItem),
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
        decoration: InputDecoration(
          labelText: label,
          alignLabelWithHint: maxLines > 1,
        ),
      );

  Future<bool?> _confirmDelete(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(l10n.deleteItem),
        content: Text(l10n.confirm),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: Text(
              l10n.delete,
              style: const TextStyle(color: AppColors.danger),
            ),
          ),
        ],
      ),
    );
  }
}
