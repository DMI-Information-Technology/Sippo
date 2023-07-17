import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';

import '../../JobThemes/themecontroller.dart';

class JobExperiences extends StatefulWidget {
  const JobExperiences({Key? key}) : super(key: key);

  @override
  State<JobExperiences> createState() => _JobExperiencesState();
}

class _JobExperiencesState extends State<JobExperiences> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  bool check = true;
  final themedata = Get.put(JobstopThemecontroler());
  TextEditingController title = TextEditingController();
  TextEditingController company = TextEditingController();
  TextEditingController startdate = TextEditingController();
  TextEditingController enddate = TextEditingController();
  TextEditingController description = TextEditingController();
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
                Text("Change work experience",style: dmsbold.copyWith(fontSize: 16,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
                SizedBox(height: height/36,),
                Text("Job title",style: dmsbold.copyWith(fontSize: 12,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
              SizedBox(height: height/66,),
               Container(
                height: height/18,
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
                child: TextField(
                  controller:title,
                  style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),
                  cursorColor: Jobstopcolor.grey,
                  decoration: InputDecoration(
                      filled: true,
                      // hintText: "Tell me about you.",
                      // hintStyle: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none),
                      fillColor: Jobstopcolor.white),
                ),
              ),
              SizedBox(height: height/36,),
              Text("Company",style: dmsbold.copyWith(fontSize: 12,color:themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
              SizedBox(height: height/66,),
              Container(
                height: height/18,
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
                child: TextField(
                  controller:company,
                  style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),
                  cursorColor: Jobstopcolor.grey,
                  decoration: InputDecoration(
                      filled: true,
                      // hintText: "Tell me about you.",
                      // hintStyle: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none),
                      fillColor: Jobstopcolor.white),
                ),
              ),
              SizedBox(height: height/36,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Start date",style: dmsbold.copyWith(fontSize: 12,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor)),
                      Container(
                        height: height/18,
                        width: width/2.3,
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
                        child: TextField(
                          controller:startdate,
                          style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),
                          cursorColor: Jobstopcolor.grey,
                          decoration: InputDecoration(
                              filled: true,
                              // hintText: "Tell me about you.",
                              // hintStyle: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none),
                              fillColor: Jobstopcolor.white),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("End date",style: dmsbold.copyWith(fontSize: 12,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
                      SizedBox(height: height/66,),
                      Container(
                        height: height/18,
                        width: width/2.3,
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
                        child: TextField(
                          controller:enddate,
                          style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),
                          cursorColor: Jobstopcolor.grey,
                          decoration: InputDecoration(
                              filled: true,
                              // hintText: "Tell me about you.",
                              // hintStyle: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none),
                              fillColor: Jobstopcolor.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: height/36,),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        check == false ? check = true : check = false;
                      });
                    },
                    child: Container(
                      height: height/30,
                      width: height/30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Jobstopcolor.white,
                          boxShadow: const [
                            BoxShadow(
                                color: Jobstopcolor.shedo,
                                blurRadius: 5
                            )
                          ]
                      ),
                      child: Icon(Icons.check,size: 15,color: check == true ? Jobstopcolor.primarycolor : Jobstopcolor.transparent
                      ),
                    ),
                  ),
                  SizedBox(width: width/16,),
                  Text("This is my position now",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),)
                ],
              ),
              SizedBox(height: height/36,),
              Text("Description",style: dmsbold.copyWith(fontSize: 12,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
              SizedBox(height: height/66,),
              Container(
                height: height/5,
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
                child: TextField(
                  controller:description,
                  style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),
                  cursorColor: Jobstopcolor.grey,
                  maxLines: 5,
                  decoration: InputDecoration(
                      filled: true,
                      hintText: "Write additional information here",
                      hintStyle: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none),
                      fillColor: Jobstopcolor.white),
                ),
              ),
              SizedBox(height: height/16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    highlightColor: Jobstopcolor.transparent,
                    splashColor: Jobstopcolor.transparent,
                    onTap: () {
                      _showremove();
                    },
                    child: Center(
                      child: Container(
                        height: height/15,
                        width: width/2.3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Jobstopcolor.lightprimary
                        ),
                        child:
                        Center(child: Text("REMOVE".tr,style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.white),)),
                      ),
                    ),
                  ),
                  InkWell(
                    highlightColor: Jobstopcolor.transparent,
                    splashColor: Jobstopcolor.transparent,
                    onTap: () {
                      _showundo();
                    },
                    child: Center(
                      child: Container(
                        height: height/15,
                        width: width/2.3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Jobstopcolor.primarycolor
                        ),
                        child:
                        Center(child: Text("SAVE".tr,style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.white),)),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  _showundo() {
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
                Text("Undo Changes ?",style: dmsbold.copyWith(fontSize: 16,color: Jobstopcolor.primarycolor),),
                SizedBox(height: height/100,),
                Text("Are you sure you want to change what you entered?",
                  style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),textAlign: TextAlign.center,),
                SizedBox(height: height/26,),
                InkWell(
                  highlightColor: Jobstopcolor.transparent,
                  splashColor: Jobstopcolor.transparent,
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) {
                    //   return const JobAddPost();
                    // },));
                  },
                  child: Center(
                    child: Container(
                      height: height/15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Jobstopcolor.primarycolor
                      ),
                      child:
                      Center(child: Text("Continue Filling".tr,style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.white),)),
                    ),
                  ),
                ),
                SizedBox(height: height/56,),
                InkWell(
                  highlightColor: Jobstopcolor.transparent,
                  splashColor: Jobstopcolor.transparent,
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) {
                    //   return const JobstopAddjob();
                    // },));
                  },
                  child: Center(
                    child: Container(
                      height: height/15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Jobstopcolor.lightprimary
                      ),
                      child:
                      Center(child: Text("Undo Changes".tr,style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.white),)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },);
  }
  _showremove() {
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
                Text("Remove Work Experience ?",style: dmsbold.copyWith(fontSize: 16,color: Jobstopcolor.primarycolor),),
                SizedBox(height: height/100,),
                Text("Are you sure you want to change what you entered?",
                  style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),textAlign: TextAlign.center,),
                SizedBox(height: height/26,),
                InkWell(
                  highlightColor: Jobstopcolor.transparent,
                  splashColor: Jobstopcolor.transparent,
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) {
                    //   return const JobAddPost();
                    // },));
                  },
                  child: Center(
                    child: Container(
                      height: height/15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Jobstopcolor.primarycolor
                      ),
                      child:
                      Center(child: Text("Continue Filling".tr,style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.white),)),
                    ),
                  ),
                ),
                SizedBox(height: height/56,),
                InkWell(
                  highlightColor: Jobstopcolor.transparent,
                  splashColor: Jobstopcolor.transparent,
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) {
                    //   return const JobstopAddjob();
                    // },));
                  },
                  child: Center(
                    child: Container(
                      height: height/15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Jobstopcolor.lightprimary
                      ),
                      child:
                      Center(child: Text("Undo Changes".tr,style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.white),)),
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
