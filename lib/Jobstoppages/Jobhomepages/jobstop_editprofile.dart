import 'package:flutter/material.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/Jobstoppages/Jobhomepages/add_resume.dart';
import 'package:jobspot/Jobstoppages/Jobhomepages/change_eduction.dart';
import 'package:jobspot/Jobstoppages/Jobhomepages/job_aboutme.dart';
import 'package:jobspot/Jobstoppages/Jobpostpages/jobstop_position.dart';

import 'job_experience.dart';
import 'job_language.dart';

class JobEditprofile extends StatefulWidget {
  const JobEditprofile({Key? key}) : super(key: key);

  @override
  State<JobEditprofile> createState() => _JobEditprofileState();
}

class _JobEditprofileState extends State<JobEditprofile> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  List<String> skill = ["Leadership","Teamwork","Visioner","Target oriented","Consistent"];
  List<String> language = ["English","German","Spanish","Mandarin","Italy"];
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
                        Text("Edit profile ",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.white),),
                        Image.asset(JobstopPngImg.edit, height: height/36,color: Jobstopcolor.white,),
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
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(JobstopPngImg.aboutme,height: height/40,),
                              SizedBox(width: width/36,),
                              Text("About me",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.primarycolor),),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return const JobAboutme();
                                  },));
                                },
                                  child: Image.asset(JobstopPngImg.edit,height: height/36,color: Jobstopcolor.orenge,))
                            ],
                          ),
                          SizedBox(height: height/100,),
                          const Divider(color: Jobstopcolor.grey,),
                          Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lectus id commodo egestas metus interdum dolor.",
                            style: dmsregular.copyWith(fontSize: 14,color: Jobstopcolor.grey),)
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
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
                          SizedBox(height: height/100,),
                          const Divider(color: Jobstopcolor.grey,),
                          SizedBox(height: height/100,),
                          Row(
                            children: [
                              Text("Manager",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.primarycolor),),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return const JobExperiences();
                                  },));
                                },
                                  child: Image.asset(JobstopPngImg.edit,height: height/36,color: Jobstopcolor.orenge,)),
                            ],
                          ),
                          SizedBox(height: height/100,),
                          Text("Amazon Inc",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),),
                          SizedBox(height: height/150,),
                          Text("Jan 2015 - Feb 2022 . 5 Years",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
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
                          SizedBox(height: height/100,),
                          SizedBox(height: height/100,),
                          const Divider(color: Jobstopcolor.grey,),
                          SizedBox(height: height/100,),
                          Row(
                            children: [
                              Text("Information Technology",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.primarycolor),),
                              const Spacer(),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return const ChangeEducation(type: "1");
                                    },));
                                  },
                                  child: Image.asset(JobstopPngImg.edit,height: height/36,color: Jobstopcolor.orenge,)),
                            ],
                          ),
                          SizedBox(height: height/100,),
                          Text("University of Oxford",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),),
                          SizedBox(height: height/150,),
                          Text("Sep 2010 - Aug 2013  . 5 Years",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),),
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
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(JobstopPngImg.skil,height: height/40,),
                              SizedBox(width: width/36,),
                              Text("Skill",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.primarycolor),),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return const JobstopPosition(type: "7",);
                                  },));
                                },
                                  child: Image.asset(JobstopPngImg.edit,height: height/36,color: Jobstopcolor.orenge,))
                            ],
                          ),
                          SizedBox(height: height/100,),
                          const Divider(color: Jobstopcolor.grey,),
                          GridView.builder(
                            itemCount: skill.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                childAspectRatio: 1/0.4,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ), itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Jobstopcolor.greyyy
                                  ),
                                  child: Center(
                                    child: Text(skill[index].toString(),style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),),
                                  ),
                                );
                              },),
                          SizedBox(height: height/96,),
                          Center(child: Text("See more",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),),)
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
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(JobstopPngImg.language,height: height/40,),
                              SizedBox(width: width/36,),
                              Text("Language",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.primarycolor),),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return const JonLanguage();
                                  },));
                                },
                                  child: Image.asset(JobstopPngImg.edit,height: height/36,color: Jobstopcolor.orenge,))
                            ],
                          ),
                          SizedBox(height: height/100,),
                          const Divider(color: Jobstopcolor.grey,),
                          GridView.builder(
                            itemCount: language.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1/0.4,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ), itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Jobstopcolor.greyyy
                              ),
                              child: Center(
                                child: Text(language[index].toString(),style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),),
                              ),
                            );
                          },),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
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
                          SizedBox(height: height/100,),
                          SizedBox(height: height/100,),
                          const Divider(color: Jobstopcolor.grey,),
                          SizedBox(height: height/100,),
                          Row(
                            children: [
                              Text("Wireless Symposium (RWS)",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.primarycolor),),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return const ChangeEducation(type: "2");
                                  },));
                                },
                                  child: Image.asset(JobstopPngImg.edit,height: height/36,color: Jobstopcolor.orenge,)),
                            ],
                          ),
                          SizedBox(height: height/100,),
                          Text("Young Scientist",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),),
                          SizedBox(height: height/150,),
                          Text("2014",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),),
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
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(JobstopPngImg.resume,height: height/40,),
                              SizedBox(width: width/36,),
                              Text("Resume",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.primarycolor),),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return const AddResume();
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
                          SizedBox(height: height/100,),
                          const Divider(color: Jobstopcolor.grey,),
                          SizedBox(height: height/100,),
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
                              ),
                              const Spacer(),
                              Image.asset(JobstopPngImg.deleted,height: height/36,color: Jobstopcolor.red,)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
