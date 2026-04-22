import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wms_pro/features/auth/presentation/auth_controller.dart';
import 'package:wms_pro/features/dashboard/presentation/dashboard_page.dart';
import 'package:wms_pro/features/inventory/presentation/item_list_page.dart';
import 'package:wms_pro/features/invoices/presentation/invoice_list_page.dart';
import 'package:wms_pro/features/scanner/presentation/scanner_page.dart';
import 'package:wms_pro/features/settings/presentation/settings_page.dart';

class ShellController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void setIndex(int index) => currentIndex.value = index;

  List<Widget> get pages {
    final auth = Get.find<AuthController>();
    final isAdmin = auth.isAdmin;

    return [
      const DashboardPage(),
      const ItemListPage(),
      const ScannerPage(),
      if (isAdmin) const InvoiceListPage(),
      const SettingsPage(),
    ];
  }

  int get effectiveIndex {
    if (currentIndex.value >= pages.length) {
      return 0;
    }
    return currentIndex.value;
  }
}
