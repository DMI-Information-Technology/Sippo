import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/JobGlobalclass/jobstopimges.dart';
import 'package:sippo/JobGlobalclass/routes.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';

import 'package:sippo/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:sippo/sippo_controller/AuthenticationController/sippo_auth_controller.dart';

class UpdatePasswordAfterVerification extends StatefulWidget {
  const UpdatePasswordAfterVerification({Key? key}) : super(key: key);

  @override
  State<UpdatePasswordAfterVerification> createState() =>
      _UpdatePasswordAfterVerificationState();
}

class _UpdatePasswordAfterVerificationState
    extends State<UpdatePasswordAfterVerification> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final authController = AuthController.instance;

  void _showSuccessAlert() {
    Get.dialog(
      CustomAlertDialog(
        imageAsset: JobstopPngImg.successchangepassword,
        title: "password_has_been_changed".tr,
        description: "Lorem ipsum idnnn kello dadddty lipoka bonan namll geme",
        confirmBtnTitle: "ok".tr,
        onConfirm: () {
          if (Get.isOverlaysOpen) Get.back();
          Get.until(
            (route) =>
                Get.currentRoute == SippoRoutes.userLoginPage ||
                Get.currentRoute == SippoRoutes.sippoCompanyLogin,
          );
        },
        confirmBtnColor: SippoColor.primarycolor,
      ),
    ).then((value) => Get.until(
          (route) =>
              Get.currentRoute == SippoRoutes.userLoginPage ||
              Get.currentRoute == SippoRoutes.sippoCompanyLogin,
        ));
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "new_password_title".tr,
          style: dmsbold,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width / 26,
            vertical: height / 26,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height / 16,
              ),
              Image.asset(JobstopPngImg.newpassword, height: height / 3.5),
              SizedBox(
                height: height / 30,
              ),
              PasswordInputField(
                icon: const Icon(Icons.lock_outline),
                controller: password,
                hintText: "Password".tr,
              ),
              SizedBox(
                height: height / 35,
              ),
              PasswordInputField(
                icon: const Icon(Icons.lock_outline),
                controller: confirmPassword,
                hintText: "Confirm_Password".tr,
                suffixIconColor: Colors.grey,
              ),
              SizedBox(
                height: height / 16,
              ),
              CustomButton(
                onTapped: () {
                  if (InternetConnectionService.instance.isNotConnected) return;
                  if (authController.states.isLoading) return;
                  authController.resetNewPassword({
                    'password': password.text.trim(),
                    'password_confirmation': confirmPassword.text.trim(),
                  }).then((_) {
                    if (authController.states.isSuccess) {
                      authController.resetStates();
                      _showSuccessAlert();
                    }
                  });
                  // _showSuccessAlert();
                },
                text: "confirm_password".tr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
