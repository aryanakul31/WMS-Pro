import 'package:get/get.dart';
import 'package:wms_pro/features/inventory/data/inventory_repository.dart';
import 'package:wms_pro/features/invoices/data/invoice_repository.dart';

class DashboardController extends GetxController {
  final InventoryRepository inventoryRepo;
  final InvoiceRepository invoiceRepo;

  DashboardController({
    required this.inventoryRepo,
    required this.invoiceRepo,
  });

  final RxInt totalItems = 0.obs;
  final RxInt totalInvoices = 0.obs;
  final RxBool isLoading = false.obs;
  final RxnString error = RxnString();

  @override
  void onReady() {
    super.onReady();
    load();
  }

  Future<void> load() async {
    isLoading.value = true;
    error.value = null;
    try {
      totalItems.value = await inventoryRepo.totalCount();
      final invoices = await invoiceRepo.getAll();
      totalInvoices.value = invoices.length;
    } catch (e) {
      error.value = 'Failed to load dashboard data';
    } finally {
      isLoading.value = false;
    }
  }
}
