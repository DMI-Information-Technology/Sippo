import 'package:auto_size_text/auto_size_text.dart';
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
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width / 26,
          vertical: height / 26,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
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
            SizedBox(
              child: Column(
                children: [
                  // The Row is now a Column to stack items vertically
                  Column(
                    children: [
                      Obx(
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
                      SizedBox(
                        height: 16, // Add some spacing betweenthe cards
                      ),
                      Obx(() {
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
                      }),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30,),
            ElevatedButton(
              onPressed: _onConfirmButtonClicked,
              style: ElevatedButton.styleFrom(
                backgroundColor: SippoColor.primarycolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)
                )
              ),
              child: Container(
                width: width/1.2,
                height: 50,
                child: Text(
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28
                  ),
                  "Continue"
                ),
              ),
            ),
          ],
        ),
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
      height: height / 7, // Adjust the height as needed
      width: double.infinity,
      child:InkWell(
        onTap: () {
          onTapped();
        },
        child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
        boxShadow: [
        BoxShadow(
        color: isSelected ? color.withOpacity(0.5) : Colors.grey.withOpacity(0.3), // Adjust color and opacity as needed
        spreadRadius: 1.5, // Spread of the shadow
        blurRadius: 8, // Blur of the shadow
        offset: Offset(0, 5), // Offset in the vertical direction (y-axis)
        ),
        ],
        ),
        child: Card(
        elevation: 0, // Remove default Cardelevation
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
        side: BorderSide(
        width: 0.25,
        color: isSelected ? color : Colors.grey,
        ),
        ),
          // Add Padding here
          child: Padding(
            padding: const EdgeInsets.all(12.0), // Adjust padding as needed
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
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
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height / 32,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width / 25),
                      child: AutoSizeText(
                        title,style: dmsbold.copyWith(
                        color: SippoColor.black,
                        fontSize: FontSize.title4(context),
                      ),
                        textAlign: TextAlign.start,
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
              ],
            ),
          ),
        ),
      ),
      )
    );
  }
}
