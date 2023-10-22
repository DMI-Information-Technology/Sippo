import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jobspot/utils/app_use.dart';

import 'jobstopprefname.dart' as global;

class GlobalStorageService extends GetxService {
  // static const MAP_API_KEY = 'MAP_API_KEY';
  // static const mapApiKey =
  //     const String.fromEnvironment(GlobalStorageService.MAP_API_KEY);

  static GlobalStorageService get instance => Get.find();
  static const first_app_lunch_time = "firstapplunchtime";

  bool _isLogged = false;
  String? _tokenLogged = "";
  var _isAppLunchFirstTime = true;
  int _appUse = 0;
  String _firebaseNotificationToken = '';

  static bool get isLogged => instance._isLogged;

  static String? get tokenLogged => instance._tokenLogged;

  static AppUsingType get appUse => AppUsingType.values[instance._appUse];

  static bool get isCompany =>
      AppUsingType.values[instance._appUse] == AppUsingType.company;

  static String get notificationToken => instance._firebaseNotificationToken;

  static set notificationToken(String value) =>
      instance._firebaseNotificationToken = value;

  static Future<void> removeSavedToken(GetStorage box) async {
    await box.remove(global.tokenKey);
    await box.remove(global.loggedUserKey);
    // _userJson = {};
    instance._tokenLogged = "";
    instance._isLogged = false;
  }

  static Future<void> saveToken(GetStorage box, String? token, int? use) async {
    await box.write(global.tokenKey, token);
    await box.write(global.app_logged_use, use);
    _setGlobalVariable(token, use);
  }

  // static Future<void> savedTokenPhoneNumber
  static Future<void> checkSavedToken(GetStorage box) async {
    final String? token = await box.read(global.tokenKey);
    final int? use = await box.read(global.app_logged_use);
    _setGlobalVariable(token, use);
    // await checkLoggedUser();
  }

  static bool _setGlobalVariable(String? token, int? use) {
    if (token == null || use == null) return false;
    if (token.isEmpty || (use < 0 && use > 1)) false;
    instance._tokenLogged = token;
    print(instance._tokenLogged);
    instance._isLogged = true;
    instance._appUse = use;
    return true;
  }

  static Future<bool> isAppOpenBefore(GetStorage box) async {
    final isOpen = await box.read(first_app_lunch_time) as bool?;
    return isOpen != null && isOpen;
  }

  static Future<void> appIsLunched(GetStorage box) async {
    await box.write(first_app_lunch_time, true);
  }

  static bool get isAppLunchFirstTime => instance._isAppLunchFirstTime;

  static set isAppLunchFirstTime(bool value) =>
      instance._isAppLunchFirstTime = value;

  static Future<void> lunchApp() async {
    final box = GetStorage();
    final check = await isAppOpenBefore(box);
    if (!check) {
      await appIsLunched(box);
    } else {
      isAppLunchFirstTime = false;
    }
    await checkSavedToken(box);
  }
}
