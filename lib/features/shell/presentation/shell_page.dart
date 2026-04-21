import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wms_pro/core/theme/app_colors.dart';
import 'package:wms_pro/features/auth/presentation/auth_controller.dart';
import 'package:wms_pro/l10n/app_localizations.dart';
import 'shell_controller.dart';

class ShellPage extends GetView<ShellController> {
  const ShellPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final auth = Get.find<AuthController>();

    return Obx(() {
      final pages = controller.pages;
      final isAdmin = auth.isAdmin;

      return Scaffold(
        body: IndexedStack(
          index: controller.effectiveIndex,
          children: pages,
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: AppColors.borderSubtle, width: 1),
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: controller.effectiveIndex,
            onTap: controller.setIndex,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.dashboard_outlined),
                activeIcon: const Icon(Icons.dashboard_rounded),
                label: l10n.dashboard,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.inventory_2_outlined),
                activeIcon: const Icon(Icons.inventory_2_rounded),
                label: l10n.inventory,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.qr_code_scanner_outlined),
                activeIcon: const Icon(Icons.qr_code_scanner_rounded),
                label: l10n.scanner,
              ),
              if (isAdmin)
                BottomNavigationBarItem(
                  icon: const Icon(Icons.receipt_long_outlined),
                  activeIcon: const Icon(Icons.receipt_long_rounded),
                  label: l10n.invoices,
                ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.settings_outlined),
                activeIcon: const Icon(Icons.settings_rounded),
                label: l10n.settings,
              ),
            ],
          ),
        ),
      );
    });
  }
}
