import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';

import '../../JobThemes/themecontroller.dart';
import 'add_language.dart';

class JonLanguage extends StatefulWidget {
  const JonLanguage({Key? key}) : super(key: key);

  @override
  State<JonLanguage> createState() => _JonLanguageState();
}

class _JonLanguageState extends State<JonLanguage> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  final themedata = Get.put(JobstopThemecontroler());
  List<String> languageimg = [JobstopPngImg.indonesian,JobstopPngImg.english];
  List<String> languagename = ["Indonesian(First language)","English"];
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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Language",style: dmsbold.copyWith(fontSize: 16,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const AddLanguage();
                      },));
                    },
                    child: Row(
                      children: [
                        Text("Add",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.purpal),),
                        SizedBox(width: width/36,),
                        const CircleAvatar(
                          radius: 10,
                          backgroundColor: Jobstopcolor.lightprimary,
                          child: Icon(Icons.add,size: 15,color: Jobstopcolor.primarycolor,),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: height/26,),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: languageimg.length,
                itemBuilder: (context, index) {
                return Container(
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
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: width/26,vertical: height/46),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundImage: AssetImage(languageimg[index].toString()),
                            ),
                            SizedBox(width: width/36,),
                            Text(languagename[index].toString(),style: dmsbold.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                _showremove();
                              },
                                child: Image.asset(JobstopPngImg.deleted,height: height/36,color: Jobstopcolor.red,))
                          ],
                        ),
                        SizedBox(height: height/96,),
                        Text("Oral : Level 10",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),),
                        SizedBox(height: height/96,),
                        Text("Written : Level 10",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),),
                      ],
                    ),
                  ),
                );
              },),
              SizedBox(height: height/16,),
              InkWell(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return const JobApplication();
                  // },));
                },
                child: Container(
                  height: height/18,
                  width: width/2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Jobstopcolor.primarycolor
                  ),
                  child:  Center(child: Text("SAVE",style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.white))),),
              ),
            ],
          ),
        ),
      ),
    );
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
                Text("Remove Indonesian ?",style: dmsbold.copyWith(fontSize: 16,color: Jobstopcolor.primarycolor),),
                SizedBox(height: height/100,),
                Text("Are you sure you want to delete this Indonesian language?",
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
