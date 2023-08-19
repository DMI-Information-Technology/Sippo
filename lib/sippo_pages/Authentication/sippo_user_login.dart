import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import '../../JobGlobalclass/jobstopprefname.dart';
import '../../JobGlobalclass/routes.dart';
import '../../JobGlobalclass/text_font_size.dart';
import '../../JobThemes/themecontroller.dart';
import '../../JopController/AuthenticationController/sippo_auth_controller.dart';
import '../../JopController/AuthenticationController/sippo_login_user_controller.dart';
import '../../JopCustomWidget/overly_loading.dart';
import '../../JopCustomWidget/widgets.dart';

class SippoUserLogin extends StatefulWidget {
  const SippoUserLogin({Key? key}) : super(key: key);

  @override
  State<SippoUserLogin> createState() => _SippoUserLoginState();
}

class _SippoUserLoginState extends State<SippoUserLogin> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;

  final themedata = Get.put(JobstopThemecontroler());
  final AuthController _authController = Get.find();

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

  final GlobalKey<FormState> _formKey = GlobalKey();
  final LoginUserController _loginUserController =
      Get.put(LoginUserController());

  // void _showAlert() {
  //   Get.dialog(CustomAlertDialog(
  //     imageAsset: JobstopPngImg.successful1,
  //     title: "Success",
  //     description: "the account has been created successfully.",
  //     confirmBtnColor: Jobstopcolor.primarycolor,
  //     confirmBtnTitle: "ok".tr,
  //     onConfirm: () {
  //       Get.toNamed(SippoRoutesPages.userdashboard);
  //     },
  //   ));
  // }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(automaticallyImplyLeading: true),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width / 26, vertical: height / 26),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      "welcome_back_login_title".tr,
                      style: dmsbold.copyWith(
                        fontSize: FontSize.titleFontSize2(context),
                        color: themedata.isdark
                            ? Jobstopcolor.white
                            : Jobstopcolor.primarycolor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: height / 64,
                    ),
                    Text(
                      "lorem ipsum dolor sit amet, consectetur adipiscing elit n elementum",
                      style: dmsregular.copyWith(
                        color: Jobstopcolor.textColor,
                        fontSize: FontSize.paragraphFontSize3(context),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: height / 45,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [],
                      ),
                      child: InputField(
                        hintText: "phone_number".tr,
                        keyboardType: TextInputType.phone,
                        icon: const Icon(
                          Icons.phone_outlined,
                          color: Jobstopcolor.primarycolor,
                        ),
                        validatorCallback: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "phonenumber_is_req".tr;
                          }
                          return null;
                        },
                        onChangedText: (value) {
                          _loginUserController.phoneNumber = value.trim();
                        },
                      ),
                    ),
                    SizedBox(
                      height: height / 25,
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
                        _loginUserController.password = value.trim();
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
                                value: _loginUserController.isRememberMeChecked,
                                onChanged: (bool? value) {
                                  _loginUserController.isRememberMeChecked =
                                      value ?? false;
                                },
                              ),
                            ),
                            Text(
                              "Remember_me".tr,
                              style: dmsregular.copyWith(
                                fontSize: FontSize.labelFontSize(context),
                                color: Jobstopcolor.grey,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            if (_loginUserController.phoneNumber
                                .trim()
                                .isNotEmpty) {
                              Get.toNamed(
                                SippoRoutesPages.forgetpasswordpage,
                                arguments: {
                                  phoneNumberArg:
                                      _loginUserController.phoneNumber
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
                          child: Text(
                            "Forget_Password".tr,
                            style: dmsregular.copyWith(
                                fontSize: FontSize.labelFontSize(context),
                                color: themedata.isdark
                                    ? Jobstopcolor.white
                                    : Jobstopcolor.primarycolor),
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
                      onTappeed: _onSubmitLogin,
                    ),
                    SizedBox(
                      height: height / 35,
                    ),
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
                            Get.offAndToNamed(SippoRoutesPages.signuppage);
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
                      onTappeed: () {
                        Get.offAndToNamed(SippoRoutesPages.sippoCompanyLogin);
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
                        Get.offAllNamed(SippoRoutesPages.userdashboard);
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
          () => _authController.states.isLoading
              ? const LoadingOverlay()
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  void _onSubmitLogin() async {
    if (_formKey.currentState!.validate()) {
      await _authController.userLogin(_loginUserController.userForm);
    }
    if (_authController.states.isSuccess) {
      _authController.successState = false;
      Get.offAllNamed(SippoRoutesPages.userdashboard);
    }
  }
}
