import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:jobspot/Jobstoppages/Authentication/jobstop_company_login.dart';
import 'package:jobspot/Jobstoppages/Authentication/jobstop_selecte_location.dart';
import 'package:jobspot/Jobstoppages/Authentication/jobstop_signup.dart';
import 'package:jobspot/Jobstoppages/Authentication/jopstop_newpasword.dart';
import 'package:jobspot/Jobstoppages/Jobhomepages/job_add_edit_appreciation.dart';

import '../Jobstoppages/Authentication/jobstop_check_resetpass_otp_msg.dart';
import '../Jobstoppages/Authentication/jobstop_company_signup.dart';
import '../Jobstoppages/Authentication/jobstop_companyspecializations_signup.dart';
import '../Jobstoppages/Authentication/jobstop_forget.dart';
import '../Jobstoppages/Authentication/jobstop_identity_verification.dart';
import '../Jobstoppages/Authentication/jobstop_login.dart';
import '../Jobstoppages/Authentication/jobstop_splash.dart';
import '../Jobstoppages/Authentication/jopstop_appusing.dart';

import '../Jobstoppages/Jobhomepages/job_add_edit_education.dart';
import '../Jobstoppages/Jobhomepages/job_add_edit_language.dart';
import '../Jobstoppages/Jobhomepages/job_experience.dart';
import '../Jobstoppages/Jobhomepages/jobstop_add_edit_skills.dart';
import '../Jobstoppages/Jobhomepages/jobstop_dashboard.dart';
import '../Jobstoppages/Jobhomepages/jobstop_profile.dart';
import '../Jobstoppages/Jobhomepages/jobstop_search.dart';

class JopRoutesPages {
  static const String _homepage = "/";
  static const String _loginpage = "/log-in";
  static const String _signuppage = "/sign-up";
  static const String _dashboard = "/dashboard";
  static const String _appusing = "/appusing";
  static const String _forgetpassword = "/forgetpassword";
  static const String _updatenewpassword = "/updatenewpassword";
  static const String _identityverification = "/identityverification";
  static const String _companysignup = "/companysignup";
  static const String _companylogin = "/companylogin";
  static const String _locationselector = "/locationselector";
  static const String _jobSearch = "/jobSearch";
  static const String _jobstopprofile = "/jobstopprofile";
  static const String _workexperience = "/workexperience";
  static const String _educationaddedit = "/educationaddedit";
  static const String _appreciationaddedit = "/appreciationaddedit";
  static const String _languageeditadd = "/languageeditadd";
  static const String _skillsaddedit = "/skillsaddedit";

  static String get skillsaddedit => _skillsaddedit;

  static String get languageeditadd => _languageeditadd;

  static String get appreciationaddedit => _appreciationaddedit;

  static String get educationaddedit => _educationaddedit;

  static String get workexperience => _workexperience;

  static String get locationselector => _locationselector;
  static const String _ompanysignupspecializations =
      "/ompanysignupspecializations";

  static const String _otpresetpassmsgpage = "/resetpassotp";

  static List<GetPage> routes = [
    GetPage(name: _homepage, page: () => const JobstopSplash()),
    GetPage(name: _loginpage, page: () => const JobstopLogin()),
    GetPage(name: _signuppage, page: () => const JobstopSignup()),
    GetPage(name: _dashboard, page: () => const JobDashboard()),
    GetPage(name: _appusing, page: () => const JopAppUsing()),
    GetPage(name: _forgetpassword, page: () => const JobstopForget()),
    GetPage(name: _companylogin, page: () => const CompanyLogin()),
    GetPage(name: _locationselector, page: () => const LocationSelector()),
    GetPage(name: _jobstopprofile, page: () => const JobstopProfile()),
    GetPage(name: _workexperience, page: () => const JobExperiences()),
    GetPage(name: _educationaddedit, page: () => const JobEducationAddEdit()),
    GetPage(name: _languageeditadd, page: () => const LanguageEditAdd()),
    GetPage(name: _skillsaddedit, page: () => const JobSkillsAddEdit()),
    GetPage(
        name: _appreciationaddedit, page: () => const JobAppreciationAddEdit()),
    GetPage(
        name: _ompanysignupspecializations,
        page: () => const CompanySignUpSpecializations()),
    GetPage(
      name: _updatenewpassword,
      page: () => const UpdatePasswordAfterVerification(),
    ),
    GetPage(
      name: _otpresetpassmsgpage,
      page: () => const CheckOTPResetPasswordMessage(),
    ),
    GetPage(
      name: _identityverification,
      page: () => const IdentityVerification(),
    ),
    GetPage(
      name: _companysignup,
      page: () => const JobstopCompanySignup(),
    ),
    GetPage(
      name: _jobSearch,
      page: () => const JobSearch(),
    ),
  ];

  static String get dashboard => _dashboard;

  static String get signuppage => _signuppage;

  static String get loginpage => _loginpage;

  static String get appusingpage => _appusing;

  static String get identityverification => _identityverification;

  static String get forgetpasswordpage => _forgetpassword;

  static String get otpresetpassmsgpage => _otpresetpassmsgpage;

  static String get homepage => _homepage;

  static String get companylogin => _companylogin;

  static String get ompanysignupspecializations => _ompanysignupspecializations;

  static String get companysignup => _companysignup;

  static String get updatenewpassword => _updatenewpassword;

  static String get jobstopprofile => _jobstopprofile;
}
