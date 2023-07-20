import 'package:flutter/material.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import '../../JobGlobalclass/jobstopcolor.dart';
import '../jopintroductionpages/jobstop_onboarding.dart';

class JobstopSplash extends StatefulWidget {
  const JobstopSplash({Key? key}) : super(key: key);

  @override
  State<JobstopSplash> createState() => _JobstopSplashState();
}

class _JobstopSplashState extends State<JobstopSplash> {
  @override
  void initState() {
    super.initState();
    // goup();
  }

  // goup() async {
  //   // await Future.delayed(const Duration(seconds: 5));
  //   // Get.off(() => );
  // }
  dynamic size;
  double height = 0.00;
  double width = 0.00;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return AnimatedSplashScreen(
      curve: Curves.easeIn,
      splashTransition: SplashTransition.sizeTransition,
      backgroundColor: Jobstopcolor.secondary,
      splash: Image.asset(
        JobstopPngImg.splashlogo,
        fit: BoxFit.fitHeight,
        height: height / 10,
      ),
      nextScreen: const JobOnboarding(),
    );
  }
}
