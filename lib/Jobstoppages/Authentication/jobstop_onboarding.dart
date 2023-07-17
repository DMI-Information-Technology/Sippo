import 'package:flutter/material.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/Jobstoppages/Authentication/jobstop_login.dart';

class JobOnboarding extends StatefulWidget {
  const JobOnboarding({Key? key}) : super(key: key);

  @override
  State<JobOnboarding> createState() => _JobOnboardingState();
}

class _JobOnboardingState extends State<JobOnboarding> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
          body: Padding(
            padding:  EdgeInsets.symmetric(horizontal: width/26,vertical: height/26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Jobspot",style: dmsbold.copyWith(fontSize: 18),)
                  ],
                ),
                SizedBox(height: height/10,),
                Center(child: Image.asset(JobstopPngImg.onboarding,height: height/2.5,)),
                SizedBox(height: height/12,),
                Text("Find Your",style: dmsbold.copyWith(fontSize: 40),),
                Text("Dream Job",style: dmsbold.copyWith(fontSize: 40,color: Jobstopcolor.orenge,decoration: TextDecoration.underline),),
                Text("Here!",style: dmsbold.copyWith(fontSize: 40),),
                SizedBox(height: height/96,),
                Text("Explore all the most exciting job roles based on your interest and study major.",style: dmsregular.copyWith(fontSize: 14),),
              ],
            ),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const JobstopLogin();
          },));
        },
        backgroundColor: Jobstopcolor.primarycolor,
        child: const Icon(Icons.arrow_right_alt_sharp,color: Jobstopcolor.white,size: 30,),
      ),
    );
  }
}
