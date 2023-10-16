
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JopController/company_profile_controller/edit_copmany_profile_information_controller.dart';

import 'package:jobspot/sippo_custom_widget/save_job_card_widget.dart';

import '../../JobGlobalclass/jobstopcolor.dart';
import '../../JobGlobalclass/jobstopfontstyle.dart';
import '../../JobGlobalclass/sippo_customstyle.dart';
import '../../JobGlobalclass/text_font_size.dart';
import '../../sippo_custom_widget/ConditionalWidget.dart';
import '../../sippo_custom_widget/body_widget.dart';
import '../../sippo_custom_widget/save_image_profle_page_widget.dart';
import '../../sippo_custom_widget/success_message_widget.dart';
import '../../sippo_custom_widget/widgets.dart';
import '../../utils/getx_text_editing_controller.dart';
import '../../utils/image_picker_service.dart';
import '../../utils/validating_input.dart';

class EditCompanyProfilePage extends StatefulWidget {
  const EditCompanyProfilePage({Key? key}) : super(key: key);

  @override
  State<EditCompanyProfilePage> createState() => _EditCompanyProfilePageState();
}

class _EditCompanyProfilePageState extends State<EditCompanyProfilePage> {
  final _controller = Get.put(EditCompanyProfileInfoController());

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
              _buildLoadingProgress(context),
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
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              InputBorderedField(
                keyboardType: TextInputType.text,
                hintText: "enter your city",
                gController: profileEditState.city,
                height: context.fromHeight(CustomStyle.inputBorderedSize),
                fontSize: FontSize.label(context),
                suffixIcon: Icon(
                  Icons.location_on_outlined,
                  color: Jobstopcolor.primarycolor,
                ),
                // textInputAction: TextInputAction.newline,
              ),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              InputBorderedField(
                keyboardType: TextInputType.url,
                hintText: "enter your website",
                gController: profileEditState.website,
                height: context.fromHeight(CustomStyle.inputBorderedSize),
                fontSize: FontSize.label(context),
                suffixIcon: Icon(
                  Icons.web,
                  color: Jobstopcolor.primarycolor,
                ),
                // textInputAction: TextInputAction.newline,
              ),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              InputBorderedField(
                keyboardType: TextInputType.number,
                hintText: "enter your employees count",
                gController: profileEditState.employeesCount,
                height: context.fromHeight(CustomStyle.inputBorderedSize),
                fontSize: FontSize.label(context),
                suffixIcon: Icon(
                  Icons.numbers,
                  color: Jobstopcolor.primarycolor,
                ),
                // textInputAction: TextInputAction.newline,
              ),
            ],
          ),
        ),
        paddingBottom: EdgeInsets.all(
          context.fromWidth(CustomStyle.paddingValue),
        ),
        bottomScreen: CustomButton(
          onTapped: () async {
            if (_controller.formKey.currentState?.validate() == true) {
              await _controller.onSaveSubmitted();
            }
          },
          text: "Save",
        ),
      ),
      backgroundColor: Jobstopcolor.backgroudHome,
    );
  }

  Widget _buildUploaderImageProfile(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Obx(() => NetworkBorderedCircularImage(
              imageUrl: _controller.companyDetails.profileImage?.url ?? '',
              outerBorderColor: Colors.grey[400],
              size: context.height / 6,
              errorWidget: (_, __, ___) => const CircleAvatar(),
            )),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(
                context.fromHeight(CustomStyle.huge2),
              ),
            ),
            onPressed: () async {
              final file = await ImagePickerFile.pickImageFileFromGallery();
              if (file != null) {
                _controller.profileEditState.pickedImageProfile = file;
                await Get.to(
                  () => SaveImagePageView(
                    imageFile: file.file!,
                    onUpdateTapped: (loadingController) async {
                      loadingController.start();
                      await _controller.onImageUpdatedSubmitted();
                      loadingController.pause();
                    },
                  ),
                );
              }
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

  Widget _buildLoadingProgress(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return Obx(() => ConditionalWidget(
          _controller.states.isLoading,
          guaranteedBuilder: (__, _) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height / 36),
              const CircularProgressIndicator(),
            ],
          ),
        ));
  }
}

