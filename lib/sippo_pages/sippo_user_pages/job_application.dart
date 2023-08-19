import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import '../../JobThemes/themecontroller.dart';

class JobApplication extends StatefulWidget {
  const JobApplication({Key? key}) : super(key: key);

  @override
  State<JobApplication> createState() => _JobApplicationState();
}

class _JobApplicationState extends State<JobApplication> {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width/26),
          child: Column(
            children: [
              Text("Your application",style: dmsbold.copyWith(fontSize: 20,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
              SizedBox(height: height/26,),
              Container(
                margin: EdgeInsets.only(bottom: height/36,),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Jobstopcolor.white,
                    boxShadow:  const [
                      BoxShadow(
                        blurRadius:  5,
                        color: Jobstopcolor.greyyy,
                      )
                    ]
                ),
                child:  Padding(
                  padding:  EdgeInsets.symmetric(horizontal: width/26,vertical: height/46),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(JobstopPngImg.googlelogo,height: height/18,),
                      SizedBox(height: height/36,),
                      Text("UI/UX Designer",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.primarycolor),),
                      SizedBox(height: height/150,),
                      Text("Google inc . California, USA",
                        style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),maxLines: 1,overflow: TextOverflow.ellipsis,),
                      SizedBox(height: height/100,),
                      Row(
                        children: [
                          Image.asset(JobstopPngImg.dot,height: height/150,color: Jobstopcolor.grey,),
                          SizedBox(width: width/36,),
                          Text("Shipped on February 14, 2022 at 11:30 am",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),),
                        ],
                      ),
                      SizedBox(height: height/100,),
                      Row(
                        children: [
                          Image.asset(JobstopPngImg.dot,height: height/150,color: Jobstopcolor.grey,),
                          SizedBox(width: width/36,),
                          Text("Updated by recruiter 8 hours ago",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),),
                        ],
                      ),
                      SizedBox(height: height/36,),
                      Text("Job details",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.primarycolor),),
                      SizedBox(height: height/100,),
                      Row(
                        children: [
                          Image.asset(JobstopPngImg.dot,height: height/150,color: Jobstopcolor.grey,),
                          SizedBox(width: width/36,),
                          Text("Senior designer",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),),
                        ],
                      ),
                      SizedBox(height: height/100,),
                      Row(
                        children: [
                          Image.asset(JobstopPngImg.dot,height: height/150,color: Jobstopcolor.grey,),
                          SizedBox(width: width/36,),
                          Text("Full time",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),),
                        ],
                      ),
                      SizedBox(height: height/100,),
                      Row(
                        children: [
                          Image.asset(JobstopPngImg.dot,height: height/150,color: Jobstopcolor.grey,),
                          SizedBox(width: width/36,),
                          Text("1-3 Years work experience",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),),
                        ],
                      ),
                      SizedBox(height: height/36,),
                      Text("Application details",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.primarycolor),),
                      SizedBox(height: height/100,),
                      Row(
                        children: [
                          Image.asset(JobstopPngImg.dot,height: height/150,color: Jobstopcolor.grey,),
                          SizedBox(width: width/36,),
                          Text("CV/Resume",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),),
                        ],
                      ),
                      SizedBox(height: height/100,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Jobstopcolor.primary,
                        ),
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: width/26,vertical: height/46),
                          child: Row(
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
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height/36,),
              InkWell(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return const JobApplication();
                  // },));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Jobstopcolor.primarycolor
                  ),
                  child:  Padding(
                      padding: EdgeInsets.symmetric(horizontal: width/10,vertical: height/66),
                      child: Text("Apply for more jobs",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.white))),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
