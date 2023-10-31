import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/jobstopprefname.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/sippo_controller/AuthenticationController/sippo_company_login_controller.dart';
import 'package:jobspot/sippo_custom_widget/ConditionalWidget.dart';
import 'package:jobspot/sippo_custom_widget/loading_view_widgets/overly_loading.dart';
import 'package:jobspot/sippo_custom_widget/success_message_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';

class SippoCompanyLogin extends StatelessWidget {
  const SippoCompanyLogin({Key? key}) : super(key: key);

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Jobstopcolor.grey;
    }
    return Jobstopcolor.lightprimary;
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
          appBar: AppBar(automaticallyImplyLeading: true),
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
                        color: Jobstopcolor.primarycolor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: height / 64,
                    ),
                    Text(
                      "lorem ipsum dolor sit amet, consectetur adipiscing elit n elementum",
                      style: dmsregular.copyWith(
                          color: Jobstopcolor.textColor, fontSize: height / 64),
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
                        color: Jobstopcolor.primarycolor,
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
                        color: Jobstopcolor.primarycolor,
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
                                checkColor: Jobstopcolor.white,
                                side: const BorderSide(
                                  color: Jobstopcolor.grey,
                                  width: 1.5,
                                ),
                                fillColor: MaterialStateProperty.resolveWith(
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
                                color: Jobstopcolor.grey,
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
                              color: Jobstopcolor.primarycolor,
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
                      backgroundColor: Jobstopcolor.primarycolor,
                      textColor: Jobstopcolor.white,
                      onTapped: () {
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
                              color: Jobstopcolor.textColor),
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
                                color: Jobstopcolor.secondary,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height / 35,
                    ),
                    const SeparatorLine(
                      text: 'or',
                    ),
                    SizedBox(
                      height: height / 35,
                    ),
                    CustomButton(
                      onTapped: () {
                        controller.authController.resetStates();
                        Get.offAndToNamed(SippoRoutes.userLoginPage);
                      },
                      text: "User_Login".tr,
                      backgroundColor: Jobstopcolor.white,
                      textColor: Jobstopcolor.textColor,
                      borderColor: Jobstopcolor.grey,
                    ),
                    SizedBox(
                      height: height / 52,
                    ),
                    CustomButton(
                      onTapped: () {},
                      text: "Guest_login.".tr,
                      backgroundColor: Jobstopcolor.white,
                      textColor: Jobstopcolor.textColor,
                      borderColor: Jobstopcolor.grey,
                    )
                  ],
                ),
              ),
            ),
          ),
          backgroundColor: Jobstopcolor.white,
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
    final controller = CompanyLoginController.instance;

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
