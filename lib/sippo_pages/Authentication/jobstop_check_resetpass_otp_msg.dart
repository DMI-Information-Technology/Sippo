import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/sippo_controller/AuthenticationController/sippo_auth_controller.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/utils/helper.dart';

import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/sippo_custom_widget/ConditionalWidget.dart';
import 'package:jobspot/sippo_custom_widget/success_message_widget.dart';

class CheckOTPResetPasswordMessage extends StatefulWidget {
  const CheckOTPResetPasswordMessage({Key? key}) : super(key: key);

  @override
  State<CheckOTPResetPasswordMessage> createState() =>
      _CheckOTPResetPasswordMessageState();
}

class _CheckOTPResetPasswordMessageState
    extends State<CheckOTPResetPasswordMessage> {
  bool _onEditing = false;
  // String _code = "";/
  dynamic size;
  double height = 0.00;
  double width = 0.00;

  Timer? _timer;
  final authController = AuthController.instance;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() async {
    _timer = await startTimer(authController.seconds, (value) {
      print(authController.seconds);
      authController.seconds = value;
    });
  }

  @override
  void dispose() {
    if (_timer?.isActive == true) _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "OTP_CODE_TITLE".tr,
          style: dmsbold.copyWith(fontSize: height / 52),
        ),
      ),
      body: BodyWidget(
        isScrollable: true,
        paddingContent: EdgeInsets.symmetric(horizontal: width / 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: context.fromHeight(4),
            ),
            Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                style: dmsmedium.copyWith(
                  fontSize: FontSize.title5(context),
                ),
                text: 'Code has been sent to\n',
                children: [
                  TextSpan(
                    text: authController.resetEmail.text,
                    style: dmsbold.copyWith(
                      color: SippoColor.primarycolor,
                      fontSize: FontSize.title4(context),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height / 32,
            ),
            Center(
              child: VerificationCode(
                textStyle: dmsregular.copyWith(
                    fontSize: height / 28, color: SippoColor.textColor),
                keyboardType: TextInputType.number,
                underlineColor: SippoColor.primarycolor,
                length: 6,
                fillColor: Colors.grey[200],
                cursorColor: SippoColor.primarycolor,
                itemSize: width / 8,
                digitsOnly: true,
                fullBorder: true,
                clearAll: Padding(
                  padding: EdgeInsets.all(
                    context.fromWidth(CustomStyle.paddingValue),
                  ),
                  child: Icon(Icons.clear),
                ),
                onCompleted: (String value) {
                  // setState(() {
                  authController.otpCode = value;
                  // });
                },
                onEditing: (bool value) {
                  _onEditing = value;
                  if (!_onEditing) FocusScope.of(context).unfocus();
                },
              ),
            ),
            SizedBox(
              height: context.fromHeight(CustomStyle.spaceBetween),
            ),
            Obx(() => ConditionalWidget(
                  authController.states.isLoading,
                  isLoading: authController.states.isLoading,
                  avoidBuilder: (context, _) =>
                      _buildResendButtonTimerRow(context),
                )),
            Obx(() => ConditionalWidget(
                  authController.states.isError,
                  data: authController.states,
                  guaranteedBuilder: (context, data) => CardNotifyMessage.error(
                    state: data,
                    onCancelTap: () => authController.resetStates(),
                  ),
                )),
            SizedBox(
              height: context.fromHeight(CustomStyle.spaceBetween),
            ),
          ],
        ),
        paddingBottom: EdgeInsets.all(width / 32),
        bottomScreen: CustomButton(
          onTapped: () {
            if (InternetConnectionService.instance.isNotConnected) return;
            if (authController.states.isLoading) return;
            authController.confirmOtpCode().then((_) {
              if (authController.states.isSuccess) {
                authController.resetStates();
                _timer?.cancel();
                Get.toNamed(SippoRoutes.updateNewPassword);
              }
            });
          },
          text: "send_otp_code".tr,
        ),
      ),
    );
  }

  Widget _buildResendButtonTimerRow(BuildContext context) {
    return Obx(() {
      final seconds = authController.seconds;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (seconds > 0) ...[
            Text(
              "Resend code in",
              style: dmsregular.copyWith(
                fontSize: height / 52,
              ),
            ),
            SizedBox(
              width: width / 25,
            ),
            Text(
              seconds.toString(),
              style: dmsbold.copyWith(
                fontSize: height / 52,
                color: SippoColor.primarycolor,
              ),
            ),
          ],
          if (seconds == 0)
            TextButton(
              onPressed: () async {
                if (InternetConnectionService.instance.isNotConnected) return;
                if (authController.states.isLoading) return;
                await authController.forgetPassword();
                if (authController.states.isSuccess) {
                  authController.seconds = 60;
                  _startTimer();
                } else {
                  Get.snackbar(
                    'Reset Password',
                    'You cannot reset the password now. Please try again later',
                    boxShadows: [boxShadow],
                    backgroundColor: Colors.grey[300],
                  );
                }
                authController.resetStates();
              },
              child: Text(
                "resend",
                style: dmsbold.copyWith(
                  fontSize: height / 52,
                  color: SippoColor.primarycolor,
                ),
              ),
            )
        ],
      );
    });
  }
}
