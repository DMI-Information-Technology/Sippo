import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/global_storage.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/utils/app_use.dart';

import 'JobGlobalclass/jobstopimges.dart';

class WrapperScreen extends StatefulWidget {
  const WrapperScreen({super.key});

  @override
  State<WrapperScreen> createState() => _WrapperScreenState();
}

class _WrapperScreenState extends State<WrapperScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Timer _timer;
  bool _isRotating = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      _isRotating = !_isRotating;
      // });
      if (_isRotating) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
    Future.delayed(
      Duration(seconds: 5),
      () {
        if (kIsWeb) {
          Get.offAllNamed(SippoRoutes.appUsingPage);
          return;
        }
        if (GlobalStorageService.isLogged) {
          dashboardScreens();
        } else {
          entryScreen();
        }
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void dashboardScreens() {
    switch (GlobalStorageService.appUse) {
      case AppUsingType.user:
        Get.offAllNamed(SippoRoutes.userDashboard);
        break;
      case AppUsingType.company:
        Get.offAllNamed(SippoRoutes.sippoCompanyDashboard);
        break;
    }
  }

  void entryScreen() {
    switch (GlobalStorageService.isAppLunchFirstTime) {
      case true:
        Get.offAllNamed(SippoRoutes.onboarding);
        break;
      case false:
        Get.offAllNamed(SippoRoutes.appUsingPage);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // return GlobalStorage.isLogged ? dashboardScreens() : entryScreen();
    return Container(
      height: context.height,
      width: context.width,
      color: Jobstopcolor.secondary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RotationTransition(
            turns: _animationController,
            child: Container(
              height: context.height / 10,
              child: Image.asset(JobstopPngImg.splashlogo),
            ),
          ),
        ],
      ),
    );
  }
}
