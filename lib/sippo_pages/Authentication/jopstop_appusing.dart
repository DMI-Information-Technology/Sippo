import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      body: Stack(
        // Use Stack for overlapping widgets
        children: [
          // Position the image at the top with top: 0
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                JobstopPngImg.sippoLogo,
                width: width / 2.5, // Adjust width as needed
              ),
            ),
          ),
          // Position the remaining content at the bottom with bottom: 0
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width / 26,
                vertical: height / 26,
              ),
              child: Column(
                // Use mainAxisAlignment.end to align content at the bottom
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                  // Wrap the cards in a SizedBox with a defined height
                  SizedBox(
                    height: height * 0.35, // Adjust height as needed
                    child: Column(
                      children: [
                        Flexible(
                          child: Expanded(
                            child: Obx(
                              () {
                                return JopSelctedUsingAppCard(
                                  color: SippoColor.secondary,
                                  isSelected: appUsingController.findJop,
                                  image: JobstopPngImg.find_jobLog,
                                  backGroundIconColor:
                                      SippoColor.lightsecondary,
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
                        SizedBox(
                          height: height /
                              30, // Adjust spacing between cards (optional)
                        ),
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
      height: height,
      child: InkWell(
        onTap: () {
          onTapped();
        },
        child: Card(
          elevation: isSelected ? 4.0 : 3.0,
          shadowColor: isSelected ? color : Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: BorderSide(
              width: 0,
              color: isSelected ? color : Colors.transparent,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  height: height,
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
                      child: SvgPicture.asset(
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
                  width: width * 0.02,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8, top: 2),
                      child: Flexible(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
