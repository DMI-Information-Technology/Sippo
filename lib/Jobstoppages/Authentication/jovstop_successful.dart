import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import '../../JobThemes/themecontroller.dart';
import 'jobstop_login.dart';

class JobstopSuccessful extends StatefulWidget {
  const JobstopSuccessful({Key? key}) : super(key: key);

  @override
  State<JobstopSuccessful> createState() => _JobstopSuccessfulState();
}

class _JobstopSuccessfulState extends State<JobstopSuccessful> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  final themedata = Get.put(JobstopThemecontroler());
  TextEditingController email = TextEditingController();
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
            Text("Successfully".tr,style: dmsbold.copyWith(fontSize: 30,color:themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
            SizedBox(height: height/96,),
            Text("Your password has been updated, please change your\npassword regularly to avoid this happening",
              style: dmsregular.copyWith(fontSize: 12,color:themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),
              textAlign: TextAlign.center,),
            SizedBox(height: height/10,),
            Image.asset(JobstopPngImg.successful,height: height/8,),
            SizedBox(height: height/10,),
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
                  Center(child: Text("Continue".tr,style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.white),)),
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
