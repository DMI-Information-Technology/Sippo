import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/sippo_pages/Authentication/sippo_user_signup.dart';
import 'package:jobspot/sippo_pages/jopintroductionpages/jobstop_onboarding.dart';
import 'package:jobspot/sippo_pages/sippo_company_pages/sippo_company_dashboard.dart';
import 'package:jobspot/sippo_pages/sippo_user_pages/jobstop_dashboard.dart';
import 'package:jobspot/utils/app_use.dart';
import 'package:jobspot/JobGlobalclass/global_storage.dart';
import 'JopController/AuthenticationController/sippo_auth_controller.dart';

class WrapperScreen extends StatefulWidget {
  const WrapperScreen({super.key});

  @override
  State<WrapperScreen> createState() => _WrapperScreenState();
}

class _WrapperScreenState extends State<WrapperScreen> {
  final Map<AppUsingType, StatefulWidget> dashboardScreens = {
    AppUsingType.user: const SippoUserDashboard(),
    AppUsingType.company: const SippoCompanyDashboard()
  };

  final entryPage = [const JobOnboarding(), const SippoUserSignup()];

  final AuthController authController = Get.put(AuthController());

  final firstTime = GlobalStorage.isAppLunchFirstTime ? 0 : 1;

  @override
  Widget build(BuildContext context) {
    return GlobalStorage.isLogged
        ? dashboardScreens[GlobalStorage.appUse] ?? entryPage[firstTime]
        : entryPage[firstTime];
  }
}
