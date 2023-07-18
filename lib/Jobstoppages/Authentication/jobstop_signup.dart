import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import '../../JobGlobalclass/routes.dart';
import '../../JobThemes/themecontroller.dart';
import '../../JopCustomWidget/widgets.dart';
import '../../utils/helper.dart';

class JobstopSignup extends StatefulWidget {
  const JobstopSignup({Key? key}) : super(key: key);

  @override
  State<JobstopSignup> createState() => _JobstopSignupState();
}

class _JobstopSignupState extends State<JobstopSignup> {
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
                  fontSize: 30,
                  color: themedata.isdark
                      ? Jobstopcolor.white
                      : Jobstopcolor.primarycolor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: height / 30,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [],
                ),
                child: InputField(
                  controller: fullname,
                  hintText: "Full_name".tr,
                  keyboardType: TextInputType.text,
                  icon: const Icon(
                    Icons.person_outlined,
                    color: Jobstopcolor.primarycolor,
                  ),
                ),
              ),
              SizedBox(
                height: height / 46,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [],
                ),
                child: InputField(
                  controller: email,
                  hintText: "Email".tr,
                  keyboardType: TextInputType.emailAddress,
                  icon: const Icon(
                    Icons.email_outlined,
                    color: Jobstopcolor.primarycolor,
                  ),
                ),
              ),
              SizedBox(
                height: height / 46,
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
                  )),
              SizedBox(
                height: height / 46,
              ),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [],
                  ),
                  child: PasswordInputField(
                    controller: confirmPassword,
                    hintText: "Confirm_Password".tr,
                    icon: const Icon(
                      Icons.lock_outline,
                      color: Jobstopcolor.primarycolor,
                    ),
                  )),
              SizedBox(
                height: height / 46,
              ),
              CustomButtonAuth(
                  text: "Sign_up".tr,
                  backgroundColor: Jobstopcolor.primarycolor,
                  textColor: Jobstopcolor.white,
                  onTappeed: () {
                    _showAlert();
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
                        fontSize: 12, color: Jobstopcolor.darkgrey),
                  ),
                  SizedBox(
                    width: width / 46,
                  ),
                  InkWell(
                    highlightColor: Jobstopcolor.transparent,
                    splashColor: Jobstopcolor.transparent,
                    onTap: () {
                      Get.offAndToNamed(JopRoutesPages.loginpage);
                    },
                    child: Text(
                      "Sign_in".tr,
                      style: dmsregular.copyWith(
                          fontSize: 12,
                          color: Jobstopcolor.secondary,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height / 52,
              ),
              const SeparatorLine(
                text: 'or',
              ),
              SizedBox(
                height: height / 52,
              ),
              CustomButtonAuth(
                onTappeed: () {},
                text: "Company_Login".tr,
                backgroundColor: Jobstopcolor.white,
                textColor: Jobstopcolor.textColor,
                borderColor: Jobstopcolor.grey,
              ),
              SizedBox(
                height: height / 52,
              ),
              CustomButtonAuth(
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
      backgroundColor: Jobstopcolor.white,
    );
  }
}
