import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/global_storage.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/JopController/AuthenticationController/sippo_auth_controller.dart';
import 'package:jobspot/sippo_data/model/auth_model/user_model.dart';
import 'package:jobspot/utils/states.dart';

class UserLoginController extends GetxController {
  static UserLoginController get instance => Get.find();
  final GlobalKey<FormState> formKey = GlobalKey();
  final AuthController authController = Get.find();
  final _phoneNumber = "".obs;
  final _password = "".obs;
  final _isRememberMeChecked = false.obs;

  States get authState => authController.states;

  bool get isRememberMeChecked => _isRememberMeChecked.isTrue;

  String get password => _password.toString();

  String get phoneNumber => _phoneNumber.toString();

  UserModel get userForm => UserModel(
        phone: phoneNumber,
        password: password,
        fcmToken: GlobalStorageService.notificationToken,
      );

  set phoneNumber(String value) {
    _phoneNumber.value = value;
  }

  set password(String value) {
    _password.value = value;
  }

  set isRememberMeChecked(bool value) {
    _isRememberMeChecked.value = value;
  }

  Future<void> onSubmittedLogin() async {
    if (formKey.currentState!.validate()) {
      await authController.userLogin(userForm);
      print(authState);
    }
    if (authController.states.isSuccess) {
      authController.resetStates();
      Get.offAllNamed(SippoRoutes.userDashboard);
    }
  }
}
