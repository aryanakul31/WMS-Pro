import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:wms_pro/core/theme/app_colors.dart';
import 'package:wms_pro/core/theme/app_text_styles.dart';
import 'package:wms_pro/features/auth/presentation/auth_controller.dart';
import 'package:wms_pro/features/inventory/presentation/inventory_controller.dart';
import 'package:wms_pro/l10n/app_localizations.dart';
import 'scanner_controller.dart';

class ScannerPage extends GetView<ScannerController> {
  const ScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.scanner),
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
              padding: const EdgeInsets.all(48),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.camera_alt_outlined,
                      size: 64, color: AppColors.text03),
                  const SizedBox(height: 24),
                  Text(
                    l10n.cameraPermissionDenied,
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
              child: Stack(
                children: [
                  MobileScanner(
                    controller: controller.cameraController,
                    onDetect: controller.onDetect,
                  ),
                  // Simple scan overlay box
                  Center(
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.blue60, width: 2),
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                ],
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
    final l10n = AppLocalizations.of(context)!;
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final code = controller.scannedCode.value;
      if (code == null) {
        return Container(
          color: AppColors.background,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Text(
                l10n.scanningInstruction,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.text02),
              ),
            ),
          ),
        );
      }

      final item = controller.matchedItem.value;
      return Container(
        color: AppColors.background,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.scanResult, style: AppTextStyles.label),
            const SizedBox(height: 4),
            Text(
              code,
              style: AppTextStyles.heading3.copyWith(color: AppColors.blue60),
            ),
            const Divider(height: 32),
            if (item == null)
              Expanded(
                child: Text(
                  l10n.itemNotFound,
                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.text03),
                ),
              )
            else ...[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name, style: AppTextStyles.bodyLarge),
                    const SizedBox(height: 8),
                    Text(
                      '${l10n.sku}: ${item.sku}  ·  ${l10n.quantity}: ${item.quantity} ${item.unit}',
                      style: AppTextStyles.bodySmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${l10n.location}: ${item.location}',
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              if (Get.find<AuthController>().isAdmin)
                ElevatedButton(
                  onPressed: () {
                    Get.find<InventoryController>().openEdit(item);
                  },
                  child: Text(l10n.editItem),
                ),
            ],
          ],
        ),
      );
    });
  }
}
