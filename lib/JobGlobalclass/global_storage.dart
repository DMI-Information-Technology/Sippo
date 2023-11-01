import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jobspot/utils/app_use.dart';

import 'jobstopprefname.dart' as global;

class GlobalStorageService extends GetxService {
  // static const MAP_API_KEY = 'MAP_API_KEY';
  // static const mapApiKey =
  //     const String.fromEnvironment(GlobalStorageService.MAP_API_KEY);
  static GlobalStorageService? _instance;

  static void initService(GlobalStorageService service) {
    _instance = service;
  }

  static GlobalStorageService get instance => Get.find();
  static const firstAppLunchTimeKey = "firstapplunchtime";

  bool _isLogged = false;
  String? _tokenLogged = "";
  var _isAppLunchFirstTime = true;
  int _appUse = 0;
  String _fcmToken = "";

  static bool get isLogged => (_instance ?? instance)._isLogged;

  static String? get tokenLogged => (_instance ?? instance)._tokenLogged;

  static AppUsingType get appUse =>
      AppUsingType.values[(_instance ?? instance)._appUse];

  static bool get isCompany {
    if ((_instance ?? instance)._appUse >= 0 &&
        (_instance ?? instance)._appUse < AppUsingType.values.length)
      return appUse == AppUsingType.company;
    else
      return false;
  }

  static bool get isUser {
    if ((_instance ?? instance)._appUse >= 0 &&
        (_instance ?? instance)._appUse < AppUsingType.values.length)
      return appUse == AppUsingType.user;
    else
      return false;
  }

  static String get fcmToken => (_instance ?? instance)._fcmToken;

  static set fcmToken(String value) =>
      (_instance ?? instance)._fcmToken = value;

  static Future<void> removeSavedToken(GetStorage storage) async {
    await storage.remove(global.tokenKey);
    await storage.remove(global.loggedUserKey);
    // _userJson = {};
    (_instance ?? instance)._tokenLogged = "";
    (_instance ?? instance)._isLogged = false;
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
    (_instance ?? instance)._tokenLogged = token;
    print((_instance ?? instance)._tokenLogged);
    (_instance ?? instance)._isLogged = true;
    (_instance ?? instance)._appUse = use;
  }

  static Future<bool> isAppOpenBefore(GetStorage storage) async {
    final isOpen = await storage.read(firstAppLunchTimeKey) as bool?;
    return isOpen != null && isOpen;
  }

  static Future<void> appIsLunched(GetStorage box) async {
    await box.write(firstAppLunchTimeKey, true);
  }

  static bool get isAppLunchFirstTime =>
      (_instance ?? instance)._isAppLunchFirstTime;

  static set isAppLunchFirstTime(bool value) =>
      (_instance ?? instance)._isAppLunchFirstTime = value;

  static Future<void> lunchApp() async {
    final storage = GetStorage();
    final check = await isAppOpenBefore(storage);
    if (!check) {
      await appIsLunched(storage);
    } else {
      isAppLunchFirstTime = false;
    }
    await checkSavedToken(storage);
  }
}
