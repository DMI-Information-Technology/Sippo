import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';

import '../../sippo_themes/themecontroller.dart';

class JobUpdatePassword extends StatefulWidget {
  const JobUpdatePassword({Key? key}) : super(key: key);

  @override
  State<JobUpdatePassword> createState() => _JobUpdatePasswordState();
}

class _JobUpdatePasswordState extends State<JobUpdatePassword> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  final themedata = Get.put(JobstopThemecontroler());
  bool _obscureText = true;
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  void _togglePasswordStatus() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  void _togglePasswordStatus1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }
  void _togglePasswordStatus2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }
  TextEditingController newpassword = TextEditingController();
  TextEditingController oldpassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
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
            Text("Update Password",style: dmsmedium.copyWith(fontSize: 16,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
            SizedBox(height: height/26,),
            Text("Old Password",style: dmsmedium.copyWith(fontSize: 12,color:themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
            SizedBox(height: height/66,),
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
                controller:oldpassword,
                style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),
                cursorColor: Jobstopcolor.grey,
                decoration: InputDecoration(
                    filled: true,
                    hintText: "Old Password".tr,
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
            SizedBox(height: height/36,),
            Text("New Password",style: dmsmedium.copyWith(fontSize: 12,color:themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
            SizedBox(height: height/66,),
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
                controller:newpassword,
                style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),
                cursorColor: Jobstopcolor.grey,
                decoration: InputDecoration(
                    filled: true,
                    hintText: "New Password".tr,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText1 ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: _togglePasswordStatus1,
                      color: Jobstopcolor.primarycolor,
                    ),
                    hintStyle: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none),
                    fillColor: Jobstopcolor.white),
              ),
            ),
            SizedBox(height: height/36,),
            Text("Confirm Password",style: dmsmedium.copyWith(fontSize: 12,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
            SizedBox(height: height/66,),
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
                controller:confirmpassword,
                style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),
                cursorColor: Jobstopcolor.grey,
                decoration: InputDecoration(
                    filled: true,
                    hintText: "Confirm Password".tr,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText2 ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: _togglePasswordStatus2,
                      color: Jobstopcolor.primarycolor,
                    ),
                    hintStyle: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none),
                    fillColor: Jobstopcolor.white),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Center(
                child: Container(
                  height: height / 18,
                  width: width/1.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Jobstopcolor.primarycolor
                  ),
                  child: Center(child: Text("UPDATE",
                      style: dmsbold.copyWith(fontSize: 14,
                          color: Jobstopcolor.white))),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
