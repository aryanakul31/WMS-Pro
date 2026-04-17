import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wms_pro/core/constants/app_constants.dart';
import 'package:wms_pro/core/storage/local_storage.dart';
import 'package:wms_pro/features/auth/presentation/auth_controller.dart';

class SettingsController extends GetxController {
  final RxString locale = 'en'.obs;

  @override
  void onInit() {
    super.onInit();
    locale.value = LocalStorage.getString(StorageKeys.locale) ?? 'en';
  }

  Future<void> setLocale(String code) async {
    locale.value = code;
    await LocalStorage.setString(StorageKeys.locale, code);
    Get.updateLocale(Locale(code));
  }

  Future<void> logout() => Get.find<AuthController>().logout();
}
