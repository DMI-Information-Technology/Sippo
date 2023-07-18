import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/Jobstoppages/Jobhomepages/jobstop_home.dart';

import '../../JobThemes/themecontroller.dart';

class JobSuccess extends StatefulWidget {
  const JobSuccess({Key? key}) : super(key: key);

  @override
  State<JobSuccess> createState() => _JobSuccessState();
}

class _JobSuccessState extends State<JobSuccess> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  final themedata = Get.put(JobstopThemecontroler());

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image.asset(JobstopPngImg.dots),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: height / 4.5,
                  color: themedata.isdark
                      ? Jobstopcolor.black
                      : Jobstopcolor.backgroud,
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: height / 7,
                    width: width / 1,
                    color: Jobstopcolor.greyyy,
                    child: Column(
                      children: [
                        SizedBox(
                          height: height / 22,
                        ),
                        Text(
                          "UI/UX Designer",
                          style: dmsbold.copyWith(
                              fontSize: 16, color: Jobstopcolor.primarycolor),
                        ),
                        SizedBox(
                          height: height / 66,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: width / 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Google",
                                style: dmsregular.copyWith(
                                    fontSize: 16,
                                    color: Jobstopcolor.primarycolor),
                              ),
                              Image.asset(
                                JobstopPngImg.dot,
                                height: height / 96,
                              ),
                              Text(
                                "California",
                                style: dmsregular.copyWith(
                                    fontSize: 16,
                                    color: Jobstopcolor.primarycolor),
                              ),
                              Image.asset(
                                JobstopPngImg.dot,
                                height: height / 96,
                              ),
                              Text(
                                "1 day ago",
                                style: dmsregular.copyWith(
                                    fontSize: 16,
                                    color: Jobstopcolor.primarycolor),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: 0,
                    left: 30,
                    right: 30,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Jobstopcolor.sky,
                      child: Image.asset(
                        JobstopPngImg.google,
                        height: height / 14,
                      ),
                    )),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width / 26, vertical: height / 46),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Jobstopcolor.primary,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width / 26, vertical: height / 46),
                      child: Row(
                        children: [
                          Image.asset(
                            JobstopPngImg.pdf,
                            height: height / 16,
                          ),
                          SizedBox(
                            width: width / 36,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Jamet kudasi - CV - UI/UX Designer",
                                style: dmsregular.copyWith(
                                    fontSize: 12,
                                    color: Jobstopcolor.primarycolor),
                              ),
                              SizedBox(
                                height: height / 150,
                              ),
                              Text(
                                "867 Kb . 14 Feb 2022 at 11:30 am",
                                style: dmsregular.copyWith(
                                    fontSize: 12, color: Jobstopcolor.grey),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height / 36,
                  ),
                  Image.asset(
                    JobstopPngImg.successful1,
                    height: height / 4,
                  ),
                  SizedBox(
                    height: height / 36,
                  ),
                  Text(
                    "Successful".tr,
                    style: dmsbold.copyWith(
                        fontSize: 16, color: Jobstopcolor.darkgrey),
                  ),
                  SizedBox(
                    height: height / 46,
                  ),
                  Text(
                    "Congratulations, your application has been sent".tr,
                    style: dmsregular.copyWith(
                        fontSize: 12, color: Jobstopcolor.darkgrey),
                  ),
                  SizedBox(
                    height: height / 16,
                  ),
                  InkWell(
                    highlightColor: Jobstopcolor.transparent,
                    splashColor: Jobstopcolor.transparent,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const JobSuccess();
                        },
                      ));
                    },
                    child: Center(
                      child: Container(
                        height: height / 15,
                        width: width / 1.3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Jobstopcolor.lightprimary),
                        child: Center(
                            child: Text(
                          "Find a similar job".tr,
                          style: dmsbold.copyWith(
                              fontSize: 14, color: Jobstopcolor.primarycolor),
                        )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height / 36,
                  ),
                  InkWell(
                    highlightColor: Jobstopcolor.transparent,
                    splashColor: Jobstopcolor.transparent,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const JobstopHome();
                        },
                      ));
                    },
                    child: Center(
                      child: Container(
                        height: height / 15,
                        width: width / 1.3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Jobstopcolor.primarycolor),
                        child: Center(
                            child: Text(
                          "Back to home".tr,
                          style: dmsbold.copyWith(
                              fontSize: 14, color: Jobstopcolor.white),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
