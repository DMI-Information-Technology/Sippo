import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';

import '../../JobGlobalclass/jobstopcolor.dart';
import 'jobstop_onboarding.dart';

class JobstopSplash extends StatefulWidget {
  const JobstopSplash({Key? key}) : super(key: key);

  @override
  State<JobstopSplash> createState() => _JobstopSplashState();
}

class _JobstopSplashState extends State<JobstopSplash> {
  @override
  void initState() {
    super.initState();
    goup();
  }

  goup() async {
    await Future.delayed(const Duration(seconds: 5));
    Get.off(() => const JobOnboarding());
  }
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return  Scaffold(
      backgroundColor: Jobstopcolor.secondary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              JobstopPngImg.splashlogo,
              fit:BoxFit.fitHeight,
              height: height/10,
            ),
          ),
          SizedBox(height: height/96,),
        ],
      ),
    );
  }
}
