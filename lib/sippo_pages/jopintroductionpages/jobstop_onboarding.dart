import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/JobGlobalclass/jobstopimges.dart';
import 'package:lottie/lottie.dart';
import 'package:sippo/JobGlobalclass/routes.dart';
import 'package:sippo/JobGlobalclass/text_font_size.dart';
import 'package:sippo/sippo_controller/onBoardingController/jobstop_onboarding_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SippoOnboarding extends StatefulWidget {
  const SippoOnboarding({Key? key}) : super(key: key);

  @override
  State<SippoOnboarding> createState() => _SippoOnboardingState();
}

class _SippoOnboardingState extends State<SippoOnboarding>
    with SingleTickerProviderStateMixin {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  List<OnBoardSlides> onBoardPagesSlides = [
    OnBoardSlides(
      imageAssests: JobstopPngImg.onboarding,
      titleList: const [
        "A single place",
        "for all job",
        "opportunities",
      ],
      description: "Explore all the most exciting job roles "
          "based on your interest and study major.",
    ),
    OnBoardSlides(
      imageAssests: JobstopPngImg.onboard1,
      titleList: const [
        "Find Your",
        "Dream Job",
        "Here!",
      ],
      description: "Explore all the most exciting job roles "
          "based on your interest and study major.",
    ),
    OnBoardSlides(
      imageAssests: JobstopPngImg.onboard2,
      titleList: const [
        "Lets start now!",
      ],
      description: "Explore all the most exciting job roles "
          "based on your interest and study major.",
    ),
  ];
  final PageController _pageController = PageController();

  OnBoardingController onBoardingController = Get.put(OnBoardingController());
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:
        EdgeInsets.symmetric(horizontal: width / 26, vertical: height / 26),
        child: Stack(
          children: [
            PageView(
              onPageChanged: (index) {
                onBoardingController
                    .setHideNextButton(index != onBoardPagesSlides.length - 1);
                // New logic: Hide dots on the last page
                onBoardingController.setShowDots(index != onBoardPagesSlides.length - 1);              },
              controller: _pageController,
              children: onBoardPagesSlides,
            ),
            Obx(() => Align(
              alignment: Alignment.bottomCenter, // Top alignment for dots
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Opacity(
                    opacity: onBoardingController.showDots ? 1.0 : 0.0, // Fully visible or completely transparent
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: onBoardPagesSlides.length,
                      effect: const ExpandingDotsEffect(
                        activeDotColor: SippoColor.primarycolor,
                        dotColor: SippoColor.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            )),
            Positioned(
              bottom: 20.0, // Adjust bottom padding as needed
              left: 0.0,
              right: 0.0, // Ensures button spans the entire width
              child: Obx(() => !onBoardingController.hideNextButton
                  ? FloatingActionButton.extended(
                heroTag: "go",
                onPressed: () {
                  Get.toNamed(SippoRoutes.appUsingPage);
                  return;
                },
                backgroundColor: SippoColor.primarycolor,
                //TODO
                // fix this font size with something better
                label: Text(
                  "Continue",
                  style: TextStyle(
                    color: Colors.white, // Use theme's button color
                    fontSize: 18, // Convert to double
                  ),
                ),
              )
                  : const SizedBox()),
            ),

          ],
        ),
      ),
      // floatingActionButton: Obx(() => !onBoardingController.hideNextButton
      //     ? SizedBox( // Wrap in a SizedBox for width control
      //   width: width *0.8, // Make the button as wide as the screen
      //   child: FloatingActionButton.extended(
      //     heroTag: "go",
      //     onPressed: () {
      //       Get.toNamed(SippoRoutes.appUsingPage);
      //       return;
      //     },
      //     backgroundColor: SippoColor.primarycolor,
      //     label: Text(
      //       "Continue",
      //       style: TextStyle(color: Colors.white),
      //     ),
      //   ),
      // )
      //     : const SizedBox()),
    );
  }
}

class OnBoardSlides extends StatelessWidget {
  const OnBoardSlides(
      {super.key,
      this.imageAssests = "",
      this.titleList = const [],
      this.description = ""});

  final String imageAssests;
  final List<String> titleList;
  final String description;

  @override
  Widget build(BuildContext context) {
    // OnBoardingController onBoardingController = Get.find();
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    // double width = size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        SizedBox(
          height: height / 12,
        ),
        Center(
            child :Lottie.asset(
          imageAssests,
          height: height/3,
              fit: BoxFit.fill,
              frameRate: FrameRate.max,

            )),
        SizedBox(
          height: height / 21,
        ),
        SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              ...titleList
                  .map((title) => AutoSizeText(
                        title,
                        style: dmsbold.copyWith(
                          fontSize: FontSize.title2(context),
                          color: SippoColor.primarycolor,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ))
                  .toList(),
              SizedBox(
                height: height / 96,
              ),
              AutoSizeText(
                description,
                style: dmsregular.copyWith(
                  fontSize: FontSize.paragraph(context),
                  color: SippoColor.textColor,
                ),
                maxLines: 3,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
