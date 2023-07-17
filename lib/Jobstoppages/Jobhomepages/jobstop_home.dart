import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/Jobstoppages/Jobhomepages/jobstop_description.dart';
import '../../JobThemes/themecontroller.dart';
import 'jobstop_profile.dart';
import 'jobstop_search.dart';

class JobstopHome extends StatefulWidget {
  const JobstopHome({Key? key}) : super(key: key);

  @override
  State<JobstopHome> createState() => _JobstopHomeState();
}

class _JobstopHomeState extends State<JobstopHome> {
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width/26,vertical: height/36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height/96,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Hello\nOrlando Diggs.",style: dmsbold.copyWith(fontSize: 22,color:themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return const JobstopProfile();
                        },));
                      },
                      child: CircleAvatar(
                        radius: 20,
                        child: Image.asset(JobstopPngImg.photo),
                      ),
                    )
                  ],
                ),
                SizedBox(height: height/36,),
                Stack(
                  children: [
                    Image.asset(JobstopPngImg.banner),
                    Positioned(
                      top: 50,
                        left: 20,
                        child: Text("50% off\ntake any courses",style: dmsregular.copyWith(fontSize: 18,color: Jobstopcolor.white),)),
                    Positioned(
                      bottom: 30,
                        left: 20,
                        child:Container(
                          height: height/30,
                          width: width/3.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Jobstopcolor.orenge
                          ),
                        child:  Center(child: Text("Join Now",style: dmsmedium.copyWith(fontSize: 13,color: Jobstopcolor.white))),)),
                  ],
                ),
                SizedBox(height: height/36,),
                Text("Find_Your_Job".tr,style: dmsbold.copyWith(fontSize: 16)),
                SizedBox(height: height/36,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return const JobSearch();
                        },));
                      },
                      child: Container(
                        height: height/4,
                        width: width/2.3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Jobstopcolor.lightsky
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                               Image.asset(JobstopPngImg.headhunting,height: height/20,),
                            SizedBox(height: height/96,),
                            Text("44.5k",style: dmsbold.copyWith(fontSize: 16,color: Jobstopcolor.black),),
                            Text("Remote Job",style: dmsregular.copyWith(fontSize: 14,color: Jobstopcolor.black),),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          height: height/9.5,
                          width: width/2.3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Jobstopcolor.lightprimary
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("66.8k",style: dmsbold.copyWith(fontSize: 16,color: Jobstopcolor.black),),
                              Text("Full Time",style: dmsregular.copyWith(fontSize: 14,color: Jobstopcolor.black),),
                            ],
                          ),
                        ),
                        SizedBox(height: height/36,
                        ),
                        Container(
                          height: height/9.5,
                          width: width/2.3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Jobstopcolor.lightorenge
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("38.9k",style: dmsbold.copyWith(fontSize: 16,color: Jobstopcolor.black),),
                              Text("Part Time",style: dmsregular.copyWith(fontSize: 14,color: Jobstopcolor.black),),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: height/36,),
                Text("Recent_Job_List".tr,style: dmsbold.copyWith(fontSize: 16)),
                SizedBox(height: height/36,),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return const JobDescription();
                    },));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Jobstopcolor.white,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 5,
                            color: Jobstopcolor.greyyy,
                          )
                        ]
                    ),
                    child:  Padding(
                      padding:  EdgeInsets.symmetric(horizontal: width/26,vertical: height/46),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 22,
                                backgroundColor: Jobstopcolor.lightprimary,
                                child: Image.asset(JobstopPngImg.apple,height: height/36,),
                              ),
                              SizedBox(width: width/36,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Product Designer",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.black),),
                                  Text("Google inc . California, USA",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),),
                                ],
                              ),
                              const Spacer(),
                              Image.asset(JobstopPngImg.order,height: height/36,color: Jobstopcolor.primarycolor,),
                            ],
                          ),
                          SizedBox(height: height/46,),
                          Row(
                            children: [
                              Text("\$15K",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.primarycolor),),
                              Text("/Mo",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),),
                            ],
                          ),
                          SizedBox(height: height/76,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: height/28,
                                width: width/3.5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Jobstopcolor.greyyy
                                ),
                                child:  Center(child: Text("Senior designer",style: dmsregular.copyWith(fontSize: 10,color: Jobstopcolor.darkgrey))),),
                              Container(
                                height: height/28,
                                width: width/4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Jobstopcolor.greyyy
                                ),
                                child:  Center(child: Text("Full time",style: dmsregular.copyWith(fontSize: 10,color: Jobstopcolor.darkgrey))),),
                              Container(
                                height: height/28,
                                width: width/3.8,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Jobstopcolor.lightorenge
                                ),
                                child:  Center(child: Text("Apply",style: dmsregular.copyWith(fontSize: 10,color: Jobstopcolor.darkgrey))),),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),);
  }
}
