import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/sippo_controller/user_profile_controller/edit_profile_information_controller.dart';
import 'package:jobspot/sippo_custom_widget/ConditionalWidget.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/custom_drop_down_button.dart';
import 'package:jobspot/sippo_custom_widget/gender_picker_widget.dart';
import 'package:jobspot/sippo_custom_widget/loading_view_widgets/loading_scaffold.dart';
import 'package:jobspot/sippo_custom_widget/network_bordered_circular_image_widget.dart';
import 'package:jobspot/sippo_custom_widget/rounded_border_radius_card_widget.dart';
import 'package:jobspot/sippo_custom_widget/save_image_profle_page_widget.dart';
import 'package:jobspot/sippo_custom_widget/success_message_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/utils/getx_text_editing_controller.dart';
import 'package:jobspot/utils/image_picker_service.dart';
import 'package:jobspot/utils/states.dart';
import 'package:jobspot/utils/validating_input.dart';
import 'package:lottie/lottie.dart';

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
    return LoadingScaffold(
      controller: _controller.loadingOverlayController,
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
                    _controller.states.isWarning,
                    data: _controller.states,
                    guaranteedBuilder: (context, data) =>
                        CardNotifyMessage.warning(
                      state: data,
                      onCancelTap: () => _controller.states = States(),
                    ),
                  )),
              Obx(() => ConditionalWidget(
                    _controller.states.isError,
                    data: _controller.states,
                    guaranteedBuilder: (context, data) =>
                        CardNotifyMessage.error(
                      state: data,
                      onCancelTap: () => _controller.states = States(),
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
                        message: "is_req".tr,
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
                    hintText: 'hint_text_enter_email'.tr,
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
                      _controller.userDetails.pendingEmailIsNotEmpty,
                      data: _controller.userDetails,
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
                    height: context.fromHeight(CustomStyle.spaceBetween),
                  ),
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
                    "second_phone_number".tr,
                  ),
                  SizedBox(
                    height: context.fromHeight(CustomStyle.spaceBetween),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.fromWidth(CustomStyle.paddingValue),
                    ),
                    child: Text(
                      'gender'.tr,
                      style:
                          dmsmedium.copyWith(fontSize: FontSize.label(context)),
                    ),
                  ),
                  InputBorderedField(
                    readOnly: true,
                    hintText: "select_your_gender".tr,
                    gController: profileEditState.gender,
                    height: context.fromHeight(CustomStyle.inputBorderedSize),
                    fontSize: FontSize.label(context),
                    suffixIcon: Icon(
                      Icons.arrow_drop_down_sharp,
                      color: SippoColor.primarycolor,
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
                  SizedBox(
                    height: context.fromHeight(CustomStyle.huge),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.fromWidth(CustomStyle.paddingValue),
                    ),
                    child: Text(
                      'Nationality'.tr,
                      style:
                          dmsmedium.copyWith(fontSize: FontSize.label(context)),
                    ),
                  ),
                  InkWell(
                    onTap: () => _showNationalityList(context),
                    child: SizedBox(
                      width: context.width,
                      child: RoundedBorderRadiusCardWidget(
                          radiusValue: 12.0,
                          color: Colors.white,
                          child: Obx(() {
                            final selected = _controller
                                .profileEditState.selectedNationality.name;
                            return Text(
                              selected ?? 'select_nationality'.tr,
                            );
                          })),
                    ),
                  ),
                  SizedBox(
                    height: context.fromHeight(CustomStyle.spaceBetween),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.fromWidth(CustomStyle.paddingValue),
                    ),
                    child: Text(
                      'location_address'.tr,
                      style:
                          dmsmedium.copyWith(fontSize: FontSize.label(context)),
                    ),
                  ),
                  Obx(() {
                    final location = _controller.profileEditState;
                    return CustomDropdownButton(
                      textHint: 'select_location_address'.tr,
                      labelList: location.locationsAddressNameList,
                      values: location.locationsAddressList,
                      fillColor: Colors.white,
                      onItemSelected: (value) async {
                        if (value == null) return;
                        location.selectedLocationAddress = value;
                        print(value);
                      },
                      setInitialValue:
                          location.selectedLocationAddress.id != null,
                      initialValue: location.selectedLocationAddress.name,
                    );
                  }),
                ],
              )
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
                  if (_controller.states.isSuccess ||
                      _controller.locationStates.isSuccess) Get.back();
                });
              }
            },
            text: "save".tr),
      ),
      backgroundColor: SippoColor.backgroudHome,
    );
  }

  Widget _buildUploaderImageProfile(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Obx(() => NetworkBorderedCircularImage(
              imageUrl: _controller.userDetails.profileImage?.url ?? '',
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

  void _showNationalityList(BuildContext context) {
    final nationalities = _controller.profileEditState.nationalities;
    if (nationalities.isEmpty) {
      _controller.fetchNationalities();
    }
    Get.dialog(Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: SizedBox(
        height: context.fromHeight(1.3),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: context.fromWidth(CustomStyle.s),
            horizontal: context.fromWidth(CustomStyle.s),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InputBorderedField(
                fillColor: SippoColor.backgroudHome,
                hintText: 'search'.tr,
                prefixIcon: Icon(Icons.search_rounded),
                onTextChanged: (value) {
                  _controller.profileEditState.searchNationalityKey = value;
                },
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: context.fromHeight(CustomStyle.paddingValue),
                  bottom: context.fromHeight(CustomStyle.huge),
                ),
                child: SizedBox(
                  width: context.width,
                  child: Text(
                    'profession_title'.tr,
                    style: dmsbold.copyWith(
                        fontSize: FontSize.title5(context),
                        color: SippoColor.primarycolor),
                  ),
                ),
              ),
              Obx(() {
                final searchKey =
                    _controller.profileEditState.searchNationalityKey;
                final professionsItems = _controller.profileEditState
                    .filteredNationalities(searchKey);
                if (professionsItems.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: professionsItems.length,
                      itemBuilder: (context, index) {
                        final item = professionsItems[index];
                        return ListTile(
                          tileColor: item ==
                                  _controller
                                      .profileEditState.selectedNationality
                              ? SippoColor.backgroudHome
                              : null,
                          onTap: () {
                            _controller.profileEditState.selectedNationality =
                                item;
                            if (Get.isOverlaysOpen) Navigator.pop(context);
                          },
                          titleAlignment: ListTileTitleAlignment.center,
                          title: Text(
                            item.name ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: dmsmedium,
                          ),
                        );
                      },
                    ),
                  );
                } else if (_controller.fetchNationalityStates.isError) {
                  final msg = _controller.fetchNationalityStates.message;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        msg ?? "",
                        textAlign: TextAlign.center,
                      ),
                      IconButton(
                        onPressed: () {
                          _controller.fetchNationalities();
                        },
                        icon: Icon(Icons.refresh),
                      )
                    ],
                  );
                } else if (_controller.fetchNationalityStates.isLoading) {
                  return Center(
                    child: Lottie.asset(
                      JobstopPngImg.loadingProgress,
                      height: context.height / 9,
                    ),
                  );
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "no_professions_found".tr,
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                      onPressed: () => _controller.fetchNationalities(),
                      icon: Icon(Icons.refresh),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    )).then((value) {
      _controller.profileEditState.searchNationalityKey = "";
    });
  }
}
