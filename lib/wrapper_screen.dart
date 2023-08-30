import 'dart:async';

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
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _timer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
      _isRotating = !_isRotating;
      // });
      if (_isRotating) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
    Future.delayed(
      Duration(seconds: 2),
      () {
        if (GlobalStorage.isLogged) {
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
    switch (GlobalStorage.appUse) {
      case AppUsingType.user:
        Get.offAllNamed(SippoRoutes.userdashboard);
        break;
      case AppUsingType.company:
        Get.offAllNamed(SippoRoutes.sippoCompanyDashboard);
        break;
    }
  }

  void entryScreen() {
    switch (GlobalStorage.isAppLunchFirstTime) {
      case true:
        Get.offAllNamed(SippoRoutes.onboarding);
        break;
      case false:
        Get.offAllNamed(SippoRoutes.appusingpage);
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
