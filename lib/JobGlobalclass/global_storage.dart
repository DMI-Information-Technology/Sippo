import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sippo/JobServices/app_local_language_services/app_local_language_service.dart';
import 'package:sippo/utils/app_use.dart';

import 'jobstopprefname.dart' as global;

class GlobalStorageService extends GetxService {
  static GlobalStorageService? _instance;

  static void initService(GlobalStorageService service) {
    _instance = service;
  }

  static GlobalStorageService get instance => _instance ?? Get.find();
  static const firstAppLunchTimeKey = "firstapplunchtime";
  static const savedLanguagesKey = "saved_languages";
  bool _isLogged = false;
  String? _tokenLogged = "";
  var _isAppLunchFirstTime = true;
  int _appUse = 2;
  String _fcmToken = "";
  final _savedLanguage = LocaleLanguageType.english.obs;

  static void set savedLanguage(LocaleLanguageType value) {
    instance._savedLanguage.value = value;
  }

  static LocaleLanguageType get savedLanguage {
    return instance._savedLanguage.value;
  }

  static Future<void> changeLanguage(LocaleLanguageType value) async {
    final storage = GetStorage();
    await storage.write(savedLanguagesKey, value.langCode);
    instance._savedLanguage.value = value;
  }

  static bool get isLogged => instance._isLogged;

  static String? get tokenLogged => instance._tokenLogged;

  static AppUsingType get appUse => AppUsingType.values[instance._appUse];

  static bool get isCompany {
    if (instance._appUse >= 0 && instance._appUse < AppUsingType.values.length)
      return appUse == AppUsingType.company;
    else
      return false;
  }

  static bool get isUser {
    if (instance._appUse >= 0 && instance._appUse < AppUsingType.values.length)
      return appUse == AppUsingType.user;
    else
      return false;
  }

  static bool get isGust {
    if (instance._appUse >= 0 && instance._appUse < AppUsingType.values.length)
      return appUse == AppUsingType.guest;
    else
      return false;
  }

  static String get fcmToken => instance._fcmToken;

  static set fcmToken(String value) => instance._fcmToken = value;

  static Future<void> removeSavedToken(GetStorage storage) async {
    await storage.remove(global.tokenKey);
    await storage.remove(global.loggedUserKey);
    await storage.remove(global.appUseKey);
    // _userJson = {};
    instance._tokenLogged = "";
    instance._isLogged = false;
    instance._appUse = 2;
  }

  static Future<void> saveToken(
    GetStorage storage,
    String? token,
    int? use,
  ) async {
    await storage.write(global.tokenKey, token);
    await storage.write(global.appUseKey, use);
    _setGlobalVariable(token, use);
  }

  // static Future<void> savedTokenPhoneNumber
  static Future<void> checkSavedToken(GetStorage storage) async {
    final String? token = await storage.read(global.tokenKey);
    final int? use = await storage.read(global.appUseKey);
    _setGlobalVariable(token, use);
    // await checkLoggedUser();
  }

  static void _setGlobalVariable(String? token, int? use) {
    if (token == null || use == null) return;
    if (token.isEmpty || (use < 0 && use > 1)) return;
    instance._tokenLogged = token;
    print(instance._tokenLogged);
    instance._isLogged = true;
    instance._appUse = use;
  }

  static Future<bool> isAppOpenBefore(GetStorage storage) async {
    final isOpen = await storage.read(firstAppLunchTimeKey) as bool?;
    return isOpen != null && isOpen;
  }

  static Future<void> appIsLunched(GetStorage box) async {
    await box.write(firstAppLunchTimeKey, true);
  }

  static bool get isAppLunchFirstTime => instance._isAppLunchFirstTime;

  static set isAppLunchFirstTime(bool value) =>
      instance._isAppLunchFirstTime = value;

  static Future<void> lunchApp() async {
    final storage = GetStorage();
    final langCode = await storage.read<String?>(savedLanguagesKey);
    savedLanguage = langCode != null
        ? LocaleLanguageType.fromCode(langCode)
        : LocalLanguageService.deviceLocaleType;
    final check = await isAppOpenBefore(storage);
    if (!check) {
      await appIsLunched(storage);
    } else {
      isAppLunchFirstTime = false;
    }
    await checkSavedToken(storage);
  }
}
