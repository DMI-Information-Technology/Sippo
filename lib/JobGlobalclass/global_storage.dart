import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jobspot/utils/app_use.dart';

import 'jobstopprefname.dart' as global;

class GlobalStorageService extends GetxService {
  static const MAP_API_KEY = 'MAP_API_KEY';
  static const mapApiKey =
      const String.fromEnvironment(GlobalStorageService.MAP_API_KEY);

  static GlobalStorageService get instance => Get.find();
  static const first_app_lunch_time = "firstapplunchtime";

  bool _isLogged = false;
  final box = GetStorage();
  String? _tokenLogged = "";
  var _isAppLunchFirstTime = true;
  int _appUse = 0;

  static bool get isLogged => instance._isLogged;

  static String? get tokenLogged => instance._tokenLogged;

  static AppUsingType get appUse => AppUsingType.values[instance._appUse];

  static bool get isCompany =>
      AppUsingType.values[instance._appUse] == AppUsingType.company;

  static Future<void> removeSavedToken() async {
    await instance.box.remove(global.tokenKey);
    await instance.box.remove(global.loggedUserKey);
    // _userJson = {};
    instance._tokenLogged = "";
    instance._isLogged = false;
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
    await instance.box.write(global.tokenKey, token);
    await instance.box.write(global.app_logged_use, use);
    _setGlobalVariable(token, use);
  }

  // static Future<void> savedTokenPhoneNumber
  static Future<void> checkSavedToken() async {
    final String? token = await instance.box.read(global.tokenKey);
    final int? use = await instance.box.read(global.app_logged_use);
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

  static Future<bool> isAppOpenBefore() async {
    final isOpen = await instance.box.read(first_app_lunch_time) as bool?;
    return isOpen != null && isOpen;
  }

  static Future<void> appIsLunched() async {
    await instance.box.write(first_app_lunch_time, true);
  }

  static bool get isAppLunchFirstTime => instance._isAppLunchFirstTime;

  static set isAppLunchFirstTime(bool value) =>
      instance._isAppLunchFirstTime = value;
}
