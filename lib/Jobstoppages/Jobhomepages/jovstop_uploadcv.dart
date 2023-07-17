import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobThemes/themecontroller.dart';

import 'jobstop_success.dart';

class Jobuploadcv extends StatefulWidget {
  const Jobuploadcv({Key? key}) : super(key: key);

  @override
  State<Jobuploadcv> createState() => _JobuploadcvState();
}

class _JobuploadcvState extends State<Jobuploadcv> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  TextEditingController information = TextEditingController();
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
                  height: height/4.5,
                  color: themedata.isdark ? Jobstopcolor.black : Jobstopcolor.backgroud,
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: height/7,
                    width: width/1,
                    color: Jobstopcolor.greyyy,
                    child: Column(
                      children: [
                        SizedBox(height: height/22,),
                        Text("UI/UX Designer",style: dmsbold.copyWith(fontSize: 16,color: Jobstopcolor.primarycolor),),
                        SizedBox(height: height/66,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: width/20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Google",style: dmsregular.copyWith(fontSize: 16,color: Jobstopcolor.primarycolor),),
                              Image.asset(JobstopPngImg.dot,height: height/96,),
                              Text("California",style: dmsregular.copyWith(fontSize: 16,color: Jobstopcolor.primarycolor),),
                              Image.asset(JobstopPngImg.dot,height: height/96,),
                              Text("1 day ago",style: dmsregular.copyWith(fontSize: 16,color: Jobstopcolor.primarycolor),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),),
                Positioned(
                    top: 0,
                    left: 30,
                    right: 30,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Jobstopcolor.sky,
                      child: Image.asset(JobstopPngImg.google,height: height/14,),
                    )),
              ],
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: width/26,vertical: height/46),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Upload CV".tr,style: dmsbold.copyWith(fontSize: 14,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
                  SizedBox(height: height/76,),
                  Text("Add your CV/Resume to apply for a job".tr,
                    style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),overflow: TextOverflow.ellipsis,),
                  SizedBox(height: height/36,),
                  Container(
                    height: height/9,
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
                        Text("Upload CV/Resume",style: dmsregular.copyWith(fontSize: 12,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),)
                      ],
                    ),
                  ),
                  SizedBox(height: height/36,),
                  Text("Informations".tr,style: dmsbold.copyWith(fontSize: 14),),
                  SizedBox(height: height/36,),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 5,
                            color: Jobstopcolor.greyyy,
                          )
                        ]
                    ),
                    child: TextField(
                      controller:information,
                      style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),
                      cursorColor: Jobstopcolor.grey,
                      maxLines: 10,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none),
                          fillColor: Jobstopcolor.white,
                          filled: true,
                          hintText: "Explain why you are the right person for this job".tr,
                          hintStyle: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),
                      ),
                    ),
                  ),
                  SizedBox(height: height/16,),
                  InkWell(
                    highlightColor: Jobstopcolor.transparent,
                    splashColor: Jobstopcolor.transparent,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const JobSuccess();
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
                        Center(child: Text("Apply Now".tr,style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.white),)),
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
