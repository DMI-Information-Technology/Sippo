import 'package:get/get.dart';
import 'package:jobspot/SippoControllerBinding/auth_binding/identity_verification_controller_binding.dart';
import 'package:jobspot/SippoControllerBinding/auth_binding/login_company_binding_controller.dart';
import 'package:jobspot/SippoControllerBinding/auth_binding/login_user_binding_controller.dart';
import 'package:jobspot/SippoControllerBinding/auth_binding/signup_company_binding_controller.dart';
import 'package:jobspot/SippoControllerBinding/auth_binding/signup_user_binding_controller.dart';
import 'package:jobspot/SippoControllerBinding/company_binding/company_job_controller_binding.dart';
import 'package:jobspot/SippoControllerBinding/company_binding/company_post_controller_binding.dart';
import 'package:jobspot/SippoControllerBinding/company_binding/company_profile_controller_binding.dart';
import 'package:jobspot/SippoControllerBinding/dashboard_binding/company_dashbord_controller_binding.dart';
import 'package:jobspot/SippoControllerBinding/dashboard_binding/user_dashboard_controller_binding.dart';
import 'package:jobspot/SippoControllerBinding/profile_binding/edit_add_education_controller_binding.dart';
import 'package:jobspot/SippoControllerBinding/profile_binding/edit_add_skills_controller_binding.dart';
import 'package:jobspot/SippoControllerBinding/profile_binding/edit_add_work_experience_controller_binding.dart';
import 'package:jobspot/SippoControllerBinding/profile_binding/user_profile_controller_binding.dart';
import 'package:jobspot/sippo_pages/Authentication/jobstop_check_resetpass_otp_msg.dart';
import 'package:jobspot/sippo_pages/Authentication/jobstop_companyspecializations_signup.dart';
import 'package:jobspot/sippo_pages/Authentication/jobstop_forget.dart';
import 'package:jobspot/sippo_pages/Authentication/jobstop_splash.dart';
import 'package:jobspot/sippo_pages/Authentication/jopstop_appusing.dart';
import 'package:jobspot/sippo_pages/Authentication/jopstop_newpasword.dart';
import 'package:jobspot/sippo_pages/Authentication/sippo_company_identity_verification.dart';
import 'package:jobspot/sippo_pages/Authentication/sippo_company_login.dart';
import 'package:jobspot/sippo_pages/Authentication/sippo_company_signup.dart';
import 'package:jobspot/sippo_pages/Authentication/sippo_selecte_company_location.dart';
import 'package:jobspot/sippo_pages/Authentication/sippo_user_login.dart';
import 'package:jobspot/sippo_pages/Authentication/sippo_user_signup.dart';
import 'package:jobspot/sippo_pages/jopintroductionpages/jobstop_onboarding.dart';
import 'package:jobspot/sippo_pages/setting_profile/sippo_profile_setting.dart';
import 'package:jobspot/sippo_pages/sippo_company_pages/company_post_and_jobs/sippo_company_edit_add_jobs.dart';
import 'package:jobspot/sippo_pages/sippo_company_pages/company_post_and_jobs/sippo_company_edit_add_post.dart';
import 'package:jobspot/sippo_pages/sippo_company_pages/sippo_company_dashboard.dart';
import 'package:jobspot/sippo_pages/sippo_company_pages/sippo_company_profile.dart';
import 'package:jobspot/sippo_pages/sippo_company_pages/sippo_edit_company_profile.dart';
import 'package:jobspot/sippo_pages/sippo_user_pages/edit_add_user_profile_info/job_add_edit_appreciation.dart';
import 'package:jobspot/sippo_pages/sippo_user_pages/edit_add_user_profile_info/job_add_edit_education.dart';
import 'package:jobspot/sippo_pages/sippo_user_pages/edit_add_user_profile_info/job_add_edit_language.dart';
import 'package:jobspot/sippo_pages/sippo_user_pages/edit_add_user_profile_info/job_add_language_user.dart';
import 'package:jobspot/sippo_pages/sippo_user_pages/edit_add_user_profile_info/job_edit_add_experience.dart';
import 'package:jobspot/sippo_pages/sippo_user_pages/edit_add_user_profile_info/jobstop_add_edit_skills.dart';
import 'package:jobspot/sippo_pages/sippo_user_pages/job_editprofile.dart';
import 'package:jobspot/sippo_pages/sippo_user_pages/jobstop_filter.dart';
import 'package:jobspot/sippo_pages/sippo_user_pages/jobstop_search.dart';
import 'package:jobspot/sippo_pages/sippo_user_pages/jobstop_upload_cv.dart';
import 'package:jobspot/sippo_pages/sippo_user_pages/sippo_job_description/sippo_apply_job.dart';
import 'package:jobspot/sippo_pages/sippo_user_pages/sippo_job_description/sippo_job_description.dart';
import 'package:jobspot/sippo_pages/sippo_user_pages/sippo_user_dashboard.dart';
import 'package:jobspot/sippo_pages/sippo_user_pages/sippo_user_notification.dart';
import 'package:jobspot/sippo_pages/sippo_user_pages/sippo_user_profile.dart';

import '../SippoControllerBinding/profile_binding/user_home_controller_binding.dart';

class SippoRoutes {
  const SippoRoutes._();

  static const String _homepage = "/";
  static const String _onboarding = "/onboardingscreen";

  static const String _userLoginPage = "/log-in";
  static const String _userSignupPage = "/sign-up";
  static const String _userDashboard = "/user-dashboard";
  static const String _appUsingPage = "/app-using";
  static const String _forgetPassword = "/forget-password";
  static const String _updateNewPassword = "/update-new-password";
  static const String _editUserProfile = "/edit-user-profile";
  static const String _editCompanyProfile = "/edit-company-profile";

  static const String _jobSearch = "/jobSearch";
  static const String _userProfile = "/sippo-profile";
  static const String _userWorkExperience = "/work-experience";
  static const String _educationaddedit = "/education-add-edit";
  static const String _appreciationaddedit = "/appreciation-add-edit";
  static const String _languageeditadd = "/language-add-edit";
  static const String _uploadresume = "/upload-resume";
  static const String _sippoprofilesetting = "/sippo-profile-setting";
  static const String _sippoloadapplicationcv = "/sippo-load-application-cv";
  static const String _sippojobnotification = "/sippo-job-notification";
  static const String _sippoJobDescription = "/sippo-job-description";
  static const String _filterjobsearch = "/sippo-filter-job-search";
  static const String _languageUserAdd = "/sippo-lang-user-add";
  static const String _skillsaddedit = "/skills-add-edit";

  static String get languageUserAdd => _languageUserAdd;

  static String get filterjobsearch => _filterjobsearch;

  static String get sippoJobDescription => _sippoJobDescription;

  static String get sippojobnotification => _sippojobnotification;

  static String get sippoloadapplicationcv => _sippoloadapplicationcv;

  static String get sippoprofilesetting => _sippoprofilesetting;

  static String get edituserprofile => _editUserProfile;

  static String get uploadresume => _uploadresume;

  static String get skillsaddedit => _skillsaddedit;

  static String get languageeditadd => _languageeditadd;

  static String get appreciationaddedit => _appreciationaddedit;

  static String get educationaddedit => _educationaddedit;

  static String get workexperience => _userWorkExperience;

  static String get locationselector => _locationselector;
  static const String _companysignupspecializations =
      "/company-signup-specializations";

  static const String _otpresetpassmsgpage = "/reset-pass-otp";

  static String get onboarding => _onboarding;

  static String get userdashboard => _userDashboard;

  static String get signuppage => _userSignupPage;

  static String get loginpage => _userLoginPage;

  static String get appusingpage => _appUsingPage;

  static String get identityverification => _identityverification;

  static String get forgetpasswordpage => _forgetPassword;

  static String get otpresetpassmsgpage => _otpresetpassmsgpage;

  static String get homepage => _homepage;

  static String get companysignup => _companysignup;

  static String get updatenewpassword => _updateNewPassword;

  static String get sippoprofile => _userProfile;

  static List<GetPage> routes = [
    GetPage(name: _homepage, page: () => const JobstopSplash()),
    GetPage(name: _onboarding, page: () => const SippoOnboarding()),
    GetPage(
      name: _userLoginPage,
      page: () => const SippoUserLogin(),
      binding: const LoginUserBindingController(),
    ),
    GetPage(
      name: _companylogin,
      page: () => const SippoCompanyLogin(),
      binding: const LoginCompanyBindingController(),
    ),
    GetPage(
      name: _userSignupPage,
      page: () => const SippoUserSignup(),
      binding: const SignupUserBindingController(),
    ),
    GetPage(
      name: _companysignup,
      page: () => const SippoCompanySignup(),
      binding: const SignupCompanyBindingController(),
    ),
    GetPage(
      name: _userDashboard,
      page: () => const SippoUserDashboard(),
      bindings: const [
        UserDashBoardControllerBinding(),
        UserHomeBindingController(),
      ],
    ),
    GetPage(name: _appUsingPage, page: () => const SippoAppUsing()),
    GetPage(name: _forgetPassword, page: () => const JobstopForget()),
    GetPage(
      name: _userProfile,
      page: () => const SippoUserProfile(),
      binding: const UserProfileBindingController(),
    ),
    GetPage(
        name: _locationselector,
        page: () => const SippoLocationCompanySelector()),
    GetPage(name: _editUserProfile, page: () => const EditUserProfilePage()),
    GetPage(
      name: _userWorkExperience,
      page: () => const JobExperiences(),
      binding: const EditAddWorkExperienceBindingController(),
    ),
    GetPage(
      name: _educationaddedit,
      page: () => const JobEducationAddEdit(),
      binding: const EditAddEducationBindingController(),
    ),
    GetPage(name: _languageeditadd, page: () => const LanguageEditAdd()),
    GetPage(
      name: _skillsaddedit,
      page: () => const JobSkillsAddEdit(),
      binding: const EditAddSkillsBindingController(),
    ),
    GetPage(name: _uploadresume, page: () => const SippoUploadCV()),
    GetPage(
        name: _sippocompanyprofile,
        page: () => const SippoCompanyProfile(),
        binding: const ProfileCompanyBindingController()),
    GetPage(
        name: _appreciationaddedit, page: () => const JobAppreciationAddEdit()),
    GetPage(
        name: _companysignupspecializations,
        page: () => const CompanySignUpSpecializations()),
    GetPage(
      name: _updateNewPassword,
      page: () => const UpdatePasswordAfterVerification(),
    ),
    GetPage(
      name: _filterjobsearch,
      page: () => const JobstopFilter(),
    ),
    GetPage(
      name: _languageUserAdd,
      page: () => const LanguageUserAdd(),
    ),
    GetPage(
      name: _otpresetpassmsgpage,
      page: () => const CheckOTPResetPasswordMessage(),
    ),
    GetPage(
        name: _identityverification,
        page: () => SippoCompanyIdentityVerification(),
        binding: const IdentityVerificationBindingController()),
    GetPage(name: _jobSearch, page: () => const JobSearch()),
    GetPage(
        name: _sippocompanydashboard,
        page: () => const SippoCompanyDashboard(),
        binding: const CompanyDashBoardControllerBinding()),
    GetPage(
      name: _sippoprofilesetting,
      page: () => const SippoProfileSetting(),
    ),
    GetPage(
      name: _sippoloadapplicationcv,
      page: () => const SippoApplyJob(),
    ),
    GetPage(
      name: _sippojobnotification,
      page: () => const SippoUserJobNotification(),
    ),
    GetPage(
      name: _sippoJobDescription,
      page: () => const SippoJobDescription(),
    ),
    GetPage(
      name: _editCompanyProfile,
      page: () => const EditCompanyProfilePage(),
    ),
    GetPage(
      name: _companyAddPost,
      page: () => SippoCompanyEditAddPost(),
      binding: const CompanyPostBindingController(),
    ),
    GetPage(
      name: _companyAddJobs,
      page: () => SippoCompanyEditAddJobs(),
      binding: const CompanyJobBindingController(),
    ),
  ];

  // company
  static const String _sippocompanydashboard = "/sippo-company-dashboard";
  static const String _sippocompanyprofile = "/sippo-company-profile";
  static const String _identityverification = "/identity-verification";
  static const String _companysignup = "/company-signup";
  static const String _companylogin = "/company-login";
  static const String _locationselector = "/location-selector";
  static const String _companyAddPost = "/company-add-post";
  static const String _companyAddJobs = "/company-add-jobs";

  static const String _companyCompanyDisplayJobPost =
      "/company-company-display-job-post";

  static String get companyAddJobs => _companyAddJobs;

  static String get companyCompanyDisplayJobPost =>
      _companyCompanyDisplayJobPost;

  static String get companyAddPost => _companyAddPost;

  static String get editCompanyProfile => _editCompanyProfile;

  static String get sippocompanyprofile => _sippocompanyprofile;

  static String get sippoCompanyDashboard => _sippocompanydashboard;

  static String get sippoCompanyLogin => _companylogin;

  static String get companysignupspecializations =>
      _companysignupspecializations;
}
