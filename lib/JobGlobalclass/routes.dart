import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:jobspot/Jobstoppages/Authentication/jobstop_signup.dart';

import '../Jobstoppages/Authentication/jobstop_login.dart';
import '../Jobstoppages/Authentication/jobstop_splash.dart';
import '../Jobstoppages/Authentication/jopstop_appusing.dart';
import '../Jobstoppages/Authentication/jovstop_successful.dart';
import '../Jobstoppages/Jobhomepages/jobstop_dashboard.dart';

class JopRoutesPages {
  static String _homepage = "/";
  static String _loginpage = "/log-in";
  static String _signuppage = "/sign-up";
  static String _dashboard = "/dashboard";
  static String _appusing = "/appusing";
  static String _successful = "/successful";

  static String getHomepageRoute() => _homepage;



  static List<GetPage> routes = [
    GetPage(name: _homepage, page: () => const JobstopSplash()),
    GetPage(name: _loginpage, page: () => const JobstopLogin()),
    GetPage(name: _signuppage, page: () => const JobstopSignup()),
    GetPage(name: _dashboard, page: () => const JobDashboard()),
    GetPage(name: _appusing, page: () => const JopAppUsing()),
    GetPage(name: _successful, page: () => const JobstopSuccessful()),
  ];

  static String get homepage => _homepage;
  static String get dashboard => _dashboard;
  static String get signuppage => _signuppage;
  static String get loginpage => _loginpage;
  static String get appusingpage => _appusing;
  static String get successful => _successful;
}
