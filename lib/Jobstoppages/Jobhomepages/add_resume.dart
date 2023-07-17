import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';

import '../../JobThemes/themecontroller.dart';

class AddResume extends StatefulWidget {
  const AddResume({Key? key}) : super(key: key);

  @override
  State<AddResume> createState() => _AddResumeState();
}

class _AddResumeState extends State<AddResume> {
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
     appBar: AppBar(),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: width/26,vertical: height/96),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Add Resume",style: dmsbold.copyWith(fontSize: 16,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
            SizedBox(height: height/36,),
            Container(
              height: height/12,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Jobstopcolor.grey)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(JobstopPngImg.upload,height: height/40,),
                  SizedBox(width: width/36,),
                  Text("Upload CV/Resume",style: dmsregular.copyWith(fontSize: 12,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
                ],
              ),
            ),
            SizedBox(height: height/46,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Jobstopcolor.primary,
                  border: Border.all(color: Jobstopcolor.grey)
              ),
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: width/26,vertical: height/46),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(JobstopPngImg.pdf,height: height/16,),
                        SizedBox(width: width/36,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Jamet kudasi - CV - UI/UX Designer",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),),
                            SizedBox(height: height/150,),
                            Text("867 Kb . 14 Feb 2022 at 11:30 am",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: height/46,),
                    Row(
                      children: [
                        Image.asset(JobstopPngImg.deleted,height: height/36,color: Jobstopcolor.red,),
                        SizedBox(width: width/36,),
                        Text("Remove file",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.red),)
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: height/46,),
            Text("Upload files in PDF format up to 5 MB. Just upload it once and you can use it in your next application.",
              style: dmsregular.copyWith(fontSize: 10,color: Jobstopcolor.grey),maxLines: 2,),
            const Spacer(),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Center(
                child: Container(
                  height: height / 18,
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
    );
  }
}
