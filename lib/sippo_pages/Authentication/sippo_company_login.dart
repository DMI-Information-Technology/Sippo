import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/JobGlobalclass/jobstopimges.dart';
import 'package:sippo/JobGlobalclass/jobstopprefname.dart';
import 'package:sippo/JobGlobalclass/routes.dart';
import 'package:sippo/JobServices/app_local_language_services/app_local_language_service.dart';
import 'package:sippo/sippo_controller/AuthenticationController/sippo_company_login_controller.dart';
import 'package:sippo/sippo_custom_widget/ConditionalWidget.dart';
import 'package:sippo/sippo_custom_widget/loading_view_widgets/overly_loading.dart';
import 'package:sippo/sippo_custom_widget/success_message_widget.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';

class SippoCompanyLogin extends StatelessWidget {
  const SippoCompanyLogin({Key? key}) : super(key: key);

  Color getColor(Set<WidgetState> states) {
    const Set<WidgetState> interactiveStates = <WidgetState>{
      WidgetState.pressed,
      WidgetState.hovered,
      WidgetState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return SippoColor.grey;
    }
    return SippoColor.lightprimary;
  }

  // void _showSuccessAlert() {
  //   Get.dialog(CustomAlertDialog(
  //     imageAsset: JobstopPngImg.successful1,
  //     title: "success".tr,
  //     description: "You Login successfully".tr,
  //     confirmBtnColor: Jobstopcolor.primarycolor,
  //     onConfirm: () => Get.offAllNamed(SippoRoutes.sippoCompanyDashboard),
  //   )).then((value) => Get.offAllNamed(SippoRoutes.sippoCompanyDashboard));
  // }

  @override
  Widget build(BuildContext context) {
    final controller = CompanyLoginController.instance;
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Stack(
      children: [
        Scaffold(
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
                    Text(
                      "welcome_back_login_title".tr,
                      style: dmsbold.copyWith(
                        fontSize: height / 30,
                        color: SippoColor.primarycolor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: height / 64,
                    ),
                    Text(
                      "welcome_back_company_message".tr,
                      style: dmsregular.copyWith(
                          color: SippoColor.textColor, fontSize: height / 64),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: height / 45,
                    ),
                    InputField(
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
                        return null;
                      },
                      onChangedText: (value) {
                        controller.phoneNumber = value.trim();
                      },
                    ),
                    SizedBox(
                      height: height / 25,
                    ),
                    PasswordInputField(
                      // controller: password,
                      hintText: "Password".tr,
                      icon: const Icon(
                        Icons.lock_outline,
                        color: SippoColor.primarycolor,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "password_is_req".tr;
                        }
                        return null;
                      },
                      onChangedText: (value) {
                        controller.password = value.trim();
                      },
                    ),
                    SizedBox(
                      height: height / 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Obx(
                              () => Checkbox(
                                checkColor: SippoColor.white,
                                side: const BorderSide(
                                  color: SippoColor.grey,
                                  width: 1.5,
                                ),
                                fillColor: WidgetStateProperty.resolveWith(
                                  getColor,
                                ),
                                value: controller.isRememberMeChecked,
                                onChanged: (bool? value) {
                                  controller.isRememberMeChecked =
                                      value ?? false;
                                },
                              ),
                            ),
                            Text(
                              "Remember_me".tr,
                              style: dmsregular.copyWith(
                                fontSize: height / 64,
                                color: SippoColor.grey,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: _onPressedForgetPassword,
                          child: Text(
                            "Forget_Password".tr,
                            style: dmsregular.copyWith(
                              fontSize: height / 75,
                              color: SippoColor.primarycolor,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height / 35,
                    ),
                    CustomButton(
                      text: "Login".tr,
                      backgroundColor: SippoColor.primarycolor,
                      textColor: SippoColor.white,
                      onTapped: () {
                        Get.focusScope?.unfocus();
                        controller.onSubmittedLogin();
                      },
                    ),
                    SizedBox(height: height / 35),
                    Obx(() => ConditionalWidget(
                          controller.authState.isError,
                          data: controller.authState,
                          guaranteedBuilder: (context, data) =>
                              CardNotifyMessage.error(
                            state: data,
                            onCancelTap: () => controller.authController
                                .changeStates(isError: false, message: ''),
                          ),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "You_dont_have_an_account_yet".tr,
                          style: dmsregular.copyWith(
                              fontSize: height / 65,
                              color: SippoColor.textColor),
                        ),
                        TextButton(
                          onPressed: () {
                            controller.authController.resetStates();
                            Get.offAndToNamed(SippoRoutes.companysignup);
                          },
                          child: Text(
                            "Sign_up".tr,
                            style: dmsregular.copyWith(
                              fontSize: height / 65,
                              color: SippoColor.secondary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height / 35),
                    SeparatorLine(text: 'or'.tr),
                    SizedBox(height: height / 35),
                    CustomButton(
                      onTapped: () {
                        controller.authController.resetStates();
                        Get.offAndToNamed(SippoRoutes.userLoginPage);
                      },
                      text: "User_Login".tr,
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
        ),
        Obx(
          () => controller.authState.isLoading
              ? const LoadingOverlay()
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  void _onPressedForgetPassword() {
    Get.focusScope?.unfocus();
    final controller = CompanyLoginController.instance;
    Get.deviceLocale;
    if (controller.phoneNumber.isNotEmpty) {
      Get.toNamed(
        SippoRoutes.forgetPassword,
        arguments: {phoneNumberArg: controller.phoneNumber},
      );
    } else {
      Get.dialog(
        CustomAlertDialog(
          imageAsset: JobstopPngImg.phonenymberempty,
          title: "No_phone_number_title".tr,
          description: "enter_phonenumber".tr,
        ),
      );
    }
  }
}
