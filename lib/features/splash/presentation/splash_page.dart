import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wms_pro/core/theme/app_colors.dart';
import 'package:wms_pro/core/theme/app_text_styles.dart';
import 'splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkCrimson,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.mustardYellow,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.inventory_2_rounded,
                size: 44,
                color: AppColors.darkCrimson,
              ),
            ),
            const SizedBox(height: 20),
            Text('WMS Pro', style: AppTextStyles.heading1),
            const SizedBox(height: 8),
            Text(
              'Launch Fast. Scale Smart. Profit Early.',
              style: AppTextStyles.bodySmall,
            ),
            const SizedBox(height: 48),
            const CircularProgressIndicator(color: AppColors.mustardYellow),
          ],
        ),
      ),
    );
  }
}
