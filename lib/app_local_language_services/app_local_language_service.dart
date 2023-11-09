import 'dart:ui';

import 'package:get/get.dart';

class LocalLanguageService extends GetxService {
  static LocalLanguageService get instance => Get.find();
  static const Locale arabicLocale = const Locale('ar', 'AR');
  static const Locale englishLocale = const Locale('en', 'US');

  bool _isCurrentLocaleEqualTo(Locale? locale) =>
      locale?.languageCode == Get.locale?.languageCode;

  static bool isCurrentLocaleEqualTo(Locale? locale) {
    if (Get.isRegistered<LocalLanguageService>())
      return instance._isCurrentLocaleEqualTo(locale);
    else
      return false;
  }

  Future<void> _changeLocale(Locale? locale) async {
    if (locale == null) return;
    if (_isCurrentLocaleEqualTo(locale)) return;
    await Get.updateLocale(locale);
  }

  static Future<void> changeLocale(Locale? locale) async {
    if (Get.isRegistered<LocalLanguageService>())
      await instance._changeLocale(locale);
  }

  static Locale get deviceLocal => switch (Get.deviceLocale?.languageCode) {
        'en' => englishLocale,
        'ar' => arabicLocale,
        _ => englishLocale,
      };
}
