import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/Jobstoppages/Jobpostpages/jobstop_position.dart';

import '../../JobThemes/themecontroller.dart';

class AddLanguage extends StatefulWidget {
  const AddLanguage({Key? key}) : super(key: key);

  @override
  State<AddLanguage> createState() => _AddLanguageState();
}

class _AddLanguageState extends State<AddLanguage> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  final themedata = Get.put(JobstopThemecontroler());
  List<String> levelname = ["Level 0","Level 1","Level 2","Level 3","Level 4","Level 5","Level 6","Level 7","Level 8","Level 9","Level 10"];
  String? language;
  String? level;
  leveldialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            elevation: 0,
            backgroundColor: Jobstopcolor.transparent,
            child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                decoration: BoxDecoration(
                  color:themedata.isdark ? Jobstopcolor.black : Jobstopcolor.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width / 26, vertical: height / 36),
                  child: Column(
                    children: [
                      Container(
                        height: height / 500,
                        width: width / 8,
                        decoration: BoxDecoration(
                          color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      SizedBox(height: height / 26,),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: levelname.length,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(levelname[index].toString(),
                                style: dmsbold.copyWith(
                                    fontSize: 14,
                                    color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
                              SizedBox(
                                height: height / 20,
                                child: Radio(
                                  fillColor: const MaterialStatePropertyAll(Jobstopcolor.orenge),
                                  value: levelname[index].toString(),
                                  groupValue: level,
                                  activeColor: Jobstopcolor.orenge,
                                  onChanged: (value) {
                                    setState(() {
                                      level = value.toString();
                                    });
                                  },
                                ),
                              ),
                            ],
                          );
                        },),
                    const Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Container(
                            height: height / 18,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Jobstopcolor.primarycolor
                            ),
                            child: Center(child: Text("DONE",
                                style: dmsbold.copyWith(fontSize: 14,
                                    color: Jobstopcolor.white))),),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            ));
      },
    );
  }
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
              Text("Add Language",style: dmsbold.copyWith(fontSize: 16,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
              SizedBox(height: height/26,),
              Container(
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
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: width/26,vertical: height/46),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Language",style: dmsbold.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),),
                          const Spacer(),
                          CircleAvatar(
                            radius: 12,
                            backgroundImage: AssetImage(JobstopPngImg.indonesian),
                          ),
                          SizedBox(width: width/36,),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return const JobstopPosition(type: "8",);
                              },));
                            },
                              child: Text("Indonesian",style: dmsbold.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),)),
                        ],
                      ),
                      SizedBox(height: height/96,),
                      const Divider(color: Jobstopcolor.grey,),
                      Row(
                        children: [
                          Text("First language",style: dmsbold.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),),
                          const Spacer(),
                          SizedBox(
                            height: height / 20,
                            child: Radio(
                              value: "First language",
                              groupValue: language,
                              activeColor: Jobstopcolor.orenge,
                              onChanged: (value) {
                                setState(() {
                                  language = value.toString();
                                });
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: height/36,),
              Container(
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
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: width/26,vertical: height/46),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Oral",style: dmsbold.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),),
                      SizedBox(height: height/96,),
                      InkWell(
                          onTap: () {
                            leveldialog();
                          },
                          child: Text("level 10",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),)),
                      SizedBox(height: height/96,),
                      const Divider(color: Jobstopcolor.grey,),
                      SizedBox(height: height/96,),
                      Text("Written",style: dmsbold.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),),
                      SizedBox(height: height/96,),
                      Text("Choose your speaking skill level",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height/46,),
              Text("Proficiency level : 0 - Poor, 10 - Very good",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),),
              SizedBox(height: height/10,),
              InkWell(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return const JobApplication();
                  // },));
                },
                child: Center(
                  child: Container(
                    height: height/18,
                    width: width/2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Jobstopcolor.primarycolor
                    ),
                    child:  Center(child: Text("SAVE",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.white))),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
