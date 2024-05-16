import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/JobGlobalclass/jobstopimges.dart';
import 'package:sippo/JobGlobalclass/routes.dart';
import 'package:sippo/JobGlobalclass/text_font_size.dart';
import 'package:sippo/sippo_controller/AuthenticationController/sippo_appusing_controller.dart';

class SippoAppUsing extends StatelessWidget {
  const SippoAppUsing({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final AppUsingController appUsingController = Get.put(AppUsingController());
    Size? size = Get.size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width / 26,
            vertical: height / 26,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Row(mainAxisAlignment: MainAxisAlignment.end, children: []),

              Center(
                child: AutoSizeText(
                  "Choose_App_Using_Page".tr,
                  style: dmsbold.copyWith(
                    fontSize: Get.width < 600
                        ? FontSize.title2(context)
                        : FontSize.title3(context),
                    color: SippoColor.primarycolor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: height / 32,
              ),
              AutoSizeText(
                'find_desc'.tr,
                style: dmsregular.copyWith(
                  fontSize: Get.width < 600
                      ? FontSize.paragraph(context)
                      : FontSize.paragraph3(context),
                ),
                maxLines: 4,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: height / 32,
              ),
              Stack(
                children: [
                  // Existing content of the page
                  Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.1, // Adjust dynamically
                    left: MediaQuery.of(context).size.width * 0.1, // Adjust dynamically
                    child: SizedBox(
                      child: Column(
                        children: [
                          Flexible(
                            child: Expanded(
                              child: Obx(
                                    () {
                                  return JopSelctedUsingAppCard(
                                    color: SippoColor.primarycolor,
                                    isSelected: appUsingController.findEmployee,
                                    image: JobstopPngImg.find_empLogo,
                                    backGroundIconColor: SippoColor.lightprimary,
                                    title: "find_employees_title".tr,
                                    description: 'find_employees_desc'.tr,
                                    onTapped: () {
                                      appUsingController.findOnEmployee();
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height / 30, // Adjust spacing between cards
                          ),
                          Flexible(
                            child: Expanded(
                              child: Obx(
                                    () {
                                  return JopSelctedUsingAppCard(
                                    color: SippoColor.secondary,
                                    isSelected: appUsingController.findJop,
                                    image: JobstopPngImg.find_jobLog,
                                    backGroundIconColor: SippoColor.lightsecondary,
                                    title: "find_job_title".tr,
                                    description: "find_job_desc".tr,
                                    onTapped: () {
                                      appUsingController.findOnJop();
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    )
    );
  }


  void _onConfirmButtonClicked() {
    AppUsingController controller = Get.find();
    if (!controller.findEmployee && !controller.findJop) {
      Get.snackbar("No App Use Selected", 'select_find_dialog',
          duration: Duration(seconds: 3),
          backgroundColor: SippoColor.secondary,
          colorText: Colors.white);
      return;
    }
    if (controller.findJop)
      Get.toNamed(SippoRoutes.userSignupPage);
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
    required this.image,
    this.backGroundIconColor = DefaultSelectionStyle.defaultColor,
    this.title = "",
    this.description = "",
  });

  final VoidCallback onTapped;
  final bool isSelected;
  final Color color;
  final String image;
  final Color backGroundIconColor;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    Size? size = Get.size;
    double height = size.height;
    double width = size.width;
    return SizedBox(
      height: height / 3,
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
                width: (kIsWeb ? height : width) / 7,
                height: (kIsWeb ? height : width) / 7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: backGroundIconColor,
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Flexible(
                    child: Image.asset(
                      image,
                      height: Get.width < 600 ? height : height / 2,
                      width: Get.width < 600 ? width : width / 2,
                      fit: BoxFit.contain,
                      //color: color,
                      //size: (kIsWeb ? height : width) / 8.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height / 32,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: AutoSizeText(
                  title,
                  style: dmsbold.copyWith(
                    color: SippoColor.black,
                    fontSize: FontSize.title4(context),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: height / 128,
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 25),
                  child: AutoSizeText(
                    description,
                    style: dmsregular.copyWith(
                      color: SippoColor.textColor,
                      fontSize: FontSize.paragraph3(context),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
