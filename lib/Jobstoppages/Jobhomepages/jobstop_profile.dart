import 'package:flutter/material.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/Jobstoppages/Jobhomepages/job_myprofile.dart';

import 'jobstop_editprofile.dart';

class JobstopProfile extends StatefulWidget {
  const JobstopProfile({Key? key}) : super(key: key);

  @override
  State<JobstopProfile> createState() => _JobstopProfileState();
}

class _JobstopProfileState extends State<JobstopProfile> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Jobstopcolor.primarycolor
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width/26,vertical: height/26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         CircleAvatar(
                           radius: 25,
                           backgroundImage: AssetImage(JobstopPngImg.photo),
                         ),
                        SizedBox(width: width/2,),
                        Image.asset(JobstopPngImg.union,height: height/36,color: Jobstopcolor.white,),
                        Image.asset(JobstopPngImg.setting,height: height/36,color: Jobstopcolor.white),
                      ],
                    ),
                    SizedBox(height: height/46,),
                    Text("Orlando Diggs",style: dmsmedium.copyWith(fontSize: 14,color: Jobstopcolor.white),),
                    SizedBox(height: height/100,),
                    Text("California, USA",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.white),),
                    SizedBox(height: height/36,),
                    Row(
                      children: [
                        Text("120k ",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.white),),
                        Text("Follower",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.white),),
                        SizedBox(width: width/10,),
                        Text("23k ",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.white),),
                        Text("Following",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.white),),
                        SizedBox(width: width/10,),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return const JobEditprofile();
                            },));
                          },
                          child: Row(
                            children: [
                              Text("Edit profile ",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.white),),
                              Image.asset(JobstopPngImg.edit, height: height/36,color: Jobstopcolor.white,),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width/26,vertical: height/46),
              child: Column(
                children: [
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
                      padding:  EdgeInsets.symmetric(horizontal: width/26,vertical: height/46),
                      child: Row(
                        children: [
                          Image.asset(JobstopPngImg.aboutme,height: height/40,),
                          SizedBox(width: width/36,),
                          Text("About me",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.primarycolor),),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return const JobMyProfile();
                              },));
                            },
                            child: const CircleAvatar(
                              radius: 10,
                              backgroundColor: Jobstopcolor.light,
                              child: Icon(Icons.add,size: 15,color: Jobstopcolor.orenge,),
                            ),
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
                      padding:  EdgeInsets.symmetric(horizontal: width/26,vertical: height/46),
                      child: Row(
                        children: [
                          Image.asset(JobstopPngImg.bag,height: height/40,),
                          SizedBox(width: width/36,),
                          Text("Work experience",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.primarycolor),),
                          const Spacer(),
                          const CircleAvatar(
                            radius: 10,
                            backgroundColor: Jobstopcolor.light,
                            child: Icon(Icons.add,size: 15,color: Jobstopcolor.orenge,),
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
                      padding:  EdgeInsets.symmetric(horizontal: width/26,vertical: height/46),
                      child: Row(
                        children: [
                          Image.asset(JobstopPngImg.education,height: height/40,),
                          SizedBox(width: width/36,),
                          Text("Education",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.primarycolor),),
                          const Spacer(),
                          const CircleAvatar(
                            radius: 10,
                            backgroundColor: Jobstopcolor.light,
                            child: Icon(Icons.add,size: 15,color: Jobstopcolor.orenge,),
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
                      padding:  EdgeInsets.symmetric(horizontal: width/26,vertical: height/46),
                      child: Row(
                        children: [
                          Image.asset(JobstopPngImg.skil,height: height/40,),
                          SizedBox(width: width/36,),
                          Text("Skill",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.primarycolor),),
                          const Spacer(),
                          const CircleAvatar(
                            radius: 10,
                            backgroundColor: Jobstopcolor.light,
                            child: Icon(Icons.add,size: 15,color: Jobstopcolor.orenge,),
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
                      padding:  EdgeInsets.symmetric(horizontal: width/26,vertical: height/46),
                      child: Row(
                        children: [
                          Image.asset(JobstopPngImg.language,height: height/40,),
                          SizedBox(width: width/36,),
                          Text("Language",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.primarycolor),),
                          const Spacer(),
                          const CircleAvatar(
                            radius: 10,
                            backgroundColor: Jobstopcolor.light,
                            child: Icon(Icons.add,size: 15,color: Jobstopcolor.orenge,),
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
                      padding:  EdgeInsets.symmetric(horizontal: width/26,vertical: height/46),
                      child: Row(
                        children: [
                          Image.asset(JobstopPngImg.appreciation,height: height/40,),
                          SizedBox(width: width/36,),
                          Text("Appreciation",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.primarycolor),),
                          const Spacer(),
                          const CircleAvatar(
                            radius: 10,
                            backgroundColor: Jobstopcolor.light,
                            child: Icon(Icons.add,size: 15,color: Jobstopcolor.orenge,),
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
                      padding:  EdgeInsets.symmetric(horizontal: width/26,vertical: height/46),
                      child: Row(
                        children: [
                          Image.asset(JobstopPngImg.resume,height: height/40,),
                          SizedBox(width: width/36,),
                          Text("Resume",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.primarycolor),),
                          const Spacer(),
                          const CircleAvatar(
                            radius: 10,
                            backgroundColor: Jobstopcolor.light,
                            child: Icon(Icons.add,size: 15,color: Jobstopcolor.orenge,),
                          )
                        ],
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
