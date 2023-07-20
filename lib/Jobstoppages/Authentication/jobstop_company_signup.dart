import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import '../../JobGlobalclass/routes.dart';
import '../../JobThemes/themecontroller.dart';
import '../../JopCustomWidget/widgets.dart';
import '../../utils/validating_input.dart';

class JobstopCompanySignup extends StatefulWidget {
  const JobstopCompanySignup({Key? key}) : super(key: key);

  @override
  State<JobstopCompanySignup> createState() => _JobstopCompanySignupState();
}

class _JobstopCompanySignupState extends State<JobstopCompanySignup> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;

  final themedata = Get.put(JobstopThemecontroler());

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

  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
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
                Image.asset(
                  JobstopPngImg.companysignup,
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
                  controller: fullname,
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
                ),
                SizedBox(
                  height: height / 46,
                ),
                InputField(
                  controller: email,
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
                ),
                SizedBox(
                  height: height / 46,
                ),
                PasswordInputField(
                  controller: password,
                  hintText: "Password".tr,
                  icon: const Icon(
                    Icons.lock_outline,
                    color: Jobstopcolor.primarycolor,
                  ),
                  validatorCallback: (value) {
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
                ),
                SizedBox(
                  height: height / 46,
                ),
                PasswordInputField(
                  controller: confirmPassword,
                  hintText: "Confirm_Password".tr,
                  icon: const Icon(
                    Icons.lock_outline,
                    color: Jobstopcolor.primarycolor,
                  ),
                  validatorCallback: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "confpasword_is_req".tr;
                    }
                    if (value != password.value.text) {
                      return "the confirm password is not matches the password";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: height / 46,
                ),
                CustomButton(
                    text: "Sign_up".tr,
                    backgroundColor: Jobstopcolor.primarycolor,
                    textColor: Jobstopcolor.white,
                    onTappeed: () {
                      Get.toNamed(JopRoutesPages.ompanysignupspecializations);
                      if (_formKey.currentState!.validate()) {
                        // _showSuccessAlert();
                      }
                    }),
                SizedBox(
                  height: height / 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "You_have_an_account".tr,
                      style: dmsregular.copyWith(
                          fontSize: height / 62, color: Jobstopcolor.textColor),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.offAndToNamed(JopRoutesPages.companylogin);
                      },
                      child: Text(
                        "Login".tr,
                        style: dmsregular.copyWith(
                          fontSize: height / 62,
                          color: Jobstopcolor.secondary,
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
                  onTappeed: () {
                    Get.offAndToNamed(JopRoutesPages.signuppage);
                  },
                  text: "user_signup".tr,
                  backgroundColor: Jobstopcolor.white,
                  textColor: Jobstopcolor.textColor,
                  borderColor: Jobstopcolor.grey,
                ),
                SizedBox(
                  height: height / 52,
                ),
                CustomButton(
                  onTappeed: () {
                    Get.offAllNamed(JopRoutesPages.dashboard);
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
    );
  }
}
