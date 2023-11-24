import 'package:get/get.dart';
import 'package:jobspot/SippoControllerBinding/auth_binding/identity_verification_controller_binding.dart';
import 'package:jobspot/SippoControllerBinding/auth_binding/login_company_binding_controller.dart';
import 'package:jobspot/SippoControllerBinding/auth_binding/login_user_binding_controller.dart';
import 'package:jobspot/SippoControllerBinding/auth_binding/signup_company_binding_controller.dart';
import 'package:jobspot/SippoControllerBinding/auth_binding/signup_user_binding_controller.dart';
import 'package:jobspot/SippoControllerBinding/company_binding/company_edit_add_specialization_binding_controller.dart';
import 'package:jobspot/SippoControllerBinding/company_binding/company_home_controller_binding.dart';
import 'package:jobspot/SippoControllerBinding/company_binding/company_job_controller_binding.dart';
import 'package:jobspot/SippoControllerBinding/company_binding/company_post_controller_binding.dart';
import 'package:jobspot/SippoControllerBinding/company_binding/company_profile_controller_binding.dart';
import 'package:jobspot/SippoControllerBinding/company_binding/copmany_user_profile_view_controller_binding.dart';
import 'package:jobspot/SippoControllerBinding/company_binding/selected_company_work_place_controller_binding.dart';
import 'package:jobspot/SippoControllerBinding/dashboard_binding/company_dashbord_controller_binding.dart';
import 'package:jobspot/SippoControllerBinding/dashboard_binding/guest_dashbord_controller_binding.dart';
import 'package:jobspot/SippoControllerBinding/dashboard_binding/user_dashboard_controller_binding.dart';
import 'package:jobspot/SippoControllerBinding/guest_binding/guest_home_binding.dart';
import 'package:jobspot/SippoControllerBinding/profile_binding/UserSearchJobsControllerBinding.dart';
import 'package:jobspot/SippoControllerBinding/profile_binding/edit_add_education_controller_binding.dart';
import 'package:jobspot/SippoControllerBinding/profile_binding/edit_add_skills_controller_binding.dart';
import 'package:jobspot/SippoControllerBinding/profile_binding/edit_add_work_experience_controller_binding.dart';
import 'package:jobspot/SippoControllerBinding/profile_binding/user_about_companies_controller_binding.dart';
import 'package:jobspot/SippoControllerBinding/profile_binding/user_apply_company_controller_binding.dart';
import 'package:jobspot/SippoControllerBinding/profile_binding/user_apply_job_controller_binding.dart';
import 'package:jobspot/SippoControllerBinding/profile_binding/user_general_search_controller_binding.dart';
import 'package:jobspot/SippoControllerBinding/profile_binding/user_home_controller_binding.dart';
import 'package:jobspot/SippoControllerBinding/profile_binding/user_job_description_controller_binding.dart';
import 'package:jobspot/SippoControllerBinding/profile_binding/user_profile_controller_binding.dart';
import 'package:jobspot/SippoControllerBinding/profile_binding/user_search_jobs_filter_controller_binding.dart';
import 'package:jobspot/SippoControllerBinding/profile_binding/user_upload_cv_controller_binding.dart';
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
import 'package:jobspot/sippo_pages/sippo_abouts_companies/apply_to_company.dart';
import 'package:jobspot/sippo_pages/sippo_abouts_companies/sippo_about_companies.dart';
import 'package:jobspot/sippo_pages/sippo_company_pages/company_post_and_jobs/sippo_company_edit_add_jobs.dart';
import 'package:jobspot/sippo_pages/sippo_company_pages/company_post_and_jobs/sippo_company_edit_add_post.dart';
import 'package:jobspot/sippo_pages/sippo_company_pages/company_user_profile_view/sippo_show_user_profile_view.dart';
import 'package:jobspot/sippo_pages/sippo_company_pages/edit_add_specialization_company.dart';
import 'package:jobspot/sippo_pages/sippo_company_pages/sippo_company_dashboard.dart';
import 'package:jobspot/sippo_pages/sippo_company_pages/sippo_company_profile.dart';
import 'package:jobspot/sippo_pages/sippo_company_pages/sippo_edit_company_profile.dart';
import 'package:jobspot/sippo_pages/sippo_company_pages/sippo_selected_company_work_places.dart';
import 'package:jobspot/sippo_pages/sippo_geust_pages/sippo_guest_dashboard.dart';
import 'package:jobspot/sippo_pages/sippo_job_description/sippo_apply_job.dart';
import 'package:jobspot/sippo_pages/sippo_job_description/sippo_job_description.dart';
import 'package:jobspot/sippo_pages/sippo_search_functions/sippo_general_search.dart';
import 'package:jobspot/sippo_pages/sippo_search_functions/sippo_search_jobs.dart';
import 'package:jobspot/sippo_pages/sippo_search_functions/sippo_search_jobs_filter.dart';
import 'package:jobspot/sippo_pages/sippo_search_functions/sippo_search_jobs_specializations_filter.dart';
import 'package:jobspot/sippo_pages/sippo_user_pages/edit_add_user_profile_info/job_add_edit_education.dart';
import 'package:jobspot/sippo_pages/sippo_user_pages/edit_add_user_profile_info/job_add_edit_language.dart';
import 'package:jobspot/sippo_pages/sippo_user_pages/edit_add_user_profile_info/job_add_edit_projects.dart';
import 'package:jobspot/sippo_pages/sippo_user_pages/edit_add_user_profile_info/job_add_language_user.dart';
import 'package:jobspot/sippo_pages/sippo_user_pages/edit_add_user_profile_info/job_edit_add_experience.dart';
import 'package:jobspot/sippo_pages/sippo_user_pages/edit_add_user_profile_info/jobstop_add_edit_skills.dart';
import 'package:jobspot/sippo_pages/sippo_user_pages/job_editprofile.dart';
import 'package:jobspot/sippo_pages/sippo_user_pages/jobstop_upload_cv.dart';
import 'package:jobspot/sippo_pages/sippo_user_pages/sippo_user_dashboard.dart';
import 'package:jobspot/sippo_pages/sippo_user_pages/sippo_user_notification_application/sippo_user_notification_application.dart';
import 'package:jobspot/sippo_pages/sippo_user_pages/sippo_user_profile.dart';

import '../SippoControllerBinding/profile_binding/edit_add_projects_controller_binding.dart';

class SippoRoutes {
  const SippoRoutes._();

  static const String splashScreen = "/";
  static const String onboarding = "/on-boarding-screen";

  static const String userLoginPage = "/log-in";
  static const String userSignupPage = "/sign-up";

  static const String userDashboard = "/user-dashboard";
  static const String appUsingPage = "/app-using";
  static const String forgetPassword = "/forget-password";
  static const String updateNewPassword = "/change-password";
  static const String editUserProfile = "/edit-user-profile";
  static const String editCompanyProfile = "/edit-company-profile";

  static const String sippoUserProfile = "/sippo-user-profile";
  static const String userWorkExperience = "/user-work-experience";
  static const String educationaddedit = "/user-education-add-edit";
  static const String skillsaddedit = "/skills-add-edit";
  static const String languageeditadd = "/user-language-add-edit";
  static const String languageUserAdd = "/sippo-user-language-add";
  static const String uploadresume = "/user-upload-cv";
  static const String sippoprofilesetting = "/sippo-profile-settings";
  static const String sippojobnotification = "/sippo-user-notifications";
  static const String sippoJobDescription = "/sippo-user-job-description";

  static const String userApplyJobs = "/sippo-user-apply-job";
  static const String sippoAboutCompanies = "/sippo-about-companies";
  static const String sippoUserApplyCompany = "/sippo-user-apply-company";
  static const String sippoCompanyUserProfileView =
      "/sippo-company-user-profile-view";

  static const String sippoEditAddUserProjects = "/sippo-edit-add-projects";
  static const String otpresetpassmsgpage = "/reset-pass-otp";
  static const String sippoJobFilterSearch = "/sippo-job-search";
  static const String sippoFilterOptionJobSearch = "/sippo-filter-job-search";
  static const String filterSpecializationsJobsSearch =
      "/sippo-filter-specializations-job-search";
  static const String sippoGeneralSearchPage = "/sippo-general-search";
  static const String sippoSelectedCompanyWorkPlace =
      "/sippo-open-google-map-view";
  static const String sippoEditAddSpecializationCompany =
      "/sippo-edit-add-specialization-company";

  // company
  static const String sippoCompanyDashboard = "/sippo-company-dashboard";
  static const String sippocompanyprofile = "/sippo-company-profile";
  static const String identityverification = "/company-identity-verification";
  static const String companysignup = "/company-signup";
  static const String sippoCompanyLogin = "/company-login";
  static const String sippoGuest = "/sippo-guest";
  static const String locationselector = "/sippo-location-selector";
  static const String companyAddPost = "/sippo-company-add-post";
  static const String companyAddJobs = "/sippo-company-add-jobs";
  static const String companySignupSpecializations =
      "/company-signup-specializations";

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SippoSplash()),
    GetPage(name: onboarding, page: () => const SippoOnboarding()),
    GetPage(
      name: userLoginPage,
      page: () => const SippoUserLogin(),
      binding: const LoginUserBindingController(),
    ),
    GetPage(
      name: sippoCompanyLogin,
      page: () => const SippoCompanyLogin(),
      binding: const LoginCompanyBindingController(),
    ),
    GetPage(
      name: sippoGuest,
      page: () => const SippoGuestDashboard(),
      bindings: const [
        GuestDashBoardControllerBinding(),
        GuestHomeBindingController(),
      ],
    ),
    GetPage(
      name: userSignupPage,
      page: () => const SippoUserSignup(),
      binding: const SignupUserBindingController(),
    ),
    GetPage(
      name: companysignup,
      page: () => const SippoCompanySignup(),
      binding: const SignupCompanyBindingController(),
    ),
    GetPage(
      name: userDashboard,
      page: () => const SippoUserDashboard(),
      bindings: const [
        UserDashboardControllerBinding(),
        UserHomeBindingController(),
      ],
    ),
    GetPage(name: appUsingPage, page: () => const SippoAppUsing()),
    GetPage(name: forgetPassword, page: () => const JobstopForget()),
    GetPage(
      name: sippoUserProfile,
      page: () => const SippoUserProfile(),
      binding: const UserProfileBindingController(),
    ),
    GetPage(
      name: locationselector,
      page: () => const SippoLocationCompanySelector(),
    ),
    GetPage(name: editUserProfile, page: () => const EditUserProfilePage()),
    GetPage(
      name: userWorkExperience,
      page: () => const JobExperiences(),
      binding: const EditAddWorkExperienceBindingController(),
    ),
    GetPage(
      name: educationaddedit,
      page: () => const JobEducationAddEdit(),
      binding: const EditAddEducationBindingController(),
    ),
    GetPage(name: languageeditadd, page: () => const LanguageEditAdd()),
    GetPage(
      name: skillsaddedit,
      page: () => const JobSkillsAddEdit(),
      binding: const EditAddSkillsBindingController(),
    ),
    GetPage(
      name: uploadresume,
      page: () => const SippoUploadCV(),
      binding: const UserUploadCvBindingController(),
    ),
    GetPage(
        name: sippocompanyprofile,
        page: () => const SippoCompanyProfile(),
        binding: const ProfileCompanyBindingController()),
    GetPage(
      name: sippoEditAddUserProjects,
      page: () => const SippoProjectsAddEdit(),
      binding: const EditAddProjectsBindingController(),
    ),
    GetPage(
        name: companySignupSpecializations,
        page: () => const CompanySignUpSpecializations()),
    GetPage(
      name: updateNewPassword,
      page: () => const UpdatePasswordAfterVerification(),
    ),
    GetPage(
      name: sippoFilterOptionJobSearch,
      page: () => const SippoSearchJobsFilter(),
      binding: const SearchJobsFilterBindingController(),
    ),
    GetPage(
      name: languageUserAdd,
      page: () => const LanguageUserAdd(),
    ),
    GetPage(
      name: otpresetpassmsgpage,
      page: () => const CheckOTPResetPasswordMessage(),
    ),
    GetPage(
        name: userApplyJobs,
        page: () => const SippoApplyJob(),
        binding: const UserApplyJobBindingController()),
    GetPage(
      name: identityverification,
      page: () => const SippoCompanyIdentityVerification(),
      binding: const IdentityVerificationBindingController(),
    ),
    GetPage(
      name: sippoEditAddSpecializationCompany,
      page: () => const EditAddSpecializationCompany(),
      binding: const CompanyEditAddSpecializationBindingController(),
    ),
    GetPage(
      name: sippoJobFilterSearch,
      page: () => const SippoJobSearch(),
      binding: const UserSearchJobsBindingController(),
    ),
    GetPage(
      name: sippoCompanyDashboard,
      page: () => const SippoCompanyDashboard(),
      bindings: const [
        CompanyDashBoardControllerBinding(),
        CompanyHomeBindingController(),
      ],
    ),
    GetPage(
      name: sippoprofilesetting,
      page: () => const SippoProfileSetting(),
    ),
    GetPage(
      name: sippojobnotification,
      page: () => const SippoUserNotificationApplication(),
    ),
    GetPage(
      name: sippoJobDescription,
      page: () => const SippoJobDescription(),
      binding: const UserJobDescriptionBindingController(),
    ),
    GetPage(
      name: editCompanyProfile,
      page: () => const EditCompanyProfilePage(),
    ),
    GetPage(
      name: companyAddPost,
      page: () => const SippoCompanyEditAddPost(),
      binding: const CompanyPostBindingController(),
    ),
    GetPage(
      name: companyAddJobs,
      page: () => const SippoCompanyEditAddJobs(),
      binding: const CompanyJobBindingController(),
    ),
    GetPage(
      name: sippoAboutCompanies,
      page: () => const SippoAboutCompanies(),
      binding: const UserAboutCompaniesBindingController(),
    ),
    GetPage(
      name: sippoUserApplyCompany,
      page: () => const SippoApplyCompany(),
      binding: const UserApplyCompanyBindingController(),
    ),
    GetPage(
      name: sippoCompanyUserProfileView,
      page: () => SippoCompanyUserProfileView(),
      binding: const CompanyUserProfileViewBindingController(),
    ),
    GetPage(
      name: filterSpecializationsJobsSearch,
      page: () => SippoSearchJobsSpecializationsFilter(),
    ),
    GetPage(
      name: sippoGeneralSearchPage,
      page: () => const SippoGeneralSearch(),
      binding: const UserGeneralSearchBindingController(),
    ),
    GetPage(
      name: sippoSelectedCompanyWorkPlace,
      page: () => const SippoSelectCompanyWorkPlaces(),
      binding: const SelectedCompanyWorkPlaceBindingController(),
    ),
  ];
}
