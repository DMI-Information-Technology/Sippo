import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/Jobstoppages/Jobhomepages/job_setting.dart';

import '../../JobThemes/themecontroller.dart';

class JobMyProfile extends StatefulWidget {
  const JobMyProfile({Key? key}) : super(key: key);

  @override
  State<JobMyProfile> createState() => _JobMyProfileState();
}

class _JobMyProfileState extends State<JobMyProfile> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  String? gender;
  final themedata = Get.put(JobstopThemecontroler());
  TextEditingController fullname = TextEditingController();
  TextEditingController birth = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController location = TextEditingController();
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
                padding: EdgeInsets.symmetric(horizontal: width/26,vertical: height/46),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height/66,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(JobstopPngImg.photo),
                        ),
                        SizedBox(width: width/2,),
                        Image.asset(JobstopPngImg.union,height: height/36,color: Jobstopcolor.white,),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return const JobstopSetting();
                            },));
                          },
                            child: Image.asset(JobstopPngImg.setting,height: height/36,color: Jobstopcolor.white)),
                      ],
                    ),
                    SizedBox(height: height/66,),
                    Text("Orlando Diggs",style: dmsmedium.copyWith(fontSize: 14,color: Jobstopcolor.white),),
                    SizedBox(height: height/100,),
                    Text("California, USA",style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.white),),
                    SizedBox(height: height/36,),
                    InkWell(
                      onTap: () {
                        // Navigator.pop(context);
                      },
                      child: Container(
                        height: height / 24,
                        width: width/3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Jobstopcolor.purpal
                        ),
                        child: Center(child: Text("Change image",
                            style: dmsregular.copyWith(fontSize: 12,
                                color: Jobstopcolor.white))),),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width/26,vertical: height/36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Fullname",style: dmsmedium.copyWith(fontSize: 12,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
                SizedBox(height: height/66,),
                Container(
                  height: height/15,
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
                    controller:fullname,
                    style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),
                    cursorColor: Jobstopcolor.grey,
                    decoration: InputDecoration(
                        filled: true,
                        hintText: "Full Name",
                        hintStyle: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none),
                        fillColor: Jobstopcolor.white),
                  ),
                ),
                SizedBox(height: height/36,),
                Text("Date of birth",style: dmsmedium.copyWith(fontSize: 12,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
                SizedBox(height: height/66,),
                Container(
                  height: height/15,
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
                    controller:birth,
                    style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),
                    cursorColor: Jobstopcolor.grey,
                    decoration: InputDecoration(
                        filled: true,
                        hintText: "06 August 1992",
                        suffixIcon: const Icon(Icons.calendar_month,color: Jobstopcolor.primarycolor,size: 20,),
                        hintStyle: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none),
                        fillColor: Jobstopcolor.white),
                  ),
                ),
                SizedBox(height: height/36,),
                Text("Gender",style: dmsmedium.copyWith(fontSize: 12,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
                SizedBox(height: height/66,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: height/15,
                      width: width/2.5,
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
                      child: Row(
                        children: [
                          SizedBox(
                            height: height/20,
                            child: Radio(
                              value: "male",
                              fillColor:const MaterialStatePropertyAll(Jobstopcolor.orenge),
                              activeColor: Jobstopcolor.orenge,
                              groupValue: gender,
                              onChanged: (value){
                                setState(() {
                                  gender = value.toString();
                                });
                              },
                            ),
                          ),
                          Text("Male",style: dmsregular.copyWith(fontSize: 12,color:Jobstopcolor.darkgrey )),
                        ],
                      ),
                    ),

                    Container(
                      height: height/15,
                      width: width/2.5,
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
                      child: Row(
                        children: [
                          SizedBox(
                            height: height/20,
                            child: Radio(
                              fillColor: const MaterialStatePropertyAll(Jobstopcolor.orenge),
                              activeColor: Jobstopcolor.orenge,
                              value: "female",
                              groupValue: gender,
                              onChanged: (value){
                                setState(() {
                                  gender = value.toString();
                                });
                              },
                            ),
                          ),
                          Text("Female",style: dmsregular.copyWith(fontSize: 12,color:Jobstopcolor.darkgrey ),),
                        ],
                      ),
                    ),

                  ],
                ),
                SizedBox(height: height/36,),
                Text("Email address",style: dmsmedium.copyWith(fontSize: 12,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
                SizedBox(height: height/66,),
                Container(
                  height: height/15,
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
                    controller:email,
                    style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),
                    cursorColor: Jobstopcolor.grey,
                    decoration: InputDecoration(
                        filled: true,
                        hintText: "Brandonelouis@gmail.com ",
                        hintStyle: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none),
                        fillColor: Jobstopcolor.white),
                  ),
                ),
                SizedBox(height: height/36,),
                Text("Phone number",style: dmsmedium.copyWith(fontSize: 12,color:themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
                SizedBox(height: height/66,),
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
                  child: IntlPhoneField(
                    disableLengthCheck: true,
                    flagsButtonPadding: const EdgeInsets.all(8),
                    dropdownIconPosition: IconPosition.trailing,
                    dropdownTextStyle: dmsregular.copyWith(
                        fontSize: 16, color: Jobstopcolor.grey),
                    dropdownIcon: Icon(
                      Icons.arrow_drop_down,
                      color: Jobstopcolor.grey,
                      size: height / 36,
                    ),
                    style: dmsmedium.copyWith(
                        fontSize: 12, color: Jobstopcolor.primarycolor),
                    cursorColor: Jobstopcolor.white,
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      hintStyle: dmsmedium.copyWith(
                          fontSize: 14, color: Jobstopcolor.grey),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:  BorderSide.none),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:  BorderSide.none),
                    ),
                    initialCountryCode: 'IN',
                    onChanged: (phone) {},
                  ),
                ),
                SizedBox(height: height/36,),
                Text("Location",style: dmsmedium.copyWith(fontSize: 12,color: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),),
                SizedBox(height: height/66,),
                Container(
                  height: height/15,
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
                    controller:location,
                    style: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.primarycolor),
                    cursorColor: Jobstopcolor.grey,
                    decoration: InputDecoration(
                        filled: true,
                        hintText: "California, United states",
                        hintStyle: dmsregular.copyWith(fontSize: 12,color: Jobstopcolor.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none),
                        fillColor: Jobstopcolor.white),
                  ),
                ),
                SizedBox(height: height/16,),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Center(
                    child: Container(
                      height: height / 15,
                      width: width/1.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Jobstopcolor.primarycolor
                      ),
                      child: Center(child: Text("SAVE",
                          style: dmsbold.copyWith(fontSize: 14,
                              color: Jobstopcolor.white))),),
                  ),
                ),
              ],
            ),)
          ],
        ),
      ),
    );
  }
}
