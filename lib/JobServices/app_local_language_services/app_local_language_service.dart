import 'dart:ui';

import 'package:get/get.dart';

enum LocaleLanguageType {
  arabic('ar'),
  english('en');

  const LocaleLanguageType(this.langCode);

  Locale get languageLocale => switch (this) {
        LocaleLanguageType.arabic => arabicLocale,
        LocaleLanguageType.english => englishLocale,
      };

  final String langCode;
  static const Locale arabicLocale = const Locale('ar', 'AR');
  static const Locale englishLocale = const Locale('en', 'US');

  static Locale localeFromCode(String? langCode) {
    return switch (langCode) {
      'ar' => arabicLocale,
      'en' => englishLocale,
      _ => englishLocale,
    };
  }

  static LocaleLanguageType fromCode(String? langCode) {
    return switch (langCode) {
      'ar' => arabic,
      'en' => english,
      _ => english,
    };
  }
}

class LocalLanguageService extends GetxService {
  static LocalLanguageService get instance => Get.find();

  bool _isCurrentLocaleEqualTo(LocaleLanguageType lang) {
    return lang.langCode == Get.locale?.languageCode;
  }

  static bool isCurrentLocaleEqualTo(LocaleLanguageType lang) {
    return Get.isRegistered<LocalLanguageService>()
        ? instance._isCurrentLocaleEqualTo(lang)
        : false;
  }

  Future<void> _changeLocale(LocaleLanguageType lang) async {
    if (_isCurrentLocaleEqualTo(lang)) return;
    await Get.updateLocale(lang.languageLocale);
  }

  static Future<void> changeLocale(LocaleLanguageType lang) async {
    if (Get.isRegistered<LocalLanguageService>())
      await instance._changeLocale(lang);
  }

  static Locale get deviceLocale {
    return LocaleLanguageType.localeFromCode(Get.deviceLocale?.languageCode);
  }

  static LocaleLanguageType get deviceLocaleType {
    return LocaleLanguageType.fromCode(Get.deviceLocale?.languageCode);
  }
}
