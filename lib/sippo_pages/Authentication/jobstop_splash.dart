import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jobspot/JobGlobalclass/global_storage.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/utils/app_use.dart';

class JobstopSplash extends StatefulWidget {
  const JobstopSplash({Key? key}) : super(key: key);

  @override
  State<JobstopSplash> createState() => _JobstopSplashState();
}

class _JobstopSplashState extends State<JobstopSplash> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;

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
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
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
