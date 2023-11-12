import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/global_storage.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/sippo_custom_widget/error_messages_dialog_snackbar/error_messages.dart';

class ExceptionHandlerUtils {
  static var socketExceptionCounter = 0;

  static void onError(FlutterErrorDetails errorDetails) {
    final exception = errorDetails.exception;
    print("hello");
    switch (exception) {
      case SocketException():
        _onSocketExceptionError(exception, errorDetails.stack);
    }
  }

  static void _onSocketExceptionError(SocketException e, StackTrace? s) {
    print(e);
    print(s);
    if (!GlobalStorageService.isLogged) {
      showNoConnectionDialog();
      return;
    }
    if (socketExceptionCounter >= 3) {
      socketExceptionCounter = 0;
      return;
    }
    Get.snackbar(
      icon: Icon(Icons.signal_wifi_statusbar_connected_no_internet_4_rounded),
      'Network connection',
      'The network connection is unstable. Please checked and try again.',
      backgroundColor: SippoColor.backgroudHome,
      boxShadows: [boxShadow],
    );
    socketExceptionCounter++;
  }
}
