import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import '../../JobGlobalclass/jobstopprefname.dart';
import '../../sippo_custom_widget/widgets.dart';
import '../../sippo_themes/themecontroller.dart';

class JobstopForget extends StatefulWidget {
  const JobstopForget({Key? key}) : super(key: key);

  @override
  State<JobstopForget> createState() => _JobstopForgetState();
}

class _JobstopForgetState extends State<JobstopForget> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  TextEditingController email = TextEditingController();
  final themedata = Get.put(JobstopThemecontroler());
  String phoneNumber = Get.arguments[phoneNumberArg];

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
              PhoneResetPasswordCard(
                phoneNumber: phoneNumber.toString(),
                description: 'password_reset_message_sent'.tr,
                borderColor: Jobstopcolor.primarycolor,
              ),
              SizedBox(
                height: height / 16,
              ),
              CustomButton(
                onTapped: () {
                  Get.toNamed(SippoRoutes.otpresetpassmsgpage);
                },
                text: "RESENT_PASSWORD".tr,
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
