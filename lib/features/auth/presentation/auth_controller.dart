import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wms_pro/core/constants/app_constants.dart';
import 'package:wms_pro/core/constants/app_routes.dart';
import 'package:wms_pro/core/storage/local_storage.dart';
import '../data/auth_repository.dart';
import '../domain/app_user.dart';

class AuthController extends GetxController {
  final AuthRepository repository;
  AuthController({required this.repository});

  final Rxn<AppUser> currentUser = Rxn<AppUser>();
  final RxBool isLoading = false.obs;
  final RxnString error = RxnString();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      error.value = 'Email and password are required';
      return;
    }
    error.value = null;
    isLoading.value = true;
    try {
      final user = await repository.login(email, password);
      if (user == null) {
        error.value = 'Invalid email or password';
        return;
      }
      currentUser.value = user;
      await LocalStorage.setInt(StorageKeys.currentUserId, user.id);
      Get.offAllNamed(AppRoutes.shell);
    } catch (e) {
      error.value = 'Something went wrong';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> restoreSession() async {
    final userId = LocalStorage.getInt(StorageKeys.currentUserId);
    if (userId == null) return;
    final user = await repository.findById(userId);
    currentUser.value = user;
  }

  Future<void> logout() async {
    await LocalStorage.remove(StorageKeys.currentUserId);
    currentUser.value = null;
    Get.offAllNamed(AppRoutes.login);
  }

  bool get isAdmin => currentUser.value?.role == UserRole.admin;
}
