import 'package:flutter/material.dart';
import 'package:wms_pro/l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:wms_pro/core/constants/app_constants.dart';
import 'package:wms_pro/core/constants/app_routes.dart';
import 'package:wms_pro/core/routes.dart';
import 'package:wms_pro/core/storage/local_storage.dart';
import 'package:wms_pro/core/theme/app_theme.dart';

class WmsApp extends StatelessWidget {
  const WmsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final savedLocale = LocalStorage.getString(StorageKeys.locale);
    return GetMaterialApp(
      title: 'WMS Pro',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
      locale: savedLocale != null ? Locale(savedLocale) : const Locale('en'),
      fallbackLocale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
