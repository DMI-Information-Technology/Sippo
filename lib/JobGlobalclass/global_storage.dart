import 'package:get_storage/get_storage.dart';
import 'package:jobspot/utils/app_use.dart';

import 'jobstopprefname.dart' as global;

class GlobalStorage {
  GlobalStorage._();

  static final box = GetStorage();
  static final first_app_lunch_time = "firstapplunchtime";
  static bool isLogged = false;
  static String? _tokenLogged = "";

  static String? get tokenLogged => _tokenLogged;
  static int _appUse = 0;

  static AppUsingType get appUse => AppUsingType.values[_appUse];

  static Future<void> removeSavedToken() async {
    await box.remove(global.tokenKey);
    _tokenLogged = "";
    isLogged = false;
  }

  static Future<void> savedToken(String? token, int? use) async {
    await box.write(global.tokenKey, token);
    await box.write(global.app_logged_use, use);
    if ((token != null && token.isNotEmpty) &&
        (use != null && (use >= 0 && use <= 1))) {
      _tokenLogged = token;
      isLogged = true;
      _appUse = use;
    }
  }

  // static Future<void> savedTokenPhoneNumber
  static Future<void> checkSavedToken() async {
    final String? token = await box.read(global.tokenKey);
    final int? use = await box.read(global.app_logged_use);
    if ((token != null && token.isNotEmpty) &&
        (use != null && (use >= 0 && use <= 1))) {
      _tokenLogged = token;
      isLogged = true;
      _appUse = use;
    }
  }

  static Future<bool?> isAppOpenBefore() async {
    final isOpen = await box.read(first_app_lunch_time);
    return isOpen;
  }

  static Future<void> appIsLunched() async {
    await box.write(first_app_lunch_time, true);
  }

  static var isAppLunchFirstTime = true;
}
