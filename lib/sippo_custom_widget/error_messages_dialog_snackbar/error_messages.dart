import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';

import '../../JobGlobalclass/jobstopcolor.dart';
import '../../JobGlobalclass/sippo_customstyle.dart';
import '../widgets.dart';

void showNoConnectionSnackbar() {
  Get.snackbar(
    icon: Icon(Icons.signal_wifi_statusbar_connected_no_internet_4_rounded),
    'No Connection',
    'Your connection is lost, please check your connection and try again',
    backgroundColor: Jobstopcolor.backgroudHome,
    boxShadows: [boxShadow],
  );
}

void showNoConnectionDialog() {
  Get.dialog(
    CustomAlertDialog(
      imageAsset: JobstopPngImg.noconnection,
      title: 'Connection lost',
      description:
          'connection lost, please check your network settings and try again',
      onConfirm: () {
        final context = Get.overlayContext;
        if (context != null) {
          Navigator.pop(context);
        } else {
          try {
            Get.back();
          } catch (e, s) {
            print(e);
            print(s);
          }
        }
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
