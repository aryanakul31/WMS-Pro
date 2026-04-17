import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:wms_pro/core/theme/app_colors.dart';
import 'package:wms_pro/core/theme/app_text_styles.dart';
import 'package:wms_pro/features/inventory/presentation/inventory_controller.dart';
import 'scanner_controller.dart';

class ScannerPage extends GetView<ScannerController> {
  const ScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner'),
        actions: [
          Obx(() => controller.scannedCode.value != null
              ? IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: controller.reset,
                )
              : const SizedBox.shrink()),
        ],
      ),
      body: Obx(() {
        if (!controller.hasPermission.value) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.camera_alt_outlined,
                      size: 64, color: AppColors.disabled),
                  const SizedBox(height: 16),
                  Text(
                    'Camera access required.\nEnable it in Settings.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyMedium,
                  ),
                ],
              ),
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              flex: 3,
              child: MobileScanner(
                controller: controller.cameraController,
                onDetect: controller.onDetect,
              ),
            ),
            Expanded(
              flex: 2,
              child: _ResultPanel(),
            ),
          ],
        );
      }),
    );
  }
}

class _ResultPanel extends GetView<ScannerController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final code = controller.scannedCode.value;
      if (code == null) {
        return Center(
          child: Text(
            'Point the camera at a barcode or QR code',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium
                .copyWith(color: AppColors.onSurfaceVariant),
          ),
        );
      }

      final item = controller.matchedItem.value;
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Scan Result', style: AppTextStyles.heading3),
            const SizedBox(height: 8),
            Text(code,
                style: AppTextStyles.bodySmall
                    .copyWith(color: AppColors.mustardYellow)),
            const Divider(height: 24),
            if (item == null)
              Text('No item matched this barcode',
                  style: AppTextStyles.bodyMedium
                      .copyWith(color: AppColors.disabled))
            else ...[
              Text(item.name, style: AppTextStyles.bodyLarge),
              const SizedBox(height: 4),
              Text('SKU: ${item.sku}  ·  Qty: ${item.quantity} ${item.unit}',
                  style: AppTextStyles.bodySmall),
              const SizedBox(height: 4),
              Text('Location: ${item.location}',
                  style: AppTextStyles.bodySmall),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Get.find<InventoryController>().openEdit(item);
                },
                child: const Text('Edit Item'),
              ),
            ],
          ],
        ),
      );
    });
  }
}
