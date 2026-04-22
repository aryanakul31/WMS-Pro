import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wms_pro/core/theme/app_colors.dart';
import 'package:wms_pro/core/theme/app_text_styles.dart';
import 'package:wms_pro/features/auth/presentation/auth_controller.dart';
import 'package:wms_pro/l10n/app_localizations.dart';
import 'settings_controller.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _UserCard(),
          const SizedBox(height: 32),
          Text(l10n.language, style: AppTextStyles.label),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderSubtle),
            ),
            child: Obx(() => Column(
                  children: [
                    _LocaleTile(
                      title: l10n.english,
                      selected: controller.locale.value == 'en',
                      onTap: () => controller.setLocale('en'),
                    ),
                    const Divider(height: 1),
                    _LocaleTile(
                      title: l10n.dutch,
                      selected: controller.locale.value == 'nl',
                      onTap: () => controller.setLocale('nl'),
                    ),
                  ],
                )),
          ),
          const SizedBox(height: 48),
          OutlinedButton(
            onPressed: controller.logout,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.danger,
              side: const BorderSide(color: AppColors.danger),
            ),
            child: Text(l10n.logoutButton),
          ),
        ],
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final auth = Get.find<AuthController>();
    return Obx(() {
      final user = auth.currentUser.value;
      if (user == null) return const SizedBox.shrink();
      return Container(
        padding: const EdgeInsets.all(16),
        color: AppColors.layer01,
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              color: AppColors.blue60,
              alignment: Alignment.center,
              child: Text(
                user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                style: AppTextStyles.heading3.copyWith(color: AppColors.white),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.name, style: AppTextStyles.bodyLarge),
                  const SizedBox(height: 2),
                  Text(user.email, style: AppTextStyles.bodySmall),
                  const SizedBox(height: 4),
                  Text(
                    auth.isAdmin ? l10n.roleAdmin : l10n.roleVendor,
                    style: AppTextStyles.label.copyWith(fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _LocaleTile extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _LocaleTile({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.layer01 : AppColors.background,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Text(title, style: AppTextStyles.bodyMedium),
              const Spacer(),
              if (selected)
                const Icon(Icons.check_rounded,
                    color: AppColors.blue60, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
