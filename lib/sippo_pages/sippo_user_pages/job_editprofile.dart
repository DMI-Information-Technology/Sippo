import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/sippo_custom_widget/ConditionalWidget.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/circular_image.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/utils/getx_text_editing_controller.dart';
import 'package:jobspot/utils/image_picker_service.dart';
import 'package:jobspot/utils/validating_input.dart';

import '../../JobGlobalclass/sippo_customstyle.dart';
import '../../JopController/user_profile_controller/edit_profile_information_controller.dart';
import '../../sippo_custom_widget/gender_picker_widget.dart';
import '../../sippo_custom_widget/success_message_widget.dart';

class EditUserProfilePage extends StatefulWidget {
  const EditUserProfilePage({Key? key}) : super(key: key);

  @override
  State<EditUserProfilePage> createState() => _EditUserProfilePageState();
}

class _EditUserProfilePageState extends State<EditUserProfilePage> {
  final _controller = Get.put(EditProfileInfoController());

  @override
  Widget build(BuildContext context) {
    final profileEditState = _controller.profileEditState;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit_profile".tr,
          style: dmsmedium.copyWith(fontSize: FontSize.title5(context)),
        ),
      ),
      body: BodyWidget(
        isScrollable: true,
        paddingContent: EdgeInsets.symmetric(
          horizontal: context.fromWidth(CustomStyle.xs),
          vertical: context.fromHeight(CustomStyle.paddingValue),
        ),
        child: Form(
          key: _controller.formKey,
          child: Column(
            children: [
              _buildUploaderImageProfile(context),
              SizedBox(height: context.fromHeight(CustomStyle.s)),
              Obx(() => ConditionalWidget(
                    _controller.states.isSuccess,
                    data: _controller.states,
                    guaranteedBuilder: (context, data) =>
                        CardNotifyMessage.success(
                      state: data,
                      onCancelTap: () => _controller.successState(false),
                    ),
                  )),
              Obx(() => ConditionalWidget(
                    _controller.states.isWarning,
                    data: _controller.states,
                    guaranteedBuilder: (context, data) =>
                        CardNotifyMessage.warning(
                      state: data,
                      onCancelTap: () => _controller.warningState(false),
                    ),
                  )),
              InputBorderedField(
                hintText: "enter your name",
                gController: profileEditState.name,
                // height: context.fromHeight(CustomStyle.inputBorderedSize),
                fontSize: FontSize.label(context),
                suffixIcon: Icon(
                  Icons.person_outline_outlined,
                  color: Jobstopcolor.primarycolor,
                ),
                // textInputAction: TextInputAction.newline,
                validator: (value) {
                  return ValidatingInput.validateEmptyField(
                    value,
                    message: "name field is required.",
                  );
                },
              ),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              InputBorderedField(
                keyboardType: TextInputType.emailAddress,
                hintText: "enter your email",
                gController: profileEditState.email,
                height: context.fromHeight(CustomStyle.inputBorderedSize),
                fontSize: FontSize.label(context),
                suffixIcon: Icon(
                  Icons.email_outlined,
                  color: Jobstopcolor.primarycolor,
                ),
                // textInputAction: TextInputAction.newline,
              ),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              _buildInputPhoneNumberField(
                context,
                profileEditState.phone,
                "Phone number",
                isPrimary: true,
              ),
              SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
              _buildInputPhoneNumberField(
                context,
                profileEditState.secondaryPhone,
                "Secondary Phone number",
              ),
              SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
              InputBorderedField(
                readOnly: true,
                hintText: "Select your Gender",
                gController: profileEditState.gender,
                height: context.fromHeight(CustomStyle.inputBorderedSize),
                fontSize: FontSize.label(context),
                suffixIcon: Icon(
                  Icons.arrow_drop_down_sharp,
                  color: Jobstopcolor.primarycolor,
                ),
                onTap: () {
                  Get.dialog(
                    Obx(
                      () => GenderPickerDialog(
                        onSelectedGender: (gender) {
                          if (gender != null) {
                            profileEditState.genderValue = gender;
                          }
                        },
                        genderValue: profileEditState.genderValue,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        paddingBottom: EdgeInsets.all(
          context.fromWidth(CustomStyle.paddingValue),
        ),
        bottomScreen: CustomButton(
            onTappeed: () async {
              if (_controller.formKey.currentState?.validate() == true) {
                await _controller.onSaveSubmitted();
              }
            },
            text: "Save"),
      ),
      backgroundColor: Jobstopcolor.backgroudHome,
    );
  }

  Widget _buildUploaderImageProfile(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Obx(() => ConditionalWidget(
              _controller.profileImagePath.isNotEmpty,
              data: _controller.profileImagePath,
              guaranteedBuilder: (_, data) => CircularImage.file(
                data != null ? File(data) : null,
                size: context.height / 6,
              ),
              avoidBuilder: (_, __) => CircularImage(
                JobstopPngImg.signup,
                size: context.height / 6,
              ),
            )),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(
                context.fromHeight(CustomStyle.huge2),
              ),
            ),
            onPressed: () async {
              _controller.profileImagePath =
                  await ImagePickerFile.pickImageFromGalleryPath();
            },
            child: Icon(
              Icons.edit,
              color: Jobstopcolor.white,
              size: context.fromHeight(CustomStyle.m),
            ))
      ],
    );
  }

  Container _buildInputPhoneNumberField(
    BuildContext context,
    GetXTextEditingController gTxtController,
    String? hintTxt, {
    bool isPrimary = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Jobstopcolor.white,
      ),
      child: IntlPhoneField(
        controller: gTxtController.controller,
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
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          hintText: hintTxt,
          hintStyle: dmsregular.copyWith(
            fontSize: FontSize.label(context),
            color: Colors.grey,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          suffixIcon: Icon(
            Icons.phone_outlined,
            color: Jobstopcolor.primarycolor,
          ),
        ),
        showCursor: true,
        initialCountryCode: 'LY',
        // textInputAction: TextInputAction.newline,
        onChanged: (phone) {},
        validator: isPrimary
            ? (value) {
                return ValidatingInput.validateEmptyField(
                  value?.number,
                  message: "phone number field is required.",
                );
              }
            : null,
      ),
    );
  }
}
