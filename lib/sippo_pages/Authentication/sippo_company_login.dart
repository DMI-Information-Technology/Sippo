import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JopController/AuthenticationController/sippo_auth_controller.dart';
import '../../JobGlobalclass/jobstopprefname.dart';
import '../../JobGlobalclass/routes.dart';
import '../../JobThemes/themecontroller.dart';
import '../../JopController/AuthenticationController/sippo_login_company_controller.dart';
import '../../JopController/ConnectivityController/internet_connection_controller.dart';
import '../../JopCustomWidget/overly_loading.dart';
import '../../JopCustomWidget/widgets.dart';

class SippoCompanyLogin extends StatefulWidget {
  const SippoCompanyLogin({Key? key}) : super(key: key);

  @override
  State<SippoCompanyLogin> createState() => _SippoCompanyLoginState();
}

class _SippoCompanyLoginState extends State<SippoCompanyLogin> {
  final JobstopThemecontroler themedata = Get.put(JobstopThemecontroler());

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
  final _netController = InternetConnectionController.instance;
  final _loginCompanyController = Get.put(LoginCompanyController());
  final _authController = AuthController.instance;

  void _showSuccessAlert() {
    Get.dialog(CustomAlertDialog(
      imageAsset: JobstopPngImg.successful1,
      title: "success".tr,
      description: "You Login successfully".tr,
      confirmBtnColor: Jobstopcolor.primarycolor,
      onConfirm: () => Get.offAllNamed(SippoRoutesPages.sippoCompanyDashboard),
    )).then((value) => Get.offAllNamed(SippoRoutesPages.sippoCompanyDashboard));
  }

  @override
  Widget build(BuildContext context) {
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
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      "welcome_back_login_title".tr,
                      style: dmsbold.copyWith(
                        fontSize: height / 30,
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
                      validatorCallback: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "phonenumber_is_req".tr;
                        }
                        return null;
                      },
                      onChangedText: (value) {
                        _loginCompanyController.phoneNumber = value.trim();
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
                        _loginCompanyController.password = value.trim();
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
                                value:
                                    _loginCompanyController.isRememberMeChecked,
                                onChanged: (bool? value) {
                                  _loginCompanyController.isRememberMeChecked =
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
                            Get.offAndToNamed(SippoRoutesPages.companysignup);
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
                        Get.offAndToNamed(SippoRoutesPages.loginpage);
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
                      onTappeed: () {},
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
      if (!_netController.isConnectionLostWithDialog()) {
        await _authController.companyLogin(
          _loginCompanyController.companyForm,
        );
      }
    }
    if (_authController.states.isSuccess) {
      _showSuccessAlert();
    }
  }

  void _onPressedForgetPassword() {
    if (_loginCompanyController.phoneNumber.isNotEmpty) {
      Get.toNamed(
        SippoRoutesPages.forgetpasswordpage,
        arguments: {phoneNumberArg: _loginCompanyController.phoneNumber},
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
