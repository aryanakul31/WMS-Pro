import 'package:get/get.dart';
import 'package:wms_pro/core/constants/app_routes.dart';
import 'package:wms_pro/features/auth/presentation/auth_controller.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _boot();
  }

  Future<void> _boot() async {
    await Future.delayed(const Duration(milliseconds: 1400));
    final authCtrl = Get.find<AuthController>();
    await authCtrl.restoreSession();
    if (authCtrl.currentUser.value != null) {
      Get.offAllNamed(AppRoutes.shell);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
