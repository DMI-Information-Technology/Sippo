import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import '../../JobGlobalclass/routes.dart';
import '../../JobThemes/themecontroller.dart';
import '../../JopController/AuthenticationController/sippo_auth_controller.dart';
import '../../JopController/AuthenticationController/sippo_signup_user_controller.dart';
import '../../JopCustomWidget/overly_loading.dart';
import '../../JopCustomWidget/widgets.dart';
import '../../utils/validating_input.dart';


class SippoUserSignup extends StatefulWidget {
  const SippoUserSignup({Key? key}) : super(key: key);

  @override
  State<SippoUserSignup> createState() => _SippoUserSignupState();
}

class _SippoUserSignupState extends State<SippoUserSignup> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;

  final themedata = Get.put(JobstopThemecontroler());
  final AuthController _authController = Get.find();
  final signUpUserController = Get.put(SignUpUserController());

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
                    Image.asset(
                      JobstopPngImg.signup,
                      height: height / 7,
                    ),
                    SizedBox(
                      height: height / 30,
                    ),
                    Text(
                      "Create_an_Account".tr,
                      style: dmsbold.copyWith(
                        fontSize: height / 30,
                        color: themedata.isdark
                            ? Jobstopcolor.white
                            : Jobstopcolor.primarycolor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: height / 30,
                    ),
                    InputField(
                      // controller: fullname,
                      hintText: "Full_name".tr,
                      keyboardType: TextInputType.text,
                      icon: const Icon(
                        Icons.person_outlined,
                        color: Jobstopcolor.primarycolor,
                      ),
                      validatorCallback: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "fullname_is_req".tr;
                        }
                        if (!ValidatingInput.validateFullName(value)) {
                          return "invalid full name";
                        }
                        return null;
                      },
                      onChangedText: (val) =>
                          signUpUserController.fullname = val.trim(),
                    ),
                    SizedBox(
                      height: height / 46,
                    ),
                    InputField(
                      // controller: phoneNum,
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
                        if (!ValidatingInput.validatePhoneNumber(value)) {
                          return "invalid phone number";
                        }
                        return null;
                      },
                      onChangedText: (val) =>
                          signUpUserController.phoneNumber = val.trim(),
                    ),
                    SizedBox(
                      height: height / 46,
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
                          String accepted =
                              ValidatingInput.validatePassword(value.trim());
                          if (accepted.isNotEmpty) {
                            return accepted;
                          }
                          return null;
                        },
                        onChangedText: (val) =>
                            signUpUserController.password = val.trim()),
                    SizedBox(
                      height: height / 46,
                    ),
                    PasswordInputField(
                      // controller: confirmPassword,
                      hintText: "Confirm_Password".tr,
                      icon: const Icon(
                        Icons.lock_outline,
                        color: Jobstopcolor.primarycolor,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "confpasword_is_req".tr;
                        }
                        if (value != signUpUserController.password) {
                          return "the confirm password is not matches the password";
                        }
                        return null;
                      },
                      onChangedText: (val) =>
                          signUpUserController.confirmPassword = val.trim(),
                    ),
                    SizedBox(
                      height: height / 46,
                    ),
                    CustomButton(
                      text: "Sign_up".tr,
                      backgroundColor: Jobstopcolor.primarycolor,
                      textColor: Jobstopcolor.white,
                      onTappeed: _onSubmitForm,
                    ),
                    SizedBox(height: height / 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "You_have_an_account".tr,
                          style: dmsregular.copyWith(
                            fontSize: height / 62,
                            color: Jobstopcolor.textColor,
                          ),
                        ),
                        SizedBox(width: width / 46),
                        InkWell(
                          highlightColor: Jobstopcolor.transparent,
                          splashColor: Jobstopcolor.transparent,
                          onTap: () {
                            Get.offAndToNamed(
                              SippoRoutesPages.loginpage,
                            );
                          },
                          child: Text(
                            "Sign_in".tr,
                            style: dmsregular.copyWith(
                              fontSize: height / 62,
                              color: Jobstopcolor.secondary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height / 52),
                    const SeparatorLine(
                      text: 'or',
                    ),
                    SizedBox(height: height / 52),
                    CustomButton(
                      onTappeed: () {
                        Get.offAndToNamed(SippoRoutesPages.companysignup);
                      },
                      text: "company_signup".tr,
                      backgroundColor: Jobstopcolor.white,
                      textColor: Jobstopcolor.textColor,
                      borderColor: Jobstopcolor.grey,
                    ),
                    SizedBox(height: height / 52),
                    CustomButton(
                      onTappeed: () {},
                      text: "Guest_login.".tr,
                      backgroundColor: Jobstopcolor.white,
                      textColor: Jobstopcolor.textColor,
                      borderColor: Jobstopcolor.grey,
                    ),
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

  void _onSubmitForm() async {
    if (_formKey.currentState!.validate()) {
        await _authController.userRegister(signUpUserController.userForm);
    }
    if (_authController.states.isSuccess) {
      _authController.successState = false;
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
          Get.offAllNamed(SippoRoutesPages.userdashboard);
        },
      ),
    ).then((value) => Get.offAllNamed(SippoRoutesPages.userdashboard));
  }
}


