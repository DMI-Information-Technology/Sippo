import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';

import '../../JobGlobalclass/routes.dart';
import '../../sippo_custom_widget/body_widget.dart';
import '../../sippo_themes/themecontroller.dart';
import '../../utils/helper.dart';

class CheckOTPResetPasswordMessage extends StatefulWidget {
  const CheckOTPResetPasswordMessage({Key? key}) : super(key: key);

  @override
  State<CheckOTPResetPasswordMessage> createState() =>
      _CheckOTPResetPasswordMessageState();
}

class _CheckOTPResetPasswordMessageState
    extends State<CheckOTPResetPasswordMessage> {
  bool _onEditing = false;
  String _code = "";
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  TextEditingController email = TextEditingController();
  final themedata = Get.put(JobstopThemecontroler());
  Timer? _timer;
  int _seconds = 60;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() async {
    _timer = await startTimer(_seconds, (value) => _seconds = value);
  }

  @override
  void dispose() {
    _timer?.cancel();
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
          children: [
            SizedBox(
              height: height / 6,
            ),
            Text(
              "Code has been sent to\n+92 - 26*********0",
              style: dmsmedium.copyWith(
                fontSize: height / 52,
                color: Jobstopcolor.textColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: height / 16,
            ),
            Center(
              child: VerificationCode(
                textStyle: dmsregular.copyWith(
                    fontSize: height / 28, color: Jobstopcolor.textColor),
                keyboardType: TextInputType.number,
                underlineColor: Jobstopcolor.primarycolor,
                length: 4,
                fillColor: Colors.grey[200],
                cursorColor: Jobstopcolor.primarycolor,
                itemSize: height / 12,
                digitsOnly: true,
                fullBorder: true,
                onCompleted: (String value) {
                  setState(() {
                    _code = value;
                  });
                },
                onEditing: (bool value) {
                  setState(() {
                    _onEditing = value;
                  });
                  if (!_onEditing) FocusScope.of(context).unfocus();
                },
              ),
            ),
            SizedBox(
              height: height / 20,
            ),
            _buildResendButtonTimerRow(),
          ],
        ),
        paddingBottom: EdgeInsets.all(width / 32),
        bottomScreen: CustomButton(
          onTapped: () {
            Get.toNamed(SippoRoutes.updatenewpassword);
          },
          text: "Confirm",
        ),
      ),
    );
  }

  Row _buildResendButtonTimerRow() {
    return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_seconds > 0) ...[
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
                  _seconds.toString(),
                  style: dmsbold.copyWith(
                    fontSize: height / 52,
                    color: Jobstopcolor.primarycolor,
                  ),
                ),
              ],
              if (_seconds == 0)
                TextButton(
                  onPressed: () {
                    _seconds = 60;
                    _startTimer();
                  },
                  child: Text(
                    "resend",
                    style: dmsbold.copyWith(
                      fontSize: height / 52,
                      color: Jobstopcolor.primarycolor,
                    ),
                  ),
                )
            ],
          );
  }
}
