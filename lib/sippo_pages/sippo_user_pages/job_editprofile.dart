import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/sippo_custom_widget/circular_image.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/utils/helper.dart' as helper;
import 'package:jobspot/utils/image_picker_service.dart';
import '../../JobGlobalclass/sippo_customstyle.dart';
import '../../JopController/ProfileController/edit_profile_information_controller.dart';
import '../../sippo_themes/themecontroller.dart';

class EditUserProfilePage extends StatefulWidget {
  const EditUserProfilePage({Key? key}) : super(key: key);

  @override
  State<EditUserProfilePage> createState() => _EditUserProfilePageState();
}

class _EditUserProfilePageState extends State<EditUserProfilePage> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit_profile".tr,
          style: dmsmedium.copyWith(fontSize: FontSize.title5(context)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.fromWidth(CustomStyle.xs),
            vertical: context.fromHeight(CustomStyle.paddingValue),
          ),
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Obx(
                    () => editProfileController.profileImagePath.isNotEmpty
                        ? CircularImage.file(
                            File(editProfileController.profileImagePath),
                            size: context.height / 6,
                          )
                        : CircularImage(
                            JobstopPngImg.signup,
                            size: context.height / 6,
                          ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(
                          context.fromHeight(CustomStyle.huge2),
                        ),
                      ),
                      onPressed: () async {
                        editProfileController.profileImagePath =
                            await ImagePickerFile.pickImageFromGalleryPath();
                      },
                      child: Icon(
                        Icons.edit,
                        color: Jobstopcolor.white,
                        size: context.fromHeight(CustomStyle.m),
                      ))
                ],
              ),
              SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
              InputBorderedField(
                hintText: "enter your user name",
                controller: username,
                height: context.fromHeight(CustomStyle.inputBorderedSize),
                fontSize: FontSize.label(context),
                suffixIcon: Icon(
                  Icons.person_outline_outlined,
                  color: Jobstopcolor.primarycolor,
                ),
              ),
              SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
              InputBorderedField(
                hintText: "enter your birthday",
                controller: dob,
                height: context.fromHeight(CustomStyle.inputBorderedSize),
                fontSize: FontSize.label(context),
                suffixIcon: IconButton(
                  onPressed: () {
                    helper.showMyDatePicker(context, (date) {
                      dob.text = helper.dobFormatter(date ?? DateTime.now());
                    });
                  },
                  icon: Icon(
                    Icons.date_range_outlined,
                    color: Jobstopcolor.primarycolor,
                  ),
                ),
              ),
              SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
              InputBorderedField(
                hintText: "enter your email",
                controller: email,
                height: context.fromHeight(CustomStyle.inputBorderedSize),
                fontSize: FontSize.label(context),
                suffixIcon: Icon(
                  Icons.email_outlined,
                  color: Jobstopcolor.primarycolor,
                ),
              ),
              SizedBox(height: context.fromHeight(CustomStyle.s)),
              _buildInputPhoneNumberField(context),
              SizedBox(height: context.fromHeight(CustomStyle.s)),
              InputBorderedField(
                readOnly: true,
                hintText: "Select your Gender",
                controller: genderCon,
                height: context.fromHeight(CustomStyle.inputBorderedSize),
                fontSize: FontSize.label(context),
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
              SizedBox(height: context.fromHeight(CustomStyle.s)),
              CustomButton(onTappeed: () {}, text: "Save"),
            ],
          ),
        ),
      ),
      backgroundColor: Jobstopcolor.backgroudHome,
    );
  }

  Container _buildInputPhoneNumberField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Jobstopcolor.white,
      ),
      child: IntlPhoneField(
        disableLengthCheck: true,
        flagsButtonPadding: EdgeInsets.all(
          context.fromWidth(CustomStyle.xxxl),
        ),
        dropdownIconPosition: IconPosition.trailing,
        dropdownTextStyle: dmsregular.copyWith(
          fontSize: FontSize.label(context),
          color: Jobstopcolor.grey,
        ),
        dropdownIcon: Icon(
          Icons.arrow_drop_down,
          color: Jobstopcolor.grey,
          size: context.fromHeight(CustomStyle.s),
        ),
        style: dmsmedium.copyWith(
          fontSize: FontSize.label(context),
        ),
        cursorColor: Jobstopcolor.white,
        decoration: InputDecoration(
            hintText: 'Phone Number',
            hintStyle: dmsmedium.copyWith(
                fontSize: FontSize.label(context), color: Jobstopcolor.grey),
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
