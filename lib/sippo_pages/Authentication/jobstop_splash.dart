import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sippo/JobGlobalclass/global_storage.dart';
import 'package:sippo/JobGlobalclass/routes.dart';
import 'package:sippo/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:sippo/utils/app_use.dart';

import '../../sippo_custom_widget/widgets.dart';

class SippoSplash extends StatefulWidget {
  const SippoSplash({Key? key}) : super(key: key);

  @override
  State<SippoSplash> createState() => _SippoSplashState();
}

class _SippoSplashState extends State<SippoSplash> {
  int _alertCounter = 0;

  String _dashboardScreens() => switch (GlobalStorageService.appUse) {
    AppUsingType.user => SippoRoutes.userDashboard,
    AppUsingType.company => SippoRoutes.sippoCompanyDashboard,
    AppUsingType.guest => '',
  };

  String _entryScreen() => switch (GlobalStorageService.isAppLunchFirstTime) {
    true => SippoRoutes.onboarding,
    false => SippoRoutes.appUsingPage
  };

  Future<void> goToRoute() async {
    // Wait for 4 seconds before checking internet connection and routing
    await Future.delayed(Duration(seconds: 4));

    Future.doWhile(() async {
      if (_alertCounter >= 3) {
        await Get.dialog(
          CustomAlertDialog.verticalButtons(
            title: 'no_connection_title'.tr,
            description: 'no_connection_message'.tr,
            onConfirm: () => Get.back(),
          ),
        );
        _alertCounter = 0;
      }
      final result = await InternetConnectionService.getSignalStrength();
      _alertCounter++;
      print("==============================");
      print("**** Signal Strength is: $result *****");
      print("==============================");
      return !(result > 0.0);
    }).then((_) {
      if (kIsWeb) {
        Get.offAllNamed(SippoRoutes.appUsingPage);
      }
      if (GlobalStorageService.isLogged) {
        Get.offAllNamed(_dashboardScreens());
      } else {
        Get.offAllNamed(_entryScreen());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Get.focusScope?.unfocus();
    goToRoute();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Adjust background color as needed
      body: Center(
        child: Lottie.asset('Assets/jobstop_assets/json_animation/splash1.json', repeat: false),
      ),
    );
  }
}