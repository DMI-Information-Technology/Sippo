import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';

import '../../JobGlobalclass/jobstopprefname.dart';
import '../../JobGlobalclass/routes.dart';
import '../../JobGlobalclass/text_font_size.dart';
import '../../JopController/AuthenticationController/sippo_user_login_controller.dart';
import '../../sippo_custom_widget/loading_view_widgets/overly_loading.dart';
import '../../sippo_custom_widget/widgets.dart';

class SippoUserLogin extends StatefulWidget {
  const SippoUserLogin({Key? key}) : super(key: key);

  @override
  State<SippoUserLogin> createState() => _SippoUserLoginState();
}

class _SippoUserLoginState extends State<SippoUserLogin> {
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

  final _controller = UserLoginController.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(automaticallyImplyLeading: true),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.fromWidth(CustomStyle.paddingValue),
                vertical: context.fromHeight(CustomStyle.paddingValue),
              ),
              child: Form(
                key: _controller.formKey,
                child: Column(
                  children: [
                    Text(
                      "welcome_back_login_title".tr,
                      style: dmsbold.copyWith(
                        fontSize: FontSize.title2(context),
                        color: Jobstopcolor.primarycolor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
                    AutoSizeText(
                      "lorem ipsum dolor sit amet, consectetur adipiscing elit n elementum",
                      style: dmsregular.copyWith(
                        color: Jobstopcolor.textColor,
                        fontSize: FontSize.paragraph3(context),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: context.fromHeight(CustomStyle.xxl)),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InputField(
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
                          _controller.phoneNumber = value.trim();
                        },
                      ),
                    ),
                    SizedBox(
                      height: context.fromHeight(CustomStyle.s),
                    ),
                    PasswordInputField(
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
                        _controller.password = value.trim();
                      },
                    ),
                    SizedBox(
                      height: context.fromHeight(CustomStyle.spaceBetween),
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
                                value: _controller.isRememberMeChecked,
                                onChanged: (bool? value) {
                                  _controller.isRememberMeChecked =
                                      value ?? false;
                                },
                              ),
                            ),
                            AutoSizeText(
                              "Remember_me".tr,
                              style: dmsregular.copyWith(
                                fontSize: FontSize.label(context),
                                // fontSize: 12.sp,
                                color: Jobstopcolor.grey,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            if (_controller.phoneNumber.trim().isNotEmpty) {
                              Get.toNamed(
                                SippoRoutes.forgetpasswordpage,
                                arguments: {
                                  phoneNumberArg: _controller.phoneNumber
                                },
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
                          },
                          child: AutoSizeText(
                            "Forget_Password".tr,
                            style: dmsregular.copyWith(
                                fontSize: FontSize.label(context),
                                // fontSize: 12.sp,
                                color: Jobstopcolor.primarycolor),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: context.fromHeight(CustomStyle.spaceBetween),
                    ),
                    CustomButton(
                      text: "Login".tr,
                      backgroundColor: Jobstopcolor.primarycolor,
                      textColor: Jobstopcolor.white,
                      onTappeed: () async {
                        _controller.onSubmittedLogin();
                      },
                    ),
                    SizedBox(
                      height: context.fromHeight(CustomStyle.spaceBetween),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "You_dont_have_an_account_yet".tr,
                          style: dmsregular.copyWith(
                              fontSize: FontSize.title6(context),
                              color: Jobstopcolor.textColor),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.offAndToNamed(SippoRoutes.signuppage);
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
                      height: context.fromHeight(CustomStyle.spaceBetween),
                    ),
                    SeparatorLine(text: 'or'.tr),
                    SizedBox(
                      height: context.fromHeight(CustomStyle.spaceBetween),
                    ),
                    CustomButton(
                      onTappeed: () {
                        Get.offAndToNamed(SippoRoutes.sippoCompanyLogin);
                      },
                      text: "Company_Login".tr,
                      backgroundColor: Jobstopcolor.white,
                      textColor: Jobstopcolor.textColor,
                      borderColor: Jobstopcolor.grey,
                    ),
                    SizedBox(
                      height: height / 52,
                    ),
                    CustomButton(
                      onTappeed: () {
                        Get.offAllNamed(SippoRoutes.userdashboard);
                      },
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
          () => _controller.authState.isLoading
              ? const LoadingOverlay()
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
