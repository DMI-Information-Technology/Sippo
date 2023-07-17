import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobThemes/themecontroller.dart';
import 'package:jobspot/Jobstoppages/Authentication/jobstop_login.dart';
import 'package:jobspot/Jobstoppages/Jobhomepages/job_updatepassword.dart';
import 'package:jobspot/Jobstoppages/Jobhomepages/jobstop_dashboard.dart';

class JobstopSetting extends StatefulWidget {
  const JobstopSetting({Key? key}) : super(key: key);

  @override
  State<JobstopSetting> createState() => _JobstopSettingState();
}

class _JobstopSettingState extends State<JobstopSetting> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  bool notification = true;
  bool isDark = true;
  final themedata = Get.put(JobstopThemecontroler());
  @override
  Widget build(BuildContext context) {
  size = MediaQuery.of(context).size;
  height = size.height;
  width = size.width;
  return Scaffold(
      appBar: AppBar(),
    body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width/26,vertical: height/96),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Settings",style: dmsmedium.copyWith(fontSize: 16,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
            SizedBox(height: height/26,),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Jobstopcolor.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Jobstopcolor.shedo,
                        blurRadius: 5
                    )
                  ]
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width/26,vertical: height/66),
                child: Row(
                  children: [
                    const Icon(Icons.notifications_none,size: 22,color: Jobstopcolor.darkgrey,),
                    SizedBox(width: width/36,),
                    Text("Notifications",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),),
                    const Spacer(),
                    SizedBox(
                      height:height/36,
                      child: Switch(
                        activeColor: notification == true ? Jobstopcolor.perrot : Jobstopcolor.grey,
                        value: notification,
                        onChanged: (value) {
                          setState(() {
                            notification = value;
                          });
                          },),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: height/46,),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Jobstopcolor.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Jobstopcolor.shedo,
                        blurRadius: 5
                    )
                  ]
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width/26,vertical: height/66),
                child: Row(
                  children: [
                    Image.asset(JobstopPngImg.darkmode,height: height/46,color: Jobstopcolor.darkgrey,),
                    SizedBox(width: width/36,),
                    Text("Dark mode",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),),
                    const Spacer(),
                    SizedBox(
                      height:height/36,
                      child: Switch(
                        activeColor: themedata.isdark
                            ? Jobstopcolor.grey
                            : Jobstopcolor.black,
                        value: themedata.isdark,
                        onChanged: (state) {
                          themedata.changeThem(state);
                          isDark = state;
                          themedata.update();
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return const JobDashboard();
                          },));
                          },),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: height/46,),
            InkWell(
              highlightColor: Jobstopcolor.transparent,
              splashColor: Jobstopcolor.transparent,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const JobUpdatePassword();
                },));
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Jobstopcolor.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Jobstopcolor.shedo,
                          blurRadius: 5
                      )
                    ]
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width/26,vertical: height/66),
                  child: Row(
                    children: [
                      Image.asset(JobstopPngImg.lock,height: height/46,color: Jobstopcolor.darkgrey,),
                      SizedBox(width: width/36,),
                      Text("Password",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),),
                      const Spacer(),
                      const Icon(Icons.chevron_right,size: 25,color: Jobstopcolor.darkgrey,),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: height/46,),
            InkWell(
              highlightColor: Jobstopcolor.transparent,
              splashColor: Jobstopcolor.transparent,
              onTap: () {
                _showbottomsheet();
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Jobstopcolor.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Jobstopcolor.shedo,
                          blurRadius: 5
                      )
                    ]
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width/26,vertical: height/66),
                  child: Row(
                    children: [
                      SvgPicture.asset(JobstopSvgImg.swap,height: height/40,color: Jobstopcolor.darkgrey,),
                      SizedBox(width: width/36,),
                      Text("Change Layout",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),),
                      const Spacer(),
                      const Icon(Icons.chevron_right,size: 25,color: Jobstopcolor.darkgrey,),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: height/46,),
            InkWell(
              highlightColor: Jobstopcolor.transparent,
              splashColor: Jobstopcolor.transparent,
              onTap: () {
                _showlogout();
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Jobstopcolor.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Jobstopcolor.shedo,
                          blurRadius: 5
                      )
                    ]
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width/26,vertical: height/66),
                  child: Row(
                    children: [
                      Image.asset(JobstopPngImg.logout,height: height/46,color: Jobstopcolor.darkgrey,),
                      SizedBox(width: width/36,),
                      Text("Logout",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),),
                      const Spacer(),
                      const Icon(Icons.chevron_right,size: 25,color: Jobstopcolor.darkgrey,),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: height/3,),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Center(
                child: Container(
                  height: height / 15,
                  width: width/1.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Jobstopcolor.primarycolor
                  ),
                  child: Center(child: Text("SAVE",
                      style: dmsbold.copyWith(fontSize: 14,
                          color: Jobstopcolor.white))),),
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
  _showbottomsheet() {
    showModalBottomSheet(
        backgroundColor:
        themedata.isdark ? Jobstopcolor.black : Jobstopcolor.white,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  decoration: BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  height: height / 4,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: height / 96,
                          bottom: height / 76,
                        ),
                        child: Text('selectapplicationlayout'.tr,
                            style: dmsbold.copyWith(
                                fontSize: 18, color: Jobstopcolor.grey)),
                      ),
                      Container(
                        height: 0.8,
                        width: MediaQuery.of(context).size.width,
                        color: Jobstopcolor.grey,
                      ),
                      SizedBox(
                        height: height / 16,
                        child: InkWell(
                          highlightColor: Jobstopcolor.transparent,
                          splashColor: Jobstopcolor.transparent,
                          onTap: () async {
                            final navigator = Navigator.of(context);
                            await Get.updateLocale(const Locale('en', 'US'));
                            navigator.pop();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'ltr'.tr,
                                style: dmsregular.copyWith(
                                    fontSize: 15,
                                    color: themedata.isdark
                                        ? Jobstopcolor.white
                                        : Jobstopcolor.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 0.8,
                        width: MediaQuery.of(context).size.width,
                        color: Jobstopcolor.grey,
                      ),
                      SizedBox(
                        height: height / 16,
                        child: InkWell(
                          highlightColor: Jobstopcolor.transparent,
                          splashColor: Jobstopcolor.transparent,
                          onTap: () async {
                            final navigator = Navigator.of(context);
                            await Get.updateLocale(const Locale('ar', 'ab'));
                            navigator.pop();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'rtl'.tr,
                                style: dmsregular.copyWith(
                                    fontSize: 15,
                                    color: themedata.isdark
                                        ? Jobstopcolor.white
                                        : Jobstopcolor.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 0.8,
                        width: MediaQuery.of(context).size.width,
                        color: Jobstopcolor.grey,
                      ),
                      SizedBox(
                        height: height / 16,
                        child: InkWell(
                          highlightColor: Jobstopcolor.transparent,
                          splashColor: Jobstopcolor.transparent,
                          onTap: () async {
                            Navigator.of(context).pop();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'cancel'.tr,
                                style: dmsregular.copyWith(
                                    fontSize: 15,
                                    color: themedata.isdark
                                        ? Jobstopcolor.white
                                        : Jobstopcolor.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
        });
  }
  _showlogout() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Jobstopcolor.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Jobstopcolor.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15)),
          ),
          height: height/3,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: width/26,vertical: height/66),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: height/500,
                  width: width/8,
                  decoration: BoxDecoration(
                    color: Jobstopcolor.primarycolor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                SizedBox(height: height/26,),
                Text("Log out",style: dmsbold.copyWith(fontSize: 16,color: Jobstopcolor.primarycolor),),
                SizedBox(height: height/100,),
                Text("Are you sure you want to leave?",
                  style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),textAlign: TextAlign.center,),
                SizedBox(height: height/26,),
                InkWell(
                  highlightColor: Jobstopcolor.transparent,
                  splashColor: Jobstopcolor.transparent,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return const JobstopLogin();
                    },));
                  },
                  child: Center(
                    child: Container(
                      height: height/15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Jobstopcolor.primarycolor
                      ),
                      child:
                      Center(child: Text("Yes".tr,style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.white),)),
                    ),
                  ),
                ),
                SizedBox(height: height/56,),
                InkWell(
                  highlightColor: Jobstopcolor.transparent,
                  splashColor: Jobstopcolor.transparent,
                  onTap: () {
                   Navigator.pop(context);
                  },
                  child: Center(
                    child: Container(
                      height: height/15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Jobstopcolor.lightprimary
                      ),
                      child:
                      Center(child: Text("Cancel".tr,style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.white),)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },);
  }
}
