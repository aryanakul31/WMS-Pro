import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wms_pro/core/theme/app_colors.dart';
import 'package:wms_pro/core/theme/app_text_styles.dart';
import 'package:wms_pro/features/auth/presentation/auth_controller.dart';
import 'settings_controller.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _UserCard(),
          const SizedBox(height: 16),
          Card(
            margin: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text('Language', style: AppTextStyles.label),
                ),
                Obx(() => Column(
                      children: [
                        _LocaleTile(
                          title: 'English',
                          code: 'en',
                          selected: controller.locale.value == 'en',
                          onTap: () => controller.setLocale('en'),
                        ),
                        _LocaleTile(
                          title: 'Nederlands',
                          code: 'nl',
                          selected: controller.locale.value == 'nl',
                          onTap: () => controller.setLocale('nl'),
                        ),
                      ],
                    )),
              ],
            ),
          ),
          const SizedBox(height: 24),
          OutlinedButton(
            onPressed: controller.logout,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.redNCS,
              side: const BorderSide(color: AppColors.redNCS),
            ),
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    return Obx(() {
      final user = auth.currentUser.value;
      if (user == null) return const SizedBox.shrink();
      return Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.mustardYellow,
                radius: 24,
                child: Text(
                  user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                  style: AppTextStyles.heading3
                      .copyWith(color: AppColors.black),
                ),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.name, style: AppTextStyles.bodyLarge),
                  const SizedBox(height: 2),
                  Text(user.email, style: AppTextStyles.bodySmall),
                  const SizedBox(height: 2),
                  Text(
                    auth.isAdmin ? 'Admin' : 'Vendor',
                    style: AppTextStyles.label,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _LocaleTile extends StatelessWidget {
  final String title;
  final String code;
  final bool selected;
  final VoidCallback onTap;

  const _LocaleTile({
    required this.title,
    required this.code,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: AppTextStyles.bodyMedium),
      trailing: selected
          ? const Icon(Icons.check_rounded, color: AppColors.mustardYellow)
          : null,
      onTap: onTap,
    );
  }
}
