import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import '../../JobGlobalclass/routes.dart';
import '../../JopController/onBoardingController/jobstop_onboarding_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class JobOnboarding extends StatefulWidget {
  const JobOnboarding({Key? key}) : super(key: key);

  @override
  State<JobOnboarding> createState() => _JobOnboardingState();
}

class _JobOnboardingState extends State<JobOnboarding>
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
      imageAssests: JobstopPngImg.onboard2,
      titleList: const [
        "Find Your",
        "Dream Job",
        "Here!",
      ],
      description: "Explore all the most exciting job roles "
          "based on your interest and study major.",
    ),
    OnBoardSlides(
      imageAssests: JobstopPngImg.onboard1,
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
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: width / 26, vertical: height / 26),
        child: Stack(
          children: [
            PageView(
              onPageChanged: (index) {
                onBoardingController
                    .setHideNextButton(index != onBoardPagesSlides.length - 1);
              },
              controller: _pageController,
              children: onBoardPagesSlides,
            ),
            Align(
              alignment: const Alignment(0, 0.85),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => onBoardingController.hideNextButton
                        ? TextButton(
                            onPressed: () {
                              _pageController
                                  .jumpToPage(onBoardPagesSlides.length - 1);
                            },
                            child: Text(
                              "Skip",
                              style: dmsmedium.copyWith(
                                color: Jobstopcolor.primarycolor,
                                fontSize: height / 36,
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ),
                  SizedBox(width: width / 25),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: onBoardPagesSlides.length,
                    effect: const ColorTransitionEffect(
                      activeDotColor: Jobstopcolor.primarycolor,
                    ),
                  ),
                  SizedBox(width: width / 25),
                  Obx(
                    () => onBoardingController.hideNextButton
                        ? TextButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn,
                              );
                            },
                            child: Text(
                              "Next",
                              style: dmsmedium.copyWith(
                                color: Jobstopcolor.primarycolor,
                                fontSize: height / 36,
                              ),
                            ),
                          )
                        : const SizedBox(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Obx(() => !onBoardingController.hideNextButton
          ? FloatingActionButton(
              heroTag: "go",
              onPressed: () {
                Get.toNamed(JopRoutesPages.appusingpage);
                return;
              },
              backgroundColor: Jobstopcolor.primarycolor,
              child: const Icon(
                Icons.arrow_right_alt_sharp,
                color: Jobstopcolor.white,
                size: 30,
              ),
            )
          : const SizedBox()),
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
    OnBoardingController onBoardingController = Get.find();
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    // double width = size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Obx(
        //   () => onBoardingController.index == 0
        //       ? SizedBox(
        //           height: height / 12,
        //         )
        //       : SizedBox(
        //           height: height / 150,
        //         ),
        // ),
        SizedBox(
          height: height / 12,
        ),
        Center(
            child: Image.asset(
          imageAssests,
          height: height / 3,
        )),
        SizedBox(
          height: height / 21,
        ),
        SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              ...titleList
                  .map((title) => Text(
                        title,
                        style: dmsbold.copyWith(
                          fontSize: height / 25,
                          color: Jobstopcolor.primarycolor,
                        ),
                        textAlign: TextAlign.center,
                      ))
                  .toList(),
              SizedBox(
                height: height / 96,
              ),
              Text(
                description,
                style: dmsregular.copyWith(
                  fontSize: height / 59,
                  color: Jobstopcolor.textColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
