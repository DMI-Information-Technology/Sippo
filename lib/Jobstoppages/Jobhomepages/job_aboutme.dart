import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';

class JobAboutme extends StatefulWidget {
  const JobAboutme({Key? key}) : super(key: key);

  @override
  State<JobAboutme> createState() => _JobAboutmeState();
}

class _JobAboutmeState extends State<JobAboutme> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  TextEditingController aboutme = TextEditingController();
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
            Text("About me",style: dmsbold.copyWith(fontSize: 16,color: Jobstopcolor.primarycolor),),
            SizedBox(height: height/36,),
            Container(
              height: height/4,
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
                controller:aboutme,
                style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),
                cursorColor: Jobstopcolor.grey,
                maxLines: 8,
                decoration: InputDecoration(
                    filled: true,
                    hintText: "Tell me about you.",
                    hintStyle: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none),
                    fillColor: Jobstopcolor.white),
              ),
            ),
            const Spacer(),
            InkWell(
              highlightColor: Jobstopcolor.transparent,
              splashColor: Jobstopcolor.transparent,
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return const JobDashboard();
                // },));
              },
              child: Center(
                child: Container(
                  height: height/15,
                  width: width/1.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Jobstopcolor.primarycolor
                  ),
                  child:
                  Center(child: Text("Save".tr,style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.white),)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
