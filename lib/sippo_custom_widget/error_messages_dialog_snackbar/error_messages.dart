import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';

import '../widgets.dart';

void showNoConnectionDialog() {
  Get.dialog(
    CustomAlertDialog(
      imageAsset: JobstopPngImg.noconnection,
      title: 'Connection lost',
      description:
          'connection lost, please check your network settings and try again',
      onConfirm: () {
        Get.back();
      },
    ),
  );
}



void invalidOTPSnackbar([String? message]) {
  Get.snackbar(
    "Invalid OTP",
    "Pleas enter the otp code with length 6 number",
    backgroundColor: Colors.redAccent,
  );
}

void failedVerifyOTPSnackbar([String? message]) {
  Get.snackbar(
    "Failed verify OTP",
    message ?? 'no message.',
    backgroundColor: Colors.redAccent,
  );
}

void successVerifyOTPSnackbar([String? message]) {
  Get.snackbar(
    "Success verify OTP",
    "the OTP verifying successfully.",
    backgroundColor: Colors.greenAccent,
  );
}
