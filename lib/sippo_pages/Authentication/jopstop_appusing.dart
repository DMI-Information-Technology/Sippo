import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/JopController/AuthenticationController/sippo_appusing_controller.dart';

import '../../JobGlobalclass/jobstopcolor.dart';
import '../../JobGlobalclass/jobstopfontstyle.dart';
import '../../JobGlobalclass/jobstopimges.dart';
import '../../JobGlobalclass/routes.dart';
import '../../sippo_custom_widget/widgets.dart';

class SippoAppUsing extends StatelessWidget {
  const SippoAppUsing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppUsingController appUsingController = Get.put(AppUsingController());
    Size? size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width / 26,
            vertical: height / 26,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(mainAxisAlignment: MainAxisAlignment.end, children: []),

              Center(
                child: AutoSizeText(
                  "Choose_App_Using_Page".tr,
                  style: dmsbold.copyWith(
                    fontSize: FontSize.title2(context),
                    color: Jobstopcolor.primarycolor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: height / 32,
              ),
              AutoSizeText(
                'If you are a user and you want to find a job, please choose "Job Search." If you want to search for employees, please choose "Employee Search."',
                style: dmsregular.copyWith(
                  fontSize: FontSize.paragraph(context),
                ),
                maxLines: 4,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: height / 32,
              ),
              SizedBox(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () {
                              return JopSelctedUsingAppCard(
                                color: Jobstopcolor.primarycolor,
                                isSelected: appUsingController.findEmployee,
                                icon: Icons.person,
                                backGroundIconColor: Jobstopcolor.lightprimary,
                                title: "Find\nEmployee",
                                description: "I want to search for a job",
                                onTapped: () {
                                  appUsingController.findOnEmployee();
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: width / 25,
                        ),
                        Expanded(
                          child: Obx(() {
                            return JopSelctedUsingAppCard(
                              color: Jobstopcolor.secondary,
                              isSelected: appUsingController.findJop,
                              icon: Icons.business_center_outlined,
                              backGroundIconColor: Jobstopcolor.lightsecondary,
                              title: "Find Jop",
                              description: "I want to search for employees.",
                              onTapped: () {
                                appUsingController.findOnJop();
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onConfirmButtonClicked,
        backgroundColor: Jobstopcolor.primarycolor,
        child: const Icon(
          Icons.arrow_right_alt_sharp,
          color: Jobstopcolor.white,
          size: 30,
        ),
      ),
    );
  }

  void _onConfirmButtonClicked() {
    AppUsingController controller = Get.find();
    if (!controller.findEmployee && !controller.findJop) {
      Get.dialog(
        CustomAlertDialog(
          imageAsset: JobstopPngImg.appuse,
          title: "Chooce how you would to use the app",
          confirmBtnTitle: "ok".tr,
          onConfirm: () {
            Get.back();
          },
        ),
      );
      return;
    }
    if (controller.findJop)
      Get.toNamed(SippoRoutes.signuppage);
    else
      Get.toNamed(SippoRoutes.companysignup);
  }
}

class JopSelctedUsingAppCard extends StatelessWidget {
  const JopSelctedUsingAppCard({
    super.key,
    required this.color,
    required this.isSelected,
    required this.onTapped,
    this.icon = Icons.insert_emoticon,
    this.backGroundIconColor = DefaultSelectionStyle.defaultColor,
    this.title = "",
    this.description = "",
  });

  final VoidCallback onTapped;
  final bool isSelected;
  final Color color;
  final IconData icon;
  final Color backGroundIconColor;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    Size? size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return SizedBox(
      child: InkWell(
        onTap: () {
          onTapped();
        },
        child: Card(
          elevation: isSelected ? 4.0 : 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
            side: BorderSide(
              width: 2,
              color: isSelected ? color : Colors.grey,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: height / 32,
              ),
              Container(
                width: (kIsWeb ? height : width) / 5,
                height: (kIsWeb ? height : width) / 5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: backGroundIconColor,
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    icon,
                    color: color,
                    size: (kIsWeb ? height : width) / 8.0,
                  ),
                ),
              ),
              SizedBox(
                height: height / 32,
              ),
              AutoSizeText(
                title,
                style: dmsbold.copyWith(
                  color: Jobstopcolor.black,
                  fontSize: FontSize.title3(context),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: height / 128,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width / 25),
                child: AutoSizeText(
                  description,
                  style: dmsregular.copyWith(
                    color: Jobstopcolor.textColor,
                    fontSize: FontSize.paragraph2(context),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
