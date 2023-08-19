import 'package:get/get_navigation/src/routes/get_route.dart';

import '../sippo_pages/Authentication/jobstop_check_resetpass_otp_msg.dart';
import '../sippo_pages/Authentication/jobstop_companyspecializations_signup.dart';
import '../sippo_pages/Authentication/jobstop_forget.dart';
import '../sippo_pages/Authentication/jobstop_splash.dart';
import '../sippo_pages/Authentication/jopstop_appusing.dart';
import '../sippo_pages/Authentication/jopstop_newpasword.dart';
import '../sippo_pages/Authentication/sippo_company_identity_verification.dart';
import '../sippo_pages/Authentication/sippo_company_login.dart';
import '../sippo_pages/Authentication/sippo_company_signup.dart';
import '../sippo_pages/Authentication/sippo_selecte_company_location.dart';
import '../sippo_pages/Authentication/sippo_user_login.dart';
import '../sippo_pages/Authentication/sippo_user_signup.dart';
import '../sippo_pages/sippo_company_pages/sippo_company_dashboard.dart';
import '../sippo_pages/sippo_company_pages/sippo_company_profile.dart';
import '../sippo_pages/sippo_user_pages/edit_add_user_profile_info/job_add_edit_appreciation.dart';
import '../sippo_pages/sippo_user_pages/edit_add_user_profile_info/job_add_edit_education.dart';
import '../sippo_pages/sippo_user_pages/edit_add_user_profile_info/job_add_edit_language.dart';
import '../sippo_pages/sippo_user_pages/edit_add_user_profile_info/jobstop_add_edit_skills.dart';
import '../sippo_pages/sippo_user_pages/job_editprofile.dart';
import '../sippo_pages/sippo_user_pages/job_experience.dart';
import '../sippo_pages/sippo_user_pages/jobstop_dashboard.dart';
import '../sippo_pages/sippo_user_pages/jobstop_profile.dart';
import '../sippo_pages/sippo_user_pages/jobstop_search.dart';
import '../sippo_pages/sippo_user_pages/jobstop_upload_resume.dart';
import '../sippo_pages/sippo_user_pages/sippo_profile_setting.dart';

class SippoRoutesPages {
  static const String _homepage = "/";
  static const String _loginpage = "/log-in";
  static const String _signuppage = "/sign-up";
  static const String _userdashboard = "/user-dashboard";
  static const String _appusing = "/app-using";
  static const String _forgetpassword = "/forget-password";
  static const String _updatenewpassword = "/update-new-password";
  static const String _edituserprofile = "/edit-user-profile";

  static const String _jobSearch = "/jobSearch";
  static const String _sippoprofile = "/sippo-profile";
  static const String _workexperience = "/work-experience";
  static const String _educationaddedit = "/education-add-edit";
  static const String _appreciationaddedit = "/appreciation-add-edit";
  static const String _languageeditadd = "/language-add-edit";
  static const String _uploadresume = "/upload-resume";
  static const String _sippoprofilesetting = "/sippo-profile-setting";

  static String get sippoprofilesetting => _sippoprofilesetting;

  static String get edituserprofile => _edituserprofile;

  static String get uploadresume => _uploadresume;
  static const String _skillsaddedit = "/skills-add-edit";

  static String get skillsaddedit => _skillsaddedit;

  static String get languageeditadd => _languageeditadd;

  static String get appreciationaddedit => _appreciationaddedit;

  static String get educationaddedit => _educationaddedit;

  static String get workexperience => _workexperience;

  static String get locationselector => _locationselector;
  static const String _companysignupspecializations =
      "/company-signup-specializations";

  static const String _otpresetpassmsgpage = "/reset-pass-otp";

  static String get userdashboard => _userdashboard;

  static String get signuppage => _signuppage;

  static String get loginpage => _loginpage;

  static String get appusingpage => _appusing;

  static String get identityverification => _identityverification;

  static String get forgetpasswordpage => _forgetpassword;

  static String get otpresetpassmsgpage => _otpresetpassmsgpage;

  static String get homepage => _homepage;


  static String get companysignup => _companysignup;

  static String get updatenewpassword => _updatenewpassword;

  static String get sippoprofile => _sippoprofile;

  static List<GetPage> routes = [
    GetPage(name: _homepage, page: () => const JobstopSplash()),
    GetPage(name: _loginpage, page: () => const SippoUserLogin()),
    GetPage(name: _signuppage, page: () => const SippoUserSignup()),
    GetPage(name: _userdashboard, page: () => const SippoUserDashboard()),
    GetPage(name: _appusing, page: () => const JopAppUsing()),
    GetPage(name: _forgetpassword, page: () => const JobstopForget()),
    GetPage(name: _companylogin, page: () => const SippoCompanyLogin()),
    GetPage(name: _locationselector, page: () => const SippoLocationCompanySelector()),
    GetPage(name: _edituserprofile, page: () => const EditUserProfilePage()),
    GetPage(name: _sippoprofile, page: () => const SippoUserProfile()),
    GetPage(name: _workexperience, page: () => const JobExperiences()),
    GetPage(name: _educationaddedit, page: () => const JobEducationAddEdit()),
    GetPage(name: _languageeditadd, page: () => const LanguageEditAdd()),
    GetPage(name: _skillsaddedit, page: () => const JobSkillsAddEdit()),
    GetPage(name: _uploadresume, page: () => const JobUploadResume()),
    GetPage(
        name: _sippocompanyprofile, page: () => const SippoCompanyProfile()),
    GetPage(
        name: _appreciationaddedit, page: () => const JobAppreciationAddEdit()),
    GetPage(
        name: _companysignupspecializations,
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
      page: () => const SippoCompanyIdentityVerification(),
    ),
    GetPage(
      name: _companysignup,
      page: () => const SippoCompanySignup(),
    ),
    GetPage(
      name: _jobSearch,
      page: () => const JobSearch(),
    ),
    GetPage(
      name: _sippocompanydashboard,
      page: () => const SippoCompanyDashboard(),
    ),
    GetPage(
      name: _sippoprofilesetting,
      page: () => const SippoProfileSetting(),
    ),
  ];

  // company
  static const String _sippocompanydashboard = "/sippo-company-dashboard";
  static const String _sippocompanyprofile = "/sippo-company-profile";
  static const String _identityverification = "/identity-verification";
  static const String _companysignup = "/company-signup";
  static const String _companylogin = "/company-login";
  static const String _locationselector = "/location-selector";

  static String get sippocompanyprofile => _sippocompanyprofile;

  static String get sippoCompanyDashboard => _sippocompanydashboard;

  static String get sippoCompanyLogin => _companylogin;

  static String get companysignupspecializations =>
      _companysignupspecializations;
}
