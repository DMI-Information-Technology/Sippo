import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jobspot/JopController/AuthenticationController/sippo_signup_company_controller.dart';
import '../../JobGlobalclass/jobstopcolor.dart';
import '../../JobGlobalclass/jobstopfontstyle.dart';
import '../../JobGlobalclass/jobstopimges.dart';
import '../../JobGlobalclass/routes.dart';
import '../../JobThemes/themecontroller.dart';
import '../../JopController/AuthenticationController/firebase_auth_service_controller.dart';
import '../../JopController/AuthenticationController/identity_verification_controller.dart';
import '../../JopController/AuthenticationController/sippo_auth_controller.dart';
import '../../JopCustomWidget/overly_loading.dart';
import '../../JopCustomWidget/widgets.dart';
import '../../utils/helper.dart' as helper;

class SippoCompanyIdentityVerification extends StatefulWidget {
  const SippoCompanyIdentityVerification({super.key});

  @override
  State<SippoCompanyIdentityVerification> createState() =>
      _SippoCompanyIdentityVerificationState();
}

class _SippoCompanyIdentityVerificationState
    extends State<SippoCompanyIdentityVerification> {
  TextEditingController secretCode = TextEditingController();
  final themedata = Get.put(JobstopThemecontroler());

  final _signUpCompanyController = SignUpCompanyController.instance;
  final _authController = AuthController.instance;
  final _verifyController = Get.put(IdentityVerificationController());
  final _firebaseOTP = Get.put(FirebaseAuthServiceController());
  @override
  void initState() {
    _firebaseOTP.timer = Timer(
      Duration(seconds: 5),
      () async {
        await _verifyPhoneNumber();
      },
    );

    super.initState();
  }

  Future<void> _verifyPhoneNumber() async {
    // final phoneNumber = "+" + _signUpCompanyController.phoneNumber;
    final phoneNumber = "+218922698540";
    final bool? isCalled =
        await _firebaseOTP.phoneAuthentication(phoneNumber, secondDuration: 30);
    if (isCalled == true) await _verifyController.resendOTPCodeTimer();
  }

  void _showSuccessAlert() {
    Get.dialog(
      CustomAlertDialog(
        imageAsset: JobstopPngImg.successful1,
        title: "Success",
        description:
            "the account has been created successfully want continue to dashboard",
        confirmBtnColor: Jobstopcolor.primarycolor,
        confirmBtnTitle: "ok".tr,
        onConfirm: () =>
            Get.offAllNamed(SippoRoutesPages.sippoCompanyDashboard),
      ),
    ).then((value) => Get.offAllNamed(SippoRoutesPages.sippoCompanyDashboard));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text(
              "identity_verification".tr,
              style: dmsbold.copyWith(fontSize: height / 52),
              textAlign: TextAlign.start,
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width / 26,
                      vertical: height / 46,
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          JobstopPngImg.passwordimg,
                          height: height / 3,
                        ),
                        SizedBox(height: height / 18),
                        Obx(
                          () => PhoneResetPasswordCard(
                            phoneNumber: helper.otpPhoneNumberFormat(
                              _signUpCompanyController.phoneNumber,
                            ),
                            description:
                                'Secret code message will be sent after ${_verifyController.initTimer}',
                            borderColor: Jobstopcolor.primarycolor,
                          ),
                        ),
                        SizedBox(height: height / 18),
                        InputField(
                          controller: secretCode,
                          hintText: "Secret_code_hint_text".tr,
                          icon: const Icon(Icons.lock_outline),
                          onChangedText: (value) =>
                              _verifyController.otpCode = value.trim(),
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Obx(
                            () => TextButton(
                              onPressed: _resendOTPClicked,
                              child: Text(
                                "resend ${_verifyController.isResendTimerNotFinish() ? "after " + _verifyController.resendTimer.toString() : ""}",
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: height / 18),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.all(height / 50),
                  child: CustomButton(
                    onTappeed: _onSubmitSend,
                    text: "send".tr,
                  ),
                ),
              ),
            ],
          ),
        ),
        Obx(
          () =>
              _firebaseOTP.states.isLoading || _authController.states.isLoading
                  ? const LoadingOverlay()
                  : const SizedBox.shrink(),
        ),
      ],
    );
  }

  void _resendOTPClicked() async {
    if (_verifyController.isAllTimerFinish()) {
      await _verifyPhoneNumber();
    }
  }

  void _onSubmitSend() async {
    final isValidOTP = _verifyController.isValidOTP;
    if (isValidOTP) {
      await _firebaseOTP.verifyOTP(secretCode.text.trim());
      if (_firebaseOTP.states.isSuccess) {
        print(_signUpCompanyController.companyForm);
        _successVerifyOTPSnackbar();
        await _authController.companyRegister(
          _signUpCompanyController.companyForm,
        );
        if (_authController.states.isSuccess) _showSuccessAlert();
      } else {
        _failedVerifyOTPSnackbar();
      }
    } else {
      _invalidOTPSnackbar();
    }
  }

  void _invalidOTPSnackbar() {
    Get.snackbar(
      "Invalid OTP",
      "Pleas enter the otp code with length 6 number",
      backgroundColor: Colors.redAccent,
    );
  }

  void _failedVerifyOTPSnackbar() {
    Get.snackbar(
      "Failed verify OTP",
      _firebaseOTP.states.message.toString(),
      backgroundColor: Colors.redAccent,
    );
  }

  void _successVerifyOTPSnackbar() {
    Get.snackbar(
      "Success verify OTP",
      "the OTP verifying successfully.",
      backgroundColor: Colors.greenAccent,
    );
  }
}
