import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/JobGlobalclass/jobstopimges.dart';
import 'package:sippo/JobGlobalclass/media_query_sizes.dart';
import 'package:sippo/JobGlobalclass/routes.dart';
import 'package:sippo/JobGlobalclass/sippo_customstyle.dart';
import 'package:sippo/JobServices/app_local_language_services/app_local_language_service.dart';
import 'package:sippo/sippo_controller/AuthenticationController/sippo_signup_user_controller.dart';
import 'package:sippo/sippo_custom_widget/custom_drop_down_button.dart';
import 'package:sippo/sippo_custom_widget/error_messages_dialog_snackbar/error_messages.dart';
import 'package:sippo/sippo_custom_widget/loading_view_widgets/overly_loading.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';
import 'package:sippo/utils/validating_input.dart';
class SippoUserSignup extends StatelessWidget {
  const SippoUserSignup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = SignUpUserController.instance;
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white, // Set AppBar color to red
            toolbarHeight: 80, // Increase AppBar height (adjust as needed)
            leading: Padding(
              padding:  EdgeInsets.symmetric(horizontal: width * 0.014),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // Make the container a circle
                  color: Colors.grey[300], // Optional: Add a background color
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            title: Text("Find A Job"),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(Icons.language, color: Colors.grey[800],),
                onPressed: () {
                  Get.focusScope?.unfocus();
                  LocalLanguageService.showChangeLanguageBottomSheet(context);
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width / 26, vertical: height / 26),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        JobstopPngImg.welcomeImage,
                        height: height / 7,
                        width: width * 0.75,
                      ),
                    ),
                    SizedBox(
                      height: height / 30,
                    ),

                    Text(
                      "Create_an_Account".tr,
                      style: dmsbold.copyWith(
                        fontSize: height / 30,
                        color: SippoColor.textColor,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      "Create_an_Account_description".tr,
                      style: dmsregular.copyWith(
                        fontSize: height / 45,
                        color: SippoColor.textColor,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: height / 30,
                    ),
                    InputField(
                      // controller: fullname,
                      hintText: "Full_name".tr,
                      keyboardType: TextInputType.text,
                      icon: const Icon(
                        Icons.person_outlined,
                        color: SippoColor.primarycolor,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "fullname_is_req".tr;
                        }
                        if (!ValidatingInput.validateFullName(value)) {
                          return "invalid full name";
                        }
                        return null;
                      },
                      onChangedText: (val) => controller.fullname = val.trim(),
                    ),
                    SizedBox(
                      height: height / 46,
                    ),
                    InputField(
                      // controller: phoneNum,
                      hintText: "phone_number".tr,
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      icon: const Icon(
                        Icons.phone_outlined,
                        color: SippoColor.primarycolor,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "phonenumber_is_req".tr;
                        }
                        if (!ValidatingInput.validatePhoneNumber(value)) {
                          return "invalid phone number";
                        }
                        return null;
                      },
                      onChangedText: (val) =>
                          controller.phoneNumber = val.trim(),
                    ),
                    SizedBox(
                      height: height / 46,
                    ),
                    PasswordInputField(
                        // controller: password,
                        hintText: "Password".tr,
                        icon: const Icon(
                          Icons.lock_outline,
                          color: SippoColor.primarycolor,
                        ),
                        validator: ValidatingInput.validatePassword,
                        onChangedText: (val) =>
                            controller.password = val.trim()),
                    SizedBox(
                      height: height / 46,
                    ),
                    PasswordInputField(
                      // controller: confirmPassword,
                      hintText: "Confirm_Password".tr,
                      icon: const Icon(
                        Icons.lock_outline,
                        color: SippoColor.primarycolor,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "confpasword_is_req".tr;
                        }
                        if (value != controller.password) {
                          return "the confirm password is not matches the password";
                        }
                        return null;
                      },
                      onChangedText: (val) =>
                          controller.confirmPassword = val.trim(),
                    ),
                    SizedBox(
                      height: height / 46,
                    ),
                    Obx(() {
                      final location = controller.locationAddressState;
                      return InkWell(
                        onTap: () {
                          if (location.isLocationAddressError) {
                            if (controller.isConnectionLostWithDialog) return;
                            controller.fetchLocationsAddress();
                          }
                        },
                        child: CustomDropdownButton(
                          hPaddingValue: 0.0,
                          prefixIcon: Icon(
                            Icons.location_on_outlined,
                            color: SippoColor.primarycolor,
                          ),
                          hintTextColor: Colors.grey[500],
                          underLineBorder: true,
                          textHint: 'select_location'.tr,
                          labelList: location.locationsAddressNameList,
                          values: location.locationsAddressList,
                          fillColor: Colors.white,
                          onItemSelected: (value) async {
                            if (value == null) return;
                            location.selectedLocationAddress = value;
                            print(value);
                          },
                          validator: ValidatingInput.validateEmptyField,
                          setInitialValue: false,
                        ),
                      );
                    }),
                    SizedBox(
                      height: height / 46,
                    ),
                    Obx(() => CheckboxListTile(
                          title: Text(
                            "terms_policy_title".tr,
                            textAlign: TextAlign.start,
                            style: dmsbold.copyWith(
                              fontSize: height / 42,
                            ),
                          ),
                          subtitle: Text(
                            "accept_terms".tr,
                            style: dmsregular.copyWith(fontSize: height / 52),
                          ),
                          value: controller.acceptTerms,
                          onChanged: (value) {
                            controller.acceptTerms = value ?? false;
                          },
                        )),
                    InkWell(
                      onTap: () => showNotAcceptedTermsAndConditionsDialog(
                        context.fromWidth(CustomStyle.paddingValue),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              context.fromWidth(CustomStyle.paddingValue),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            textAlign: TextAlign.start,
                            'read_policy_terms'.tr,
                            style: dmsmedium.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.blueAccent,
                              // Optional: set underline color
                              decorationThickness: 25,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height / 46,
                    ),
                    CustomButton(
                      text: "Sign_up".tr,
                      backgroundColor: SippoColor.primarycolor,
                      textColor: SippoColor.white,
                      onTapped: () => controller.onSubmittedSignup(),
                    ),
                    SizedBox(height: height / 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "You_have_an_account".tr,
                          style: dmsregular.copyWith(
                            fontSize: height / 62,
                            color: SippoColor.textColor,
                          ),
                        ),
                        SizedBox(width: width / 46),
                        InkWell(
                          highlightColor: SippoColor.transparent,
                          splashColor: SippoColor.transparent,
                          onTap: () {
                            Get.focusScope?.unfocus();
                            controller.authController.resetStates();
                            Get.offAndToNamed(SippoRoutes.userLoginPage);
                          },
                          child: Text(
                            "Sign_in".tr,
                            style: dmsregular.copyWith(
                              fontSize: height / 62,
                              color: SippoColor.secondary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height / 52),
                    const SeparatorLine(
                      text: 'or',
                    ),
                    SizedBox(height: height / 52),
                    CustomButton(
                      onTapped: () {
                        Get.focusScope?.unfocus();
                        controller.authController.resetStates();
                        Get.offAndToNamed(SippoRoutes.companysignup);
                      },
                      text: "company_signup".tr,
                      backgroundColor: SippoColor.white,
                      textColor: SippoColor.textColor,
                      borderColor: SippoColor.grey,
                    ),
                    SizedBox(height: height / 52),
                    CustomButton(
                      onTapped: () {
                        Get.focusScope?.unfocus();
                        controller.authController.resetStates();
                        Get.offAllNamed(SippoRoutes.sippoGuest);
                      },
                      text: "Guest_login.".tr,
                      backgroundColor: SippoColor.white,
                      textColor: SippoColor.textColor,
                      borderColor: SippoColor.grey,
                    ),
                  ],
                ),
              ),
            ),
          ),
          backgroundColor: Color(0xffFBF6FF),
        ),
        Obx(
          () => controller.authState.isLoading
              ? const LoadingOverlay()
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
