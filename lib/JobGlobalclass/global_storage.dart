
import 'package:get_storage/get_storage.dart';
import 'package:jobspot/utils/app_use.dart';

import 'jobstopprefname.dart' as global;

class GlobalStorage {
  GlobalStorage._();

  static final box = GetStorage();
  static const first_app_lunch_time = "firstapplunchtime";
  static bool _isLogged = false;
  // static Map<String, dynamic> _userJson = {};

  // static Map<String, dynamic> get userJson => _userJson;

  static bool get isLogged => _isLogged;
  static String? _tokenLogged = "";

  static String? get tokenLogged => _tokenLogged;
  static int _appUse = 0;

  static AppUsingType get appUse => AppUsingType.values[_appUse];

  static Future<void> removeSavedToken() async {
    await box.remove(global.tokenKey);
    await box.remove(global.loggedUserKey);
    // _userJson = {};
    _tokenLogged = "";
    _isLogged = false;
  }

  // static Future<void> saveLoggedUser(Map<String, dynamic>? userJson) async {
  //   print("saveLoggedUser: the user is $userJson");
  //   if (userJson == null) {
  //     print("saveLoggedUser: the user is not saved.");
  //     return;
  //   }
  //   final encodedUser = jsonEncode(userJson);
  //   await box.write(global.loggedUserKey, encodedUser);
  //   _userJson = userJson;
  // }

  // static Future<void> checkLoggedUser() async {
  //   final String? encodedUser = await box.read(global.loggedUserKey);
  //   if (encodedUser == null) {
  //     print("saveLoggedUser: the user is not found.");
  //     return;
  //   }
  //   // _userJson = jsonDecode(encodedUser) as Map<String, dynamic>;
  // }

  static Future<void> saveToken(String? token, int? use) async {
    await box.write(global.tokenKey, token);
    await box.write(global.app_logged_use, use);
    _setGlobalVariable(token, use);
  }

  // static Future<void> savedTokenPhoneNumber
  static Future<void> checkSavedToken() async {
    final String? token = await box.read(global.tokenKey);
    final int? use = await box.read(global.app_logged_use);
    _setGlobalVariable(token, use);
      // await checkLoggedUser();

  }

  static bool _setGlobalVariable(String? token, int? use) {
    if (token == null || use == null) return false;
    if (token.isEmpty || (use < 0 && use > 1)) false;
    _tokenLogged = token;
    _isLogged = true;
    _appUse = use;
    return true;
  }

  static Future<bool> isAppOpenBefore() async {
    final isOpen = await box.read(first_app_lunch_time) as bool?;
    return isOpen != null && isOpen;
  }

  static Future<void> appIsLunched() async {
    await box.write(first_app_lunch_time, true);
  }

  static var isAppLunchFirstTime = true;
}
