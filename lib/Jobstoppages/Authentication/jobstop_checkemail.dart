import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/Jobstoppages/Authentication/jobstop_forget.dart';

import '../../JobThemes/themecontroller.dart';
import 'jobstop_login.dart';
import 'jovstop_successful.dart';

class CheckEmail extends StatefulWidget {
  const CheckEmail({Key? key}) : super(key: key);

  @override
  State<CheckEmail> createState() => _CheckEmailState();
}

class _CheckEmailState extends State<CheckEmail> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  TextEditingController email = TextEditingController();
  final themedata = Get.put(JobstopThemecontroler());
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width/26,vertical: height/26),
        child: Column(
          children: [
            SizedBox(height: height/26,),
            Text("Check Your Email".tr,style: dmsbold.copyWith(fontSize: 30,color:themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
            SizedBox(height: height/96,),
            Text("We have sent the reset password to the email address\nbrandonelouis@gmial.com",
              style: dmsregular.copyWith(fontSize: 12,color:themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),
              textAlign: TextAlign.center,),
            SizedBox(height: height/10,),
            Image.asset(JobstopPngImg.checkmsg,height: height/6,),
            SizedBox(height: height/10,),
            InkWell(
              highlightColor: Jobstopcolor.transparent,
              splashColor: Jobstopcolor.transparent,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const JobstopSuccessful();
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
                  Center(child: Text("Open Your Email".tr,style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.white),)),
                ),
              ),
            ),
            SizedBox(height: height/36,),
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
                      color: Jobstopcolor.lightprimary
                  ),
                  child:
                  Center(child: Text("Back to Login".tr,style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.white),)),
                ),
              ),
            ),
            SizedBox(height: height/36,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "You have not received the email?".tr,
                  style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),
                ),
                SizedBox(width: width/46,),
                InkWell(
                  highlightColor: Jobstopcolor.transparent,
                  splashColor: Jobstopcolor.transparent,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return const JobstopForget();
                    },));
                  },
                  child: Text(
                    "Resend".tr,
                    style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.orenge,decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
