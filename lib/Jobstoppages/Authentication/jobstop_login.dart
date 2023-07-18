import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import '../../JobGlobalclass/routes.dart';
import '../../JobThemes/themecontroller.dart';
import '../../JopCustomWidget/widgets.dart';
import '../../utils/helper.dart';
class JobstopLogin extends StatefulWidget {
  const JobstopLogin({Key? key}) : super(key: key);

  @override
  State<JobstopLogin> createState() => _JobstopLoginState();
}

class _JobstopLoginState extends State<JobstopLogin> {
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
              Text(
                "welcome_back_login_title".tr,
                style: dmsbold.copyWith(
                  fontSize: height / 25,
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
                    color: Jobstopcolor.textColor, fontSize: height / 50),
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
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: ischecked,
                        onChanged: (bool? value) {
                          setState(() => ischecked = value ?? false);
                        },
                      ),
                      Text(
                        "Remember_me".tr,
                        style: dmsregular.copyWith(
                          fontSize: 12,
                          color: Jobstopcolor.grey,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forget_Password".tr,
                      style: dmsregular.copyWith(
                          fontSize: 12,
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
              CustomButtonAuth(
                  text: "Login".tr,
                  backgroundColor: Jobstopcolor.primarycolor,
                  textColor: Jobstopcolor.white,
                  onTappeed: () {
                    _showAlert();
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
                        fontSize: 12, color: Jobstopcolor.darkgrey),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.offAndToNamed(JopRoutesPages.signuppage);
                    },
                    child: Text(
                      "Sign_up".tr,
                      style: dmsregular.copyWith(
                          fontSize: 12,
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
