import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:wms_pro/features/auth/presentation/login_page.dart';
import 'package:wms_pro/features/dashboard/presentation/dashboard_controller.dart';
import 'package:wms_pro/features/inventory/data/inventory_repository.dart';
import 'package:wms_pro/features/inventory/presentation/inventory_controller.dart';
import 'package:wms_pro/features/inventory/presentation/item_detail_page.dart';
import 'package:wms_pro/features/invoices/data/invoice_repository.dart';
import 'package:wms_pro/features/invoices/presentation/invoice_controller.dart';
import 'package:wms_pro/features/invoices/presentation/invoice_detail_page.dart';
import 'package:wms_pro/features/scanner/presentation/scanner_controller.dart';
import 'package:wms_pro/features/settings/presentation/settings_controller.dart';
import 'package:wms_pro/features/shell/presentation/shell_controller.dart';
import 'package:wms_pro/features/shell/presentation/shell_page.dart';
import 'package:wms_pro/features/splash/presentation/splash_controller.dart';
import 'package:wms_pro/features/splash/presentation/splash_page.dart';
import 'constants/app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      binding: _SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: AppRoutes.shell,
      page: () => const ShellPage(),
      bindings: [
        _ShellBinding(),
        _DashboardBinding(),
        _InventoryBinding(),
        _InvoiceBinding(),
        _ScannerBinding(),
        _SettingsBinding(),
      ],
    ),
    GetPage(
      name: AppRoutes.itemDetail,
      page: () => const ItemDetailPage(),
      binding: _InventoryBinding(),
    ),
    GetPage(
      name: AppRoutes.invoiceDetail,
      page: () => const InvoiceDetailPage(),
      binding: _InvoiceBinding(),
    ),
  ];
}

class _SplashBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => SplashController());
}

class _ShellBinding extends Bindings {
  @override
  void dependencies() =>
      Get.lazyPut(() => ShellController(), fenix: true);
}

class _DashboardBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(
        () => DashboardController(
          inventoryRepo: LocalInventoryRepository(isar: Get.find<Isar>()),
          invoiceRepo: LocalInvoiceRepository(isar: Get.find<Isar>()),
        ),
        fenix: true,
      );
}

class _InventoryBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(
        () => InventoryController(
          repository: LocalInventoryRepository(isar: Get.find<Isar>()),
        ),
        fenix: true,
      );
}

class _InvoiceBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(
        () => InvoiceController(
          repository: LocalInvoiceRepository(isar: Get.find<Isar>()),
          inventoryRepo: LocalInventoryRepository(isar: Get.find<Isar>()),
        ),
        fenix: true,
      );
}

class _ScannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InventoryRepository>(
      () => LocalInventoryRepository(isar: Get.find<Isar>()),
      fenix: true,
    );
    Get.lazyPut(() => ScannerController(), fenix: true);
  }
}

class _SettingsBinding extends Bindings {
  @override
  void dependencies() =>
      Get.lazyPut(() => SettingsController(), fenix: true);
}
