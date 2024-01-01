import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/JobGlobalclass/jobstopimges.dart';
import 'package:sippo/JobGlobalclass/jobstopprefname.dart';
import 'package:sippo/JobGlobalclass/media_query_sizes.dart';
import 'package:sippo/JobGlobalclass/routes.dart';
import 'package:sippo/JobGlobalclass/sippo_customstyle.dart';
import 'package:sippo/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:sippo/sippo_controller/AuthenticationController/sippo_auth_controller.dart';
import 'package:sippo/sippo_custom_widget/ConditionalWidget.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';
import 'package:sippo/sippo_themes/themecontroller.dart';
import 'package:sippo/utils/validating_input.dart';

class JobstopForget extends StatefulWidget {
  const JobstopForget({Key? key}) : super(key: key);

  @override
  State<JobstopForget> createState() => _JobstopForgetState();
}

class _JobstopForgetState extends State<JobstopForget> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  final email = TextEditingController();
  final themedata = Get.put(JobstopThemecontroler());
  String phoneNumber = Get.arguments[phoneNumberArg];
  final authController = AuthController.instance;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Forget_Password_Title".tr,
          style: dmsbold.copyWith(fontSize: height / 52),
          textAlign: TextAlign.start,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width / 26,
            vertical: height / 26,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: context.fromHeight(CustomStyle.spaceBetween),
              ),
              Image.asset(
                JobstopPngImg.passwordimg,
                height: height / 3,
              ),
              SizedBox(
                height: context.fromHeight(CustomStyle.spaceBetween),
              ),
              Text(
                'ask_enter_email_reset_password'.tr,
              ),
              Form(
                key: formKey,
                child: Column(children: [
                  InputField(
                    controller: authController.resetEmail.controller,
                    hintText: 'email_reset_password_hint_text'.tr,
                    validator: (value) {
                      return ValidatingInput.validateEmail(value);
                    },
                  ),
                  SizedBox(
                    height: context.fromHeight(CustomStyle.spaceBetween),
                  ),
                  Obx(() => ConditionalWidget(
                        authController.states.isSuccess,
                        isLoading: authController.states.isLoading,
                      )),
                  SizedBox(
                    height: context.fromHeight(CustomStyle.spaceBetween),
                  ),
                  CustomButton(
                    onTapped: () {
                      if (formKey.currentState?.validate() == true) {
                        onForgetPasswordPressed(context);
                      }
                    },
                    text: "RESET_PASSWORD".tr,
                  ),
                ]),
              ),
              SizedBox(
                height: height / 36,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onForgetPasswordPressed(BuildContext context) {
    if (InternetConnectionService.instance.isNotConnected) return;
    if (authController.resetEmail.isTextEmpty) {
      Get.dialog(
        CustomAlertDialog(
          imageAsset: JobstopPngImg.phonenymberempty,
          title: "empty_email_text_forget_password_title".tr,
          description: "empty_email_text_forget_password_message".tr,
          onConfirm: () {
            if (Get.isOverlaysOpen) {
              Navigator.pop(context);
            }
          },
        ),
      );
      return;
    }
    authController.forgetPassword().then((_) {
      if (authController.states.isSuccess) {
        authController.resetStates();
        Get.toNamed(SippoRoutes.otpresetpassmsgpage);
      }
    });
  }
}
