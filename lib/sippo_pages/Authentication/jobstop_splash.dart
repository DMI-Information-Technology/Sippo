import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/global_storage.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/utils/app_use.dart';

class SippoSplash extends StatefulWidget {
  const SippoSplash({Key? key}) : super(key: key);

  @override
  State<SippoSplash> createState() => _SippoSplashState();
}

class _SippoSplashState extends State<SippoSplash> {
  String _dashboardScreens() => switch (GlobalStorageService.appUse) {
        AppUsingType.user => SippoRoutes.userDashboard,
        AppUsingType.company => SippoRoutes.sippoCompanyDashboard
      };

  String _entryScreen() => switch (GlobalStorageService.isAppLunchFirstTime) {
        true => SippoRoutes.onboarding,
        false => SippoRoutes.appUsingPage
      };

  Future<String> createRoute() async {
    if (kIsWeb) {
      return SippoRoutes.appUsingPage;
    }
    if (GlobalStorageService.isLogged) {
      return _dashboardScreens();
    } else {
      return _entryScreen();
    }
  }
@override
  void initState() {
    super.initState();
    Get.focusScope?.unfocus();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return AnimatedSplashScreen.withScreenRouteFunction(
      curve: Curves.easeIn,
      splashTransition: SplashTransition.sizeTransition,
      backgroundColor: Jobstopcolor.secondary,
      splash: Image.asset(
        JobstopPngImg.splashlogo,
        fit: BoxFit.fitHeight,
        height: height / 10,
      ),
      disableNavigation: true,
      screenRouteFunction: createRoute,
    );
  }
}
