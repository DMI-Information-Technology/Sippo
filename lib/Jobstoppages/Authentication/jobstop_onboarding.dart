import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import '../../JobGlobalclass/routes.dart';

class JobOnboarding extends StatefulWidget {
  const JobOnboarding({Key? key}) : super(key: key);

  @override
  State<JobOnboarding> createState() => _JobOnboardingState();
}

class _JobOnboardingState extends State<JobOnboarding> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width / 26, vertical: height / 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(mainAxisAlignment: MainAxisAlignment.end, children: []),
              SizedBox(
                height: height / 10,
              ),
              Center(
                  child: Image.asset(
                JobstopPngImg.onboarding,
                height: height / 3,
              )),
              SizedBox(
                height: height / 12,
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Text(
                      "Find Your",
                      style: dmsbold.copyWith(
                        fontSize: 35,
                        color: Jobstopcolor.primarycolor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Dream Job",
                      style: dmsbold.copyWith(
                        fontSize: 35,
                        color: Jobstopcolor.primarycolor,
                        decoration: TextDecoration.underline,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Here!",
                      style: dmsbold.copyWith(
                        fontSize: 35,
                        color: Jobstopcolor.primarycolor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: height / 96,
                    ),
                    Text(
                      "Explore all the most exciting job roles based on your interest and study major.",
                      style: dmsregular.copyWith(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(JopRoutesPages.appusingpage);
        },
        backgroundColor: Jobstopcolor.primarycolor,
        child: const Icon(
          Icons.arrow_right_alt_sharp,
          color: Jobstopcolor.white,
          size: 30,
        ),
      ),
    );
  }
}
