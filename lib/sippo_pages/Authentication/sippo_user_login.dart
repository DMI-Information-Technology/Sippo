import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/JobGlobalclass/jobstopimges.dart';
import 'package:sippo/JobGlobalclass/jobstopprefname.dart';
import 'package:sippo/JobGlobalclass/media_query_sizes.dart';
import 'package:sippo/JobGlobalclass/routes.dart';
import 'package:sippo/JobGlobalclass/sippo_customstyle.dart';
import 'package:sippo/JobGlobalclass/text_font_size.dart';
import 'package:sippo/JobServices/app_local_language_services/app_local_language_service.dart';
import 'package:sippo/sippo_controller/AuthenticationController/sippo_user_login_controller.dart';
import 'package:sippo/sippo_custom_widget/ConditionalWidget.dart';
import 'package:sippo/sippo_custom_widget/loading_view_widgets/overly_loading.dart';
import 'package:sippo/sippo_custom_widget/success_message_widget.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';

class SippoUserLogin extends StatefulWidget {
  const SippoUserLogin({Key? key}) : super(key: key);

  @override
  State<SippoUserLogin> createState() => _SippoUserLoginState();
}

class _SippoUserLoginState extends State<SippoUserLogin> {
  Color getColor(Set<WidgetState> states) {
    const Set<WidgetState> interactiveStates = <WidgetState>{
      WidgetState.pressed,
      WidgetState.hovered,
      WidgetState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return SippoColor.grey;
    }
    return SippoColor.lightprimary;
  }

  final _controller = UserLoginController.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width  = size.width;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white, // Set AppBar color to red
            toolbarHeight: 80, // Increase AppBar height (adjust as needed)
            //leadingWidth: width/3.5,
            leading: Padding(
              padding:  EdgeInsets.fromLTRB(width * 0.03, 0, 0, 0),
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
                horizontal: context.fromWidth(CustomStyle.paddingValue),
                vertical: context.fromHeight(CustomStyle.paddingValue),
              ),
              child: Form(
                key: _controller.formKey,
                child: Column(
                  children: [
                    Text(
                      "welcome_back_login_title".tr,
                      style: dmsbold.copyWith(
                        fontSize: FontSize.title2(context),
                        color: SippoColor.primarycolor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
                    AutoSizeText(
                      "welcome_back_user_message".tr,
                      style: dmsregular.copyWith(
                        color: SippoColor.textColor,
                        fontSize: FontSize.paragraph3(context),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: context.fromHeight(CustomStyle.xxl)),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InputField(
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
                          return null;
                        },
                        onChangedText: (value) {
                          _controller.phoneNumber = value.trim();
                        },
                      ),
                    ),
                    SizedBox(
                      height: context.fromHeight(CustomStyle.s),
                    ),
                    PasswordInputField(
                      hintText: "Password".tr,
                      icon: const Icon(
                        Icons.lock_outline,
                        color: SippoColor.primarycolor,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "password_is_req".tr;
                        }
                        return null;
                      },
                      onChangedText: (value) {
                        _controller.password = value.trim();
                      },
                    ),
                    SizedBox(
                      height: context.fromHeight(CustomStyle.spaceBetween),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Obx(
                              () => Checkbox(
                                checkColor: SippoColor.white,
                                side: const BorderSide(
                                  color: SippoColor.grey,
                                  width: 1.5,
                                ),
                                fillColor: WidgetStateProperty.resolveWith(
                                  getColor,
                                ),
                                value: _controller.isRememberMeChecked,
                                onChanged: (bool? value) {
                                  _controller.isRememberMeChecked =
                                      value ?? false;
                                },
                              ),
                            ),
                            AutoSizeText(
                              "Remember_me".tr,
                              style: dmsregular.copyWith(
                                fontSize: FontSize.label(context),
                                // fontSize: 12.sp,
                                color: SippoColor.grey,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            Get.focusScope?.unfocus();
                            if (_controller.phoneNumber.trim().isNotEmpty) {
                              Get.toNamed(
                                SippoRoutes.forgetPassword,
                                arguments: {
                                  phoneNumberArg: _controller.phoneNumber
                                },
                              );
                            } else {
                              Get.dialog(
                                CustomAlertDialog(
                                  imageAsset: JobstopPngImg.phonenymberempty,
                                  title: "No_phone_number_title".tr,
                                  description: "enter_phonenumber".tr,
                                ),
                              );
                            }
                          },
                          child: AutoSizeText(
                            "Forget_Password".tr,
                            style: dmsregular.copyWith(
                                fontSize: FontSize.label(context),
                                // fontSize: 12.sp,
                                color: SippoColor.primarycolor),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: context.fromHeight(CustomStyle.spaceBetween),
                    ),
                    CustomButton(
                      text: "Login".tr,
                      backgroundColor: SippoColor.primarycolor,
                      textColor: SippoColor.white,
                      onTapped: () {
                        _controller.onSubmittedLogin();
                      },
                    ),
                    SizedBox(
                      height: context.fromHeight(CustomStyle.spaceBetween),
                    ),
                    Obx(() => ConditionalWidget(
                          _controller.authState.isError,
                          data: _controller.authState,
                          guaranteedBuilder: (context, data) =>
                              CardNotifyMessage.error(
                            state: data,
                            onCancelTap: () => _controller.authController
                                .changeStates(isError: false, message: ''),
                          ),
                        )),
                    SizedBox(
                      height: context.fromHeight(CustomStyle.spaceBetween),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "You_dont_have_an_account_yet".tr,
                          style: dmsregular.copyWith(
                              fontSize: FontSize.title6(context),
                              color: SippoColor.textColor),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.focusScope?.unfocus();
                            Get.offAndToNamed(SippoRoutes.userSignupPage);
                          },
                          child: Text(
                            "Sign_up".tr,
                            style: dmsregular.copyWith(
                                fontSize: height / 65,
                                color: SippoColor.secondary,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: context.fromHeight(CustomStyle.spaceBetween),
                    ),
                    SeparatorLine(text: 'or'.tr),
                    SizedBox(
                      height: context.fromHeight(CustomStyle.spaceBetween),
                    ),
                    CustomButton(
                      onTapped: () {
                        Get.focusScope?.unfocus();
                        _controller.authController.resetStates();
                        Get.offAndToNamed(SippoRoutes.sippoCompanyLogin);
                      },
                      text: "Company_Login".tr,
                      backgroundColor: SippoColor.white,
                      textColor: SippoColor.textColor,
                      borderColor: SippoColor.grey,
                    ),
                    SizedBox(
                      height: height / 52,
                    ),
                    CustomButton(
                      onTapped: () {
                        Get.focusScope?.unfocus();
                        _controller.authController.resetStates();
                        Get.offAllNamed(SippoRoutes.sippoGuest);
                      },
                      text: "Guest_login.".tr,
                      backgroundColor: SippoColor.white,
                      textColor: SippoColor.textColor,
                      borderColor: SippoColor.grey,
                    )
                  ],
                ),
              ),
            ),
          ),
          backgroundColor: SippoColor.white,
        ),
        Obx(
          () => _controller.authState.isLoading
              ? const LoadingOverlay()
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
