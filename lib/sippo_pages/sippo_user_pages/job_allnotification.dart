import 'package:flutter/material.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';

import 'sippo_user_notification_application/job_application.dart';

class AllNotification extends StatefulWidget {
  const AllNotification({Key? key}) : super(key: key);

  @override
  State<AllNotification> createState() => _AllNotificationState();
}

class _AllNotificationState extends State<AllNotification> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  int select = 0;
  int selectlist = 0;
  List<String> bottomimg = [
    JobstopPngImg.deleted,
    JobstopPngImg.offnotofication,
    JobstopPngImg.setting
  ];
  List<String> bottomname = ["Delete", "Turn off notifications", "Setting"];
  List<String> listimg = [
    JobstopPngImg.googlelogo,
    JobstopPngImg.dribbblelogo,
    JobstopPngImg.twitterlogo,
    JobstopPngImg.applelogo,
    JobstopPngImg.facebooklogo
  ];

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "Read all",
              style: dmsregular.copyWith(
                fontSize: 12,
                color: Jobstopcolor.orenge,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width / 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Notifications",
                style: dmsbold.copyWith(fontSize: 20),
              ),
              SizedBox(
                height: height / 36,
              ),
              ListView.builder(
                itemCount: listimg.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    highlightColor: Jobstopcolor.transparent,
                    splashColor: Jobstopcolor.transparent,
                    onTap: () {
                      setState(() {
                        select = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: height / 36,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: select == index
                              ? Jobstopcolor.primary
                              : Jobstopcolor.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: select == index ? 0 : 5,
                              color: Jobstopcolor.greyyy,
                            )
                          ]),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width / 26, vertical: height / 46),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  listimg[index].toString(),
                                  height: height / 18,
                                ),
                                const Spacer(),
                                InkWell(
                                    onTap: () {
                                      _showlist();
                                    },
                                    child: Image.asset(
                                      JobstopPngImg.dots,
                                      height: height / 36,
                                      color: Jobstopcolor.black,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: height / 66,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Application sent",
                                  style: dmsbold.copyWith(
                                      fontSize: 14,
                                      color: Jobstopcolor.primarycolor),
                                ),
                                SizedBox(
                                  height: height / 150,
                                ),
                                Text(
                                  "Applications for Google inc have entered for\ncompany review",
                                  style: dmsregular.copyWith(
                                      fontSize: 12,
                                      color: Jobstopcolor.darkgrey),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height / 46,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return const JobApplication();
                                      },
                                    ));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Jobstopcolor.primarycolor),
                                    child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width / 10,
                                            vertical: height / 66),
                                        child: Text("Application details",
                                            style: dmsregular.copyWith(
                                                fontSize: 12,
                                                color: Jobstopcolor.white))),
                                  ),
                                ),
                                Text("25 minutes",
                                    style: dmsregular.copyWith(
                                        fontSize: 10,
                                        color: Jobstopcolor.grey)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  _showlist() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Jobstopcolor.transparent,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
            decoration: const BoxDecoration(
              color: Jobstopcolor.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            ),
            height: height / 3.5,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width / 26, vertical: height / 66),
              child: Column(
                children: [
                  Container(
                    height: height / 500,
                    width: width / 8,
                    decoration: BoxDecoration(
                      color: Jobstopcolor.primarycolor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  SizedBox(
                    height: height / 26,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: bottomimg.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        splashColor: Jobstopcolor.transparent,
                        highlightColor: Jobstopcolor.transparent,
                        onTap: () {
                          setState(() {
                            selectlist = index;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: selectlist == index
                                  ? Jobstopcolor.primarycolor
                                  : Jobstopcolor.white),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: width / 26, vertical: height / 46),
                            child: Row(
                              children: [
                                Image.asset(
                                  bottomimg[index].toString(),
                                  height: height / 46,
                                  color: selectlist == index
                                      ? Jobstopcolor.white
                                      : Jobstopcolor.primarycolor,
                                ),
                                SizedBox(
                                  width: width / 36,
                                ),
                                Text(
                                  bottomname[index].toString(),
                                  style: dmsregular.copyWith(
                                      fontSize: 14,
                                      color: selectlist == index
                                          ? Jobstopcolor.white
                                          : Jobstopcolor.primarycolor),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
