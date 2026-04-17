import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wms_pro/features/auth/data/auth_repository.dart';
import 'package:wms_pro/features/auth/domain/app_user.dart';
import 'package:wms_pro/features/auth/presentation/auth_controller.dart';
import 'package:wms_pro/features/inventory/domain/stock_item.dart';
import 'package:wms_pro/features/invoices/domain/invoice.dart';
import 'core/storage/local_storage.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalStorage.init();

  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [AppUserSchema, StockItemSchema, InvoiceSchema],
    directory: dir.path,
    name: 'wms_pro',
  );
  Get.put<Isar>(isar, permanent: true);

  final authRepo = LocalAuthRepository(isar: isar);
  await authRepo.seedDefaultAdmin();

  Get.put<AuthController>(
    AuthController(repository: authRepo),
    permanent: true,
  );

  FlutterError.onError = FlutterError.presentError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FlutterError.presentError(
        FlutterErrorDetails(exception: error, stack: stack));
    return true;
  };

  runApp(const WmsApp());
}
