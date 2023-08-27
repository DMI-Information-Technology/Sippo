import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JopController/AuthenticationController/sippo_auth_controller.dart';
import '../../JobGlobalclass/jobstopcolor.dart';
import '../../JobGlobalclass/jobstopimges.dart';
import '../../JobGlobalclass/routes.dart';
import '../../sippo_custom_widget/widgets.dart';
import '../../sippo_data/model/auth_model/user_model.dart';
import '../../utils/states.dart';

class SignUpUserController extends GetxController {
  static SignUpUserController get instance => Get.find();
  final AuthController _authController = AuthController.instance;
  final GlobalKey<FormState> formKey = GlobalKey();

  States get authState => _authController.states;
  final _fullname = "".obs;
  final _phoneNumber = "".obs;
  final _password = "".obs;
  final _confirmPassword = "".obs;

  String get fullname => _fullname.toString();

  String get confirmPassword => _confirmPassword.toString();

  String get password => _password.toString();

  String get phoneNumber => _phoneNumber.toString();

  UserModel get userForm => UserModel(
        name: fullname,
        phone: phoneNumber,
        password: password,
        passwordConfirmation: confirmPassword,
      );

  void set fullname(String value) {
    _fullname.value = value;
  }

  void set phoneNumber(String value) {
    _phoneNumber.value = value;
  }

  void set password(String value) {
    _password.value = value;
  }

  void set confirmPassword(String value) {
    _confirmPassword.value = value;
  }

  Future<void> onSubmittedSignup() async {
    if (formKey.currentState!.validate()) {
      await _authController.userRegister(userForm);
    }
    if (authState.isSuccess) {
      _authController.resetAllAuthStates();
      _showRegisterSuccessAlert();
    }
  }

  void _showRegisterSuccessAlert() {
    Get.dialog(
      CustomAlertDialog(
        imageAsset: JobstopPngImg.successful1,
        title: "success".tr,
        description: "account_created_successfully".tr,
        confirmBtnColor: Jobstopcolor.primarycolor,
        confirmBtnTitle: "ok".tr,
        onConfirm: () {
          Get.offAllNamed(SippoRoutes.userdashboard);
        },
      ),
    ).then((value) => Get.offAllNamed(SippoRoutes.userdashboard));
  }
}
