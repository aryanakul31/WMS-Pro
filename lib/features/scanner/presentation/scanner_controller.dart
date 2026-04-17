import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wms_pro/features/inventory/data/inventory_repository.dart';
import 'package:wms_pro/features/inventory/domain/stock_item.dart';

class ScannerController extends GetxController {
  final MobileScannerController cameraController = MobileScannerController();

  final RxnString scannedCode = RxnString();
  final Rxn<StockItem> matchedItem = Rxn<StockItem>();
  final RxBool hasPermission = false.obs;
  final RxBool isLoading = false.obs;
  final RxnString error = RxnString();

  @override
  void onReady() {
    super.onReady();
    _requestPermission();
  }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }

  Future<void> _requestPermission() async {
    final status = await Permission.camera.request();
    hasPermission.value = status.isGranted;
  }

  Future<void> onDetect(BarcodeCapture capture) async {
    final code = capture.barcodes.firstOrNull?.rawValue;
    if (code == null || code == scannedCode.value) return;
    scannedCode.value = code;
    isLoading.value = true;
    error.value = null;
    try {
      final repo = Get.find<InventoryRepository>();
      matchedItem.value = await repo.getByBarcode(code);
    } catch (e) {
      error.value = 'Lookup failed';
    } finally {
      isLoading.value = false;
    }
  }

  void reset() {
    scannedCode.value = null;
    matchedItem.value = null;
    error.value = null;
  }
}
