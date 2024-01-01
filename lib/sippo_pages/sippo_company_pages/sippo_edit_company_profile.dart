import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/JobGlobalclass/media_query_sizes.dart';
import 'package:sippo/JobGlobalclass/sippo_customstyle.dart';
import 'package:sippo/JobGlobalclass/text_font_size.dart';
import 'package:sippo/sippo_controller/company_profile_controller/edit_copmany_profile_information_controller.dart';
import 'package:sippo/sippo_custom_widget/ConditionalWidget.dart';
import 'package:sippo/sippo_custom_widget/body_widget.dart';
import 'package:sippo/sippo_custom_widget/network_bordered_circular_image_widget.dart';
import 'package:sippo/sippo_custom_widget/save_image_profle_page_widget.dart';
import 'package:sippo/sippo_custom_widget/success_message_widget.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';
import 'package:sippo/utils/getx_text_editing_controller.dart';
import 'package:sippo/utils/helper.dart';
import 'package:sippo/utils/image_picker_service.dart';
import 'package:sippo/utils/validating_input.dart';

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
              Obx(() => ConditionalWidget(
                    _controller.states.isError,
                    data: _controller.states,
                    guaranteedBuilder: (context, data) =>
                        CardNotifyMessage.error(
                      state: data,
                      onCancelTap: () =>
                          _controller.states = _controller.states.copyWith(
                        isError: false,
                        message: '',
                      ),
                    ),
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.fromWidth(CustomStyle.paddingValue),
                    ),
                    child: Text(
                      'label_name'.tr,
                      style:
                          dmsmedium.copyWith(fontSize: FontSize.label(context)),
                    ),
                  ),
                  InputBorderedField(
                    hintText: "hint_text_enter_name".tr,
                    gController: profileEditState.name,
                    // height: context.fromHeight(CustomStyle.inputBorderedSize),
                    fontSize: FontSize.label(context),
                    suffixIcon: Icon(
                      Icons.person_outline_outlined,
                      color: SippoColor.primarycolor,
                    ),
                    // textInputAction: TextInputAction.newline,
                    validator: (value) {
                      return ValidatingInput.validateEmptyField(
                        value,
                        message: "fullname_is_req".tr,
                      );
                    },
                  ),
                  SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: context.fromWidth(CustomStyle.spaceBetween),
                      ),
                      Text(
                        'Email'.tr,
                        style: dmsmedium.copyWith(
                            fontSize: FontSize.label(context)),
                      ),
                      SizedBox(
                        width: context.fromWidth(CustomStyle.xxxl),
                      ),
                      Obx(() => CircleAvatar(
                            backgroundColor: _controller.isEmailVerified
                                ? Colors.green
                                : Colors.orangeAccent,
                            radius: context.fromWidth(95),
                          ))
                    ],
                  ),
                  InputBorderedField(
                    keyboardType: TextInputType.emailAddress,
                    hintText: "hint_text_enter_email".tr,
                    gController: profileEditState.email,
                    height: context.fromHeight(CustomStyle.inputBorderedSize),
                    fontSize: FontSize.label(context),
                    suffixIcon: Icon(
                      Icons.email_outlined,
                      color: SippoColor.primarycolor,
                    ),
                    // textInputAction: TextInputAction.newline,
                  ),
                  Obx(
                    () => ConditionalWidget(
                      _controller.companyDetails.pendingEmailIsNotEmpty,
                      data: _controller.companyDetails,
                      guaranteedBuilder: (context, data) => Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              context.fromWidth(CustomStyle.paddingValue),
                        ),
                        child: Text(
                          '${'pending_email'.tr} "${data?.pendingEmail}"',
                          style: dmsregular.copyWith(
                              fontSize: FontSize.label(context)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.fromWidth(CustomStyle.paddingValue),
                    ),
                    child: Text(
                      'phone_number'.tr,
                      style:
                          dmsmedium.copyWith(fontSize: FontSize.label(context)),
                    ),
                  ),
                  _buildInputPhoneNumberField(
                    context,
                    profileEditState.phone,
                    "phone_number".tr,
                    isPrimary: true,
                  ),
                  SizedBox(
                      height: context.fromHeight(CustomStyle.spaceBetween)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.fromWidth(CustomStyle.paddingValue),
                    ),
                    child: Text(
                      'second_phone_number'.tr,
                      style:
                          dmsmedium.copyWith(fontSize: FontSize.label(context)),
                    ),
                  ),
                  _buildInputPhoneNumberField(
                    context,
                    profileEditState.secondaryPhone,
                    "Secondary Phone number",
                  ),
                  SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.fromWidth(CustomStyle.paddingValue),
                    ),
                    child: Text(
                      'Website'.tr,
                      style:
                          dmsmedium.copyWith(fontSize: FontSize.label(context)),
                    ),
                  ),
                  InputBorderedField(
                    keyboardType: TextInputType.url,
                    hintText: "enter_website".tr,
                    gController: profileEditState.website,
                    height: context.fromHeight(CustomStyle.inputBorderedSize),
                    fontSize: FontSize.label(context),
                    suffixIcon: Icon(
                      Icons.web,
                      color: SippoColor.primarycolor,
                    ),
                    // textInputAction: TextInputAction.newline,
                  ),
                  SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.fromWidth(CustomStyle.paddingValue),
                    ),
                    child: Text(
                      'employee_counts'.tr,
                      style:
                          dmsmedium.copyWith(fontSize: FontSize.label(context)),
                    ),
                  ),
                  InputBorderedField(
                    keyboardType: TextInputType.number,
                    hintText: "enter_employee_counts".tr,
                    gController: profileEditState.employeesCount,
                    height: context.fromHeight(CustomStyle.inputBorderedSize),
                    fontSize: FontSize.label(context),
                    suffixIcon: Icon(
                      Icons.numbers,
                      color: SippoColor.primarycolor,
                    ),
                  ),
                  SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.fromWidth(CustomStyle.paddingValue),
                    ),
                    child: Text(
                      'establishment_date'.tr,
                      style:
                          dmsmedium.copyWith(fontSize: FontSize.label(context)),
                    ),
                  ),
                  _buildStartDateInput(context),
                ],
              ),
            ],
          ),
        ),
        paddingBottom: EdgeInsets.all(
          context.fromWidth(CustomStyle.paddingValue),
        ),
        bottomScreen: CustomButton(
          onTapped: () {
            if (_controller.formKey.currentState?.validate() == true) {
              _controller.onSaveSubmitted().then((_) {
                if (_controller.states.isSuccess) {
                  Get.back();
                }
              });
            }
          },
          text: "save".tr,
        ),
      ),
      backgroundColor: SippoColor.backgroudHome,
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
                  () => SaveImageProfilePageView(
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
              color: SippoColor.white,
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
        color: SippoColor.white,
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
          color: SippoColor.grey,
        ),
        dropdownIcon: Icon(
          Icons.arrow_drop_down,
          color: SippoColor.grey,
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
            color: SippoColor.primarycolor,
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
                  message: "phone_number_required".tr,
                );
              }
            : null,
      ),
    );
  }

  Widget _buildLoadingProgress(BuildContext context) {
    return Obx(() => ConditionalWidget(
          _controller.states.isLoading,
          isLoading: _controller.states.isLoading,
        ));
  }

  Widget _buildStartDateInput(BuildContext context) {
    final eduState = _controller.profileEditState;

    return InputBorderedField(
      onTap: () {
        showMyDatePicker(context, (date) {
          eduState.establishedDate.controller.text =
              customDateFormatter(date.toString(), "yyyy-MM-dd");
        });
      },
      readOnly: true,
      height: context.fromHeight(CustomStyle.inputBorderedSize),
      hintText: 'enter_establishment_date'.tr,
      fontSize: FontSize.label(context),
      gController: eduState.establishedDate,
      suffixIcon: const Icon(
        Icons.date_range_outlined,
        color: SippoColor.primarycolor,
      ),
    );
  }
}
