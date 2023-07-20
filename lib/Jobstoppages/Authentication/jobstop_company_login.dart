import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import '../../JobGlobalclass/jobstopprefname.dart';
import '../../JobGlobalclass/routes.dart';
import '../../JobThemes/themecontroller.dart';
import '../../JopCustomWidget/widgets.dart';
import '../../utils/helper.dart';

class CompanyLogin extends StatefulWidget {
  const CompanyLogin({Key? key}) : super(key: key);

  @override
  State<CompanyLogin> createState() => _CompanyLoginState();
}

class _CompanyLoginState extends State<CompanyLogin> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;

  final themedata = Get.put(JobstopThemecontroler());
  bool ischecked = true;

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
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  void _showAlert() {
    showAlert(
        context,
        CustomAlertDialog(
          imageAsset: JobstopPngImg.successful1,
          title: "Success",
          description: "the account has been created successfully.",
          confirmBtnColor: Jobstopcolor.primarycolor,
          onConfirm: () {
            Get.toNamed(JopRoutesPages.dashboard);
          },
        ));
  }

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
              horizontal: width / 26, vertical: height / 26),
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
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [],
                  ),
                  child: InputField(
                    controller: phoneNumberController,
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
                  ),
                ),
                SizedBox(
                  height: height / 25,
                ),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [],
                    ),
                    child: PasswordInputField(
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
                        return null;
                      },
                    )),
                SizedBox(
                  height: height / 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          checkColor: Jobstopcolor.white,
                          side: const BorderSide(
                            color: Jobstopcolor.grey,
                            width: 1.5,
                          ),
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: ischecked,
                          onChanged: (bool? value) {
                            setState(() => ischecked = value ?? false);
                          },
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
                      onPressed: () {
                        if (phoneNumberController.text.trim().isNotEmpty) {
                          Get.toNamed(
                            JopRoutesPages.forgetpasswordpage,
                            arguments: {
                              phoneNumberArg: phoneNumberController.text
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
                            fontSize: height / 75,
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
                    onTappeed: () {
                      if (_formKey.currentState!.validate()) {
                        _showAlert();
                      }
                    }),
                SizedBox(
                  height: height / 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "You_dont_have_an_account_yet".tr,
                      style: dmsregular.copyWith(
                          fontSize: height / 65, color: Jobstopcolor.textColor),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.offAndToNamed(JopRoutesPages.companysignup);
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
                    Get.offAndToNamed(JopRoutesPages.loginpage);
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
    );
  }
}
