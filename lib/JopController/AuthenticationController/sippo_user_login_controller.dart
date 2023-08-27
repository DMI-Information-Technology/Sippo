import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:jobspot/JopController/AuthenticationController/sippo_auth_controller.dart';

import '../../JobGlobalclass/routes.dart';
import '../../sippo_data/model/auth_model/user_model.dart';
import '../../utils/states.dart';

class UserLoginController extends GetxController {
  static UserLoginController get instance => Get.find();
  final GlobalKey<FormState> formKey = GlobalKey();
  final AuthController _authController = Get.find();
  final _phoneNumber = "".obs;
  final _password = "".obs;
  final _isRememberMeChecked = false.obs;

  States get authState => _authController.states;

  bool get isRememberMeChecked => _isRememberMeChecked.isTrue;

  String get password => _password.toString();

  String get phoneNumber => _phoneNumber.toString();

  UserModel get userForm => UserModel(phone: phoneNumber, password: password);

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
      await _authController.userLogin(userForm);
    }
    if (_authController.states.isSuccess) {
      _authController.resetAllAuthStates();
      Get.offAllNamed(SippoRoutes.userdashboard);
    }
  }
}
