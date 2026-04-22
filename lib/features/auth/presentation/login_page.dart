import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wms_pro/core/theme/app_colors.dart';
import 'package:wms_pro/core/theme/app_text_styles.dart';
import 'package:wms_pro/l10n/app_localizations.dart';
import 'auth_controller.dart';

class LoginPage extends GetView<AuthController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      color: AppColors.blue60,
                      child: const Icon(Icons.inventory_2_rounded,
                          color: AppColors.white, size: 24),
                    ),
                    const SizedBox(width: 12),
                    Text(l10n.appTitle, style: AppTextStyles.heading2),
                  ],
                ),
                const SizedBox(height: 48),
                Text(l10n.welcomeBack, style: AppTextStyles.heading1),
                const SizedBox(height: 8),
                Text(
                  l10n.signInSubtitle,
                  style: AppTextStyles.bodyMedium
                      .copyWith(color: AppColors.text02),
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  style: AppTextStyles.bodyLarge,
                  decoration: InputDecoration(labelText: l10n.emailLabel),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: controller.passwordController,
                  obscureText: true,
                  style: AppTextStyles.bodyLarge,
                  decoration: InputDecoration(labelText: l10n.passwordLabel),
                  onSubmitted: (_) => controller.login(),
                ),
                const SizedBox(height: 12),
                Obx(() {
                  final err = controller.error.value;
                  if (err == null) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      err,
                      style: AppTextStyles.bodySmall
                          .copyWith(color: AppColors.danger),
                    ),
                  );
                }),
                const SizedBox(height: 24),
                Obx(() => ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : controller.login,
                      child: controller.isLoading.value
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.white,
                              ),
                            )
                          : Text(l10n.loginButton),
                    )),
                const SizedBox(height: 48),
                Text(
                  l10n.defaultAdminNote,
                  style: AppTextStyles.caption.copyWith(fontSize: 11),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
