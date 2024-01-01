import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/JobGlobalclass/jobstopimges.dart';
import 'package:sippo/JobGlobalclass/routes.dart';
import 'package:sippo/JobServices/app_local_language_services/app_local_language_service.dart';
import 'package:sippo/sippo_controller/AuthenticationController/sippo_auth_controller.dart';
import 'package:sippo/sippo_controller/AuthenticationController/sippo_signup_company_controller.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';
import 'package:sippo/utils/validating_input.dart';

class SippoCompanySignup extends StatelessWidget {
  const SippoCompanySignup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = SignUpCompanyController.instance;
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: TextButton(
          onPressed: () {
            Get.focusScope?.unfocus();
            LocalLanguageService.showChangeLanguageBottomSheet(context);
          },
          child: Text("language".tr),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width / 26,
            vertical: height / 26,
          ),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                Image.asset(
                  JobstopPngImg.welcomeImage,
                  height: height / 7,
                ),
                SizedBox(
                  height: height / 30,
                ),
                Text(
                  "Create_an_Account".tr,
                  style: dmsbold.copyWith(
                    fontSize: height / 30,
                    color: SippoColor.primarycolor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: height / 30,
                ),
                InputField(
                  onChangedText: (value) => controller.fullname = value.trim(),
                  hintText: "Full_name".tr,
                  keyboardType: TextInputType.text,
                  icon: const Icon(
                    Icons.person_outlined,
                    color: SippoColor.primarycolor,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "fullname_is_req".tr;
                    }
                    if (!ValidatingInput.validateFullName(value)) {
                      return "invalid_full_name".tr;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: height / 46,
                ),
                InputField(
                  onChangedText: (value) => controller.email = value.trim(),
                  hintText: "Email".tr,
                  keyboardType: TextInputType.text,
                  icon: const Icon(
                    Icons.email_outlined,
                    color: SippoColor.primarycolor,
                  ),
                  validator: ValidatingInput.validateEmail,
                ),
                SizedBox(
                  height: height / 46,
                ),
                InputField(
                  // controller: email,
                  onChangedText: (value) =>
                      controller.phoneNumber = value.trim(),

                  hintText: "phone_number".tr,
                  keyboardType: TextInputType.phone,
                  icon: const Icon(
                    Icons.phone_outlined,
                    color: SippoColor.primarycolor,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "phonenumber_is_req".tr;
                    }
                    if (!ValidatingInput.validatePhoneNumber(value)) {
                      return "invalid_phone_number".tr;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: height / 46,
                ),
                PasswordInputField(
                  // controller: password,
                  onChangedText: (value) => controller.password = value.trim(),
                  hintText: "Password".tr,
                  icon: const Icon(
                    Icons.lock_outline,
                    color: SippoColor.primarycolor,
                  ),
                  validator: ValidatingInput.validatePassword,
                ),
                SizedBox(
                  height: height / 46,
                ),
                PasswordInputField(
                  onChangedText: (value) =>
                      controller.confirmPassword = value.trim(),
                  hintText: "Confirm_Password".tr,
                  icon: const Icon(
                    Icons.lock_outline,
                    color: SippoColor.primarycolor,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "confpasword_is_req".tr;
                    }
                    if (value != controller.password) {
                      return "confirm_password_not_matches".tr;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: height / 46,
                ),
                CustomButton(
                  text: "Sign_up".tr,
                  backgroundColor: SippoColor.primarycolor,
                  textColor: SippoColor.white,
                  onTapped: () {
                    Get.focusScope?.unfocus();
                    controller.onSubmitSignup();
                  },
                ),
                SizedBox(
                  height: height / 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "You_have_an_account".tr,
                      style: dmsregular.copyWith(
                        fontSize: height / 62,
                        color: SippoColor.textColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.focusScope?.unfocus();
                        AuthController.instance.resetStates();
                        Get.offAndToNamed(SippoRoutes.sippoCompanyLogin);
                      },
                      child: Text(
                        "Login".tr,
                        style: dmsregular.copyWith(
                          fontSize: height / 62,
                          color: SippoColor.secondary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height / 52,
                ),
                SeparatorLine(
                  text: 'or'.tr,
                ),
                SizedBox(
                  height: height / 52,
                ),
                CustomButton(
                  onTapped: () {
                    Get.focusScope?.unfocus();
                    AuthController.instance.resetStates();
                    Get.offAndToNamed(SippoRoutes.userSignupPage);
                  },
                  text: "user_signup".tr,
                  backgroundColor: SippoColor.white,
                  textColor: SippoColor.textColor,
                  borderColor: SippoColor.grey,
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: SippoColor.white,
    );
  }
}
