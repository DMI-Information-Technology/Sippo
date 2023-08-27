import 'package:flutter/material.dart';
import 'package:jobspot/sippo_pages/Authentication/jopstop_appusing.dart';
import 'package:jobspot/sippo_pages/jopintroductionpages/jobstop_onboarding.dart';
import 'package:jobspot/sippo_pages/sippo_company_pages/sippo_company_dashboard.dart';
import 'package:jobspot/sippo_pages/sippo_user_pages/jobstop_dashboard.dart';
import 'package:jobspot/utils/app_use.dart';
import 'package:jobspot/JobGlobalclass/global_storage.dart';

class WrapperScreen extends StatefulWidget {
  const WrapperScreen({super.key});

  @override
  State<WrapperScreen> createState() => _WrapperScreenState();
}

class _WrapperScreenState extends State<WrapperScreen> {
  Widget dashboardScreens() => GlobalStorage.appUse == AppUsingType.user
      ? const SippoUserDashboard()
      : const SippoCompanyDashboard();

  Widget entryScreen() => GlobalStorage.isAppLunchFirstTime
      ? const SippoOnboarding()
      : const SippoAppUsing();

  @override
  Widget build(BuildContext context) {
    return GlobalStorage.isLogged ? dashboardScreens() : entryScreen();
  }
}
