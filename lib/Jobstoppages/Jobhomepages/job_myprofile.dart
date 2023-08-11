import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JopCustomWidget/widgets.dart';
import 'package:jobspot/utils/helper.dart' as helper;
import 'package:jobspot/utils/image_picker_service.dart';
import '../../JobThemes/themecontroller.dart';
import '../../JopController/ProfileController/edit_profile_information_controller.dart';

class JobMyProfile extends StatefulWidget {
  const JobMyProfile({Key? key}) : super(key: key);

  @override
  State<JobMyProfile> createState() => _JobMyProfileState();
}

class _JobMyProfileState extends State<JobMyProfile> {
  final themedata = Get.put(JobstopThemecontroler());
  TextEditingController username = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController genderCon = TextEditingController();
  EditProfileInformationController editProfileController =
      Get.put(EditProfileInformationController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit profile",
          style: dmsmedium.copyWith(fontSize: height / 52),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width / 18,
            vertical: height / 32,
          ),
          child: Column(
            children: [
              Obx(() {
                return Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    ClipOval(
                      child: editProfileController.profileImagePath.isNotEmpty
                          ? Image.file(
                              File(
                                editProfileController.profileImagePath,
                              ),
                              height: height / 5,
                            )
                          : Image.asset(
                              JobstopPngImg.signup,
                              height: height / 5,
                            ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(height / 128),
                        ),
                        onPressed: () async {
                          editProfileController.profileImagePath =
                              await ImagePickerFile.pickImageFromGalleryPath();
                        },
                        child: Icon(
                          Icons.edit,
                          color: Jobstopcolor.white,
                          size: height / 28,
                        ))
                  ],
                );
              }),
              SizedBox(height: height / 26),
              InputBorderedField(
                hintText: "enter your user name",
                controller: username,
                height: height / 13.5,
                fontSize: height / 75,
                suffixIcon: Icon(
                  Icons.person_outline_outlined,
                  color: Jobstopcolor.primarycolor,
                ),
              ),
              SizedBox(height: height / 38),
              InputBorderedField(
                hintText: "enter your birthday",
                controller: dob,
                height: height / 13.5,
                fontSize: height / 75,
                suffixIcon: IconButton(
                    onPressed: () {
                      helper.showMyDatePicker(context, (date) {
                        dob.text = helper.dobFormatter(date ?? DateTime.now());
                      });
                    },
                    icon: Icon(
                      Icons.date_range_outlined,
                      color: Jobstopcolor.primarycolor,
                    )),
              ),
              SizedBox(height: height / 38),
              InputBorderedField(
                hintText: "enter your email",
                controller: email,
                height: height / 13.5,
                fontSize: height / 75,
                suffixIcon: Icon(
                  Icons.email_outlined,
                  color: Jobstopcolor.primarycolor,
                ),
              ),
              SizedBox(height: height / 38),
              _buildInputPhoneNumberField(context),
              SizedBox(height: height / 38),
              InputBorderedField(
                readOnly: true,
                hintText: "Select your Gender",
                controller: genderCon,
                height: height / 13.5,
                fontSize: height / 75,
                suffixIcon: Icon(
                  Icons.arrow_drop_down_sharp,
                  color: Jobstopcolor.primarycolor,
                ),
                onTap: () {
                  helper.showGenderPicker(
                    context,
                    onGenderChange: (gender) {
                      if (gender != null) {
                        genderCon.text = gender.name;
                      }
                    },
                  );
                },
              ),
              SizedBox(height: height / 38),
              CustomButton(onTappeed: () {}, text: "Save"),
            ],
          ),
        ),
      ),
      backgroundColor: Jobstopcolor.backgroudHome,
    );
  }

  Container _buildInputPhoneNumberField(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Jobstopcolor.white,
      ),
      child: IntlPhoneField(
        disableLengthCheck: true,
        flagsButtonPadding: const EdgeInsets.all(8),
        dropdownIconPosition: IconPosition.trailing,
        dropdownTextStyle: dmsregular.copyWith(
          fontSize: height / 75,
          color: Jobstopcolor.grey,
        ),
        dropdownIcon: Icon(
          Icons.arrow_drop_down,
          color: Jobstopcolor.grey,
          size: height / 36,
        ),
        style: dmsmedium.copyWith(
          fontSize: 12,
        ),
        cursorColor: Jobstopcolor.white,
        decoration: InputDecoration(
            hintText: 'Phone Number',
            hintStyle: dmsmedium.copyWith(
                fontSize: height / 75, color: Jobstopcolor.grey),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none),
            suffixIcon: Icon(
              Icons.phone_outlined,
              color: Jobstopcolor.primarycolor,
            )),
        initialCountryCode: 'LY',
        onChanged: (phone) {},
      ),
    );
  }
}
