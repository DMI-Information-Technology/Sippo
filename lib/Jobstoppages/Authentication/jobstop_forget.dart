import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/Jobstoppages/Authentication/jobstop_checkemail.dart';
import 'package:jobspot/Jobstoppages/Authentication/jobstop_login.dart';

import '../../JobThemes/themecontroller.dart';

class JobstopForget extends StatefulWidget {
  const JobstopForget({Key? key}) : super(key: key);

  @override
  State<JobstopForget> createState() => _JobstopForgetState();
}

class _JobstopForgetState extends State<JobstopForget> {
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
            Text("Forget_Password".tr,style: dmsbold.copyWith(fontSize: 30,color:themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
            SizedBox(height: height/96,),
            Text("To reset your password, you need your email or mobile\nnumber that can be authenticated",
              style: dmsregular.copyWith(fontSize: 12,color:themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),
              textAlign: TextAlign.center,),
            SizedBox(height: height/10,),
            Image.asset(JobstopPngImg.forget,height: height/8,),
            SizedBox(height: height/10,),
            Row(
              children: [
                Text("Email".tr,style: dmsbold.copyWith(fontSize: 12,color:themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
              ],
            ),
            SizedBox(height: height/46,),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 5,
                      color: Jobstopcolor.greyyy,
                    )
                  ]
              ),
              child: TextField(
                controller:email,
                style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),
                cursorColor: Jobstopcolor.grey,
                decoration: InputDecoration(
                    filled: true,
                    hintText: "Email".tr,
                    hintStyle: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none),
                    fillColor: Jobstopcolor.white),
              ),
            ),
            SizedBox(height: height/16,),
            InkWell(
              highlightColor: Jobstopcolor.transparent,
              splashColor: Jobstopcolor.transparent,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const CheckEmail();
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
                  Center(child: Text("RESENT PASSWORD".tr,style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.white),)),
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
          ],
        ),
      ),
    );
  }
}
