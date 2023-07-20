import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../JobGlobalclass/jobstopcolor.dart';
import '../../JobGlobalclass/jobstopfontstyle.dart';
import '../../JobGlobalclass/jobstopimges.dart';
import '../../JobGlobalclass/routes.dart';
import '../../JobThemes/themecontroller.dart';
import '../../JopCustomWidget/widgets.dart';

class IdentityVerification extends StatefulWidget {
  const IdentityVerification({super.key});

  @override
  State<IdentityVerification> createState() => _IdentityVerificationState();
}

class _IdentityVerificationState extends State<IdentityVerification> {
  TextEditingController secretCode = TextEditingController();
  final themedata = Get.put(JobstopThemecontroler());

  void _showSuccessAlert() {
    Get.dialog(CustomAlertDialog(
      imageAsset: JobstopPngImg.successful1,
      title: "Success",
      description:
          "the account has been created successfully want continue to dashboard",
      confirmBtnColor: Jobstopcolor.primarycolor,
      confirmBtnTitle: "ok".tr,
      onConfirm: () {
        Get.offAllNamed(JopRoutesPages.dashboard);
      },
    )).then((value) => Get.offAllNamed(JopRoutesPages.companylogin));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "identity_verification".tr,
          style: dmsbold.copyWith(fontSize: height / 52),
          textAlign: TextAlign.start,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width / 26, vertical: height / 26),
          child: Column(
            children: [
              SizedBox(
                height: height / 26,
              ),
              Image.asset(
                JobstopPngImg.passwordimg,
                height: height / 3,
              ),
              SizedBox(
                height: height / 15,
              ),
              const PhoneResetPasswordCard(
                phoneNumber: '0922698540',
                description: 'Secret code message will be sent',
                borderColor: Jobstopcolor.primarycolor,
              ),
              SizedBox(
                height: height / 18,
              ),
              InputField(
                controller: secretCode,
                hintText: "Secret_code_hint_text".tr,
                icon: const Icon(Icons.lock_outline),
              ),
              SizedBox(
                height: height / 18,
              ),
              CustomButton(
                onTappeed: () {
                  _showSuccessAlert();
                },
                text: "send".tr,
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
}
