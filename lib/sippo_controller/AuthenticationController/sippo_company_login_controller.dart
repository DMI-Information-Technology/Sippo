import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/sippo_controller/AuthenticationController/sippo_auth_controller.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/sippo_data/model/auth_model/company_model.dart';
import 'package:jobspot/utils/states.dart';

import '../../JobGlobalclass/global_storage.dart';

class CompanyLoginController extends GetxController {
  static CompanyLoginController get instance => Get.find();
  final GlobalKey<FormState> formKey = GlobalKey();
  final netController = InternetConnectionService.instance;
  final authController = AuthController.instance;

  States get authState => authController.states;

  final _phoneNumber = "".obs;
  final _password = "".obs;
  final _isRememberMeChecked = false.obs;

  CompanyModel get companyForm => CompanyModel(
        phone: phoneNumber,
        password: password,
        fcmToken: GlobalStorageService.fcmToken,
      );

  bool get isRememberMeChecked => _isRememberMeChecked.isTrue;

  String get password => _password.toString();

  String get phoneNumber => _phoneNumber.toString();

  void set phoneNumber(String value) => _phoneNumber.value = value;

  void set password(String value) => _password.value = value;

  void set isRememberMeChecked(bool value) =>
      _isRememberMeChecked.value = value;

  Future<void> onSubmittedLogin() async {
    if (formKey.currentState!.validate()) {
      await authController.companyLogin(companyForm).then((_) {
        if (authController.states.isSuccess) {
            authController.resetStates();
            if (kIsWeb) {
              Get.offAllNamed(SippoRoutes.sippoCompanyDashboard);
            } else {
              _showSuccessAlert();
            }
          }
        },);
    }

  }

  void _showSuccessAlert() {
    Get.dialog(CustomAlertDialog(
      imageAsset: JobstopPngImg.successful1,
      isLottie: true,
      title: "Success".tr,
      description: "login_success".tr,
      confirmBtnColor: SippoColor.primarycolor,
      onConfirm: () => Get.offAllNamed(SippoRoutes.sippoCompanyDashboard),
    )).then((value) => Get.offAllNamed(SippoRoutes.sippoCompanyDashboard));
  }
}
