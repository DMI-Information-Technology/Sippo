import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/Jobstoppages/Authentication/jobstop_forget.dart';
import 'package:jobspot/Jobstoppages/Authentication/jobstop_signup.dart';

import '../../JobThemes/themecontroller.dart';
import '../Jobhomepages/jobstop_dashboard.dart';

class JobstopLogin extends StatefulWidget {
  const JobstopLogin({Key? key}) : super(key: key);

  @override
  State<JobstopLogin> createState() => _JobstopLoginState();
}

class _JobstopLoginState extends State<JobstopLogin> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  bool _obscureText = true;
  final themedata = Get.put(JobstopThemecontroler());

  void _togglePasswordStatus() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  bool ischecked = true;
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Jobstopcolor.grey;
    }
    return Jobstopcolor.lightprimary;
  }
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: width/26,vertical: height/26),
          child: Column(
            children: [
              SizedBox(height: height/26,),
              Text("Welcome Back",style: dmsbold.copyWith(fontSize: 30,color:themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
              SizedBox(height: height/96,),
              Text("Lorem ipsum dolor sit amet, consectetur adipiscing\n elit, sed do eiusmod tempor",
                style: dmsregular.copyWith(fontSize: 12,color:themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),textAlign: TextAlign.center,),
              SizedBox(height: height/10,),
              Row(
                children: [
                  Text("Email",style: dmsbold.copyWith(fontSize: 12,color:themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
                ],
              ),
              SizedBox(height: height/46,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 5,
                      color: Jobstopcolor.greyyy,
                    )
                  ]
                ),
                child: TextField(
                  controller:email,
                  style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),
                  cursorColor: Jobstopcolor.grey,
                  decoration: InputDecoration(
                      filled: true,
                      hintText: "Email".tr,
                      hintStyle: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none),
                      fillColor: Jobstopcolor.white),
                ),
              ),
              SizedBox(height: height/46,),
              Row(
                children: [
                  Text("Password",style: dmsbold.copyWith(fontSize: 12,color:themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
                ],
              ),
              SizedBox(height: height/46,),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 5,
                        color: Jobstopcolor.greyyy,
                      )
                    ]
                ),
                child: TextField(
                  controller:password,
                  style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),
                  cursorColor: Jobstopcolor.grey,
                  decoration: InputDecoration(
                      filled: true,
                      hintText: "Password".tr,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: _togglePasswordStatus,
                        color: Jobstopcolor.primarycolor,
                      ),
                      hintStyle: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none),
                      fillColor: Jobstopcolor.white),
                ),
              ),
              SizedBox(height: height/96,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Checkbox(
                    checkColor: Jobstopcolor.white,
                    side: const BorderSide(
                      color: Jobstopcolor.grey,
                      width: 1.5,
                    ),
                    fillColor:
                    MaterialStateProperty.resolveWith(getColor),
                    value: ischecked,
                    onChanged: (bool? value) {
                      setState(
                            () {
                          ischecked = value!;
                        },
                      );
                    },
                  ),
                  Text(
                    "Remember_me".tr,
                    style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),
                  ),
                  SizedBox(width: width/4,),
                  InkWell(
                    highlightColor: Jobstopcolor.transparent,
                    splashColor: Jobstopcolor.transparent,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const JobstopForget();
                      },));
                    },
                    child: Text(
                      "Forget_Password".tr,
                      style: dmsregular.copyWith(fontSize: 12,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),
                    ),
                  ),

                ],
              ),
              SizedBox(height: height/16,),
              InkWell(
                highlightColor: Jobstopcolor.transparent,
                splashColor: Jobstopcolor.transparent,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const JobDashboard();
                  },));
                },
                child: Center(
                  child: Container(
                    height: height/15,
                    width: width/1.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Jobstopcolor.primarycolor
                    ),
                    child:
                    Center(child: Text("LOGIN".tr,style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.white),)),
                  ),
                ),
              ),
              SizedBox(height: height/36,),
              InkWell(
                highlightColor: Jobstopcolor.transparent,
                splashColor: Jobstopcolor.transparent,
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return const SmartDashboard();
                  // },));
                },
                child: Center(
                  child: Container(
                    height: height/15,
                    width: width/1.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Jobstopcolor.lightprimary
                    ),
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Image.asset(JobstopPngImg.google,height: height/36,),
                        SizedBox(width: width/36,),
                        Text("Sign in with Google".tr,style: dmsbold.copyWith(fontSize: 14,color: Jobstopcolor.primarycolor),),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: height/36,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "You_dont_have_an_account_yet".tr,
                    style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.darkgrey),
                  ),
                  SizedBox(width: width/46,),
                  InkWell(
                    highlightColor: Jobstopcolor.transparent,
                    splashColor: Jobstopcolor.transparent,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const JobstopSignup();
                      },));
                    },
                    child: Text(
                      "Sign_up".tr,
                      style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.orenge,decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
