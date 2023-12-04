import 'dart:async';

import 'package:get/get.dart';
import 'package:jobspot/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/JobServices/shared_global_data_service.dart';
import 'package:jobspot/custom_app_controller/switch_status_controller.dart';
import 'package:jobspot/sippo_data/company_repos/compan_user_profile_view_repo.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/company_user_profile_view_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/cv_file_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/education_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/language_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/profile_edit_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/user_projects_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/work_experiences_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_widget_model/jobstop_resume_file_info.dart';
import 'package:jobspot/utils/file_downloader_service.dart';
import 'package:jobspot/utils/states.dart';

class ProfileUserViewController extends GetxController {
  final netController = InternetConnectionService.instance;

  // late final StreamSubscription<bool>? _connectionSubscription;
  // final dashboard = CompanyDashBoardController.instance;

  // CompanyDetailsResponseModel get company => dashboard.company;

  static ProfileUserViewController get instance => Get.find();
  final profileState = ProfileState();

  ProfileViewResourceModel? get profileViewState =>
      SharedGlobalDataService.instance.profileViewGlobalState.details;

  int get profileViewId =>
      SharedGlobalDataService.instance.profileViewGlobalState.id;
  final _states = States().obs;

  States get states => _states.value;

  void changeStates({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    bool? isWarning,
    String? message,
    String? error,
  }) =>
      _states.value = states.copyWith(
        isLoading: isLoading,
        isSuccess: isLoading == true ? false : isSuccess,
        isError: isLoading == true ? false : isError,
        message: message,
        isWarning: isLoading == true ? false : isWarning,
        error: error,
      );

  Future<void> fetchUserProfileResources(int? profileId) async {
    final response =
        await CompanyUserProfileViewRepo.getUserProfileViewById(profileId);
    await response?.checkStatusResponse(
      onSuccess: (data, _) {
        if (data != null) {
          print('ProfileUserViewController.fetchUserProfileResources: ${data.userInfo?.locationAddress
          }');
          profileState.setAll(data);
        }
      },
      onValidateError: (validateError, _) {},
      onError: (message, _) {},
    );
  }

  // void _connected(bool isConn) async {
  //   isConn && profileViewId != -1
  //       ? await fetchUserProfileResources(profileViewId)
  //       : null;
  // }
  //
  // void _startListeningToConnection() {
  //   final profile = profileViewState;
  //   if (profile != null && profile.userInfo != null) {
  //     profileState.setAll(profile);
  //   }
  //   _connectionSubscription = netController.isConnectedStream.listen(
  //     _connected,
  //   );
  //   if (profileViewId != -1) fetchUserProfileResources(profileViewId);
  // }
  void requestProfileInfo() async {
    if (netController.isNotConnected || states.isLoading) return;
    changeStates(isLoading: true);
    if (profileViewId != -1) await fetchUserProfileResources(profileViewId);
    changeStates(isLoading: false);
  }

  @override
  void onInit() {
    final profile = profileViewState;
    if (profile != null && profile.userInfo != null) {
      profileState.setAll(profile);
    }
    requestProfileInfo();
    // _startListeningToConnection();
    super.onInit();
  }

  final loadingOverlay = SwitchStatusController();

  void openFile(String fileUrl, [String? size]) async {
    if (netController.isNotConnected) return;
    await FileDownloader.openFile(
      fileUrl,
      size: size,
      fn: (status) => loadingOverlay.status = status,
    );
  }

  @override
  void onClose() {
    loadingOverlay.dispose();
    // _connectionSubscription?.cancel();
    super.onClose();
  }
}

class ProfileState {
  final _isHeightOverAppBar = false.obs;

  bool get isHeightOverAppBar => _isHeightOverAppBar.isTrue;

  set isHeightOverAppBar(bool value) => _isHeightOverAppBar.value = value;
  final _profileInfo = ProfileInfoModel().obs;

  void setAll(ProfileViewResourceModel data) {
    print('ProfileState.setAll:${data.userInfo?.locationAddress?.name}');
    profileInfo = data.userInfo?.copyWith(
          profileImage: data.image,
          cv: data.cv,
          nationality: data.nationality,

        ) ??
        profileInfo;
    aboutMeText = data.userInfo?.bio ?? '';
    skillsList = data.skills?.skills ?? skillsList;
    educationList = data.educations ?? educationList;
    languages = data.languages ?? languages;
    workExList = data.workExperiences ?? workExList;
    projects = data.projects ?? projects;
  }

  ProfileInfoModel get profileInfo => _profileInfo.value;

  void set profileInfo(ProfileInfoModel value) => _profileInfo.value = value;
  final _aboutMeText =
      "lorem ispum dolor sit amet, consectetur adipiscing elit in aenean non proident"
          .obs;

  void set aboutMeText(String value) {
    _aboutMeText.value = value;
  }

  CvModel? get cv => profileInfo.cv;
  final _showAllWei = false.obs;
  final _showAllEdui = false.obs;
  final _showAllProjects = false.obs;
  final _showAllSkills = false.obs;
  final _showAllLangs = false.obs;
  final _wei = <WorkExperiencesModel>[].obs;
  final _educationList = <EducationModel>[].obs;
  final _skills = <String>[].obs;
  final _languages = <LanguageModel>[].obs;
  final _projects = <UserProjectsModel>[].obs;
  final Rx<ResumeFileInfo?> _resumeFiles = ResumeFileInfo.getNull().obs;

  List<WorkExperiencesModel> get workExList => _wei.toList();

  List<EducationModel> get educationList => _educationList.toList();

  List<String> get skillsList => _skills.toList();

  List<UserProjectsModel> get projects => _projects.toList();

  List<LanguageModel> get languages => _languages.toList();

  void set workExList(List<WorkExperiencesModel> value) => _wei.value = value;

  void set educationList(List<EducationModel> value) =>
      _educationList.value = value;

  void set skillsList(List<String> value) =>
      _skills.value = _skills.value = value;

  void set languages(List<LanguageModel> value) => _languages.value = value;

  void set projects(List<UserProjectsModel> value) => _projects.value = value;

  String get aboutMeText => _aboutMeText.toString();

  bool get showAllWei => _showAllWei.isTrue;

  bool get showAllEdui => _showAllEdui.isTrue;

  bool get showAllSkills => _showAllSkills.isTrue;

  bool get showAllLangs => _showAllLangs.isTrue;

  bool get showAllProjects => _showAllProjects.isTrue;

  void set showAllWei(bool value) => _showAllWei.value = value;

  void set showAllEdui(bool value) => _showAllEdui.value = value;

  void set showAllSkills(bool value) => _showAllSkills.value = value;

  void set showAllLangs(bool value) => _showAllLangs.value = value;

  void set showAllProjects(bool value) => _showAllProjects.value = value;

  ResumeFileInfo? get resumeFiles => _resumeFiles.value;

  void set resumeFiles(ResumeFileInfo? value) {
    _resumeFiles.value = value;
  }
}
