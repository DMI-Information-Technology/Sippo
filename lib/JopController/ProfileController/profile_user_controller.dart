import 'dart:async';

import 'package:get/get.dart';
import 'package:jobspot/JopController/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/JopController/UserDashboardController/user_dashboard_controller.dart';
import 'package:jobspot/core/Refresh.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/education_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/language_model.dart';
import 'package:jobspot/sippo_data/profile_user/education_repo.dart';
import 'package:jobspot/sippo_data/profile_user/language_repo.dart';
import 'package:jobspot/sippo_data/profile_user/skills_repo.dart';

import '../../sippo_data/model/profile_model/profile_resource_model/profile_edit_model.dart';
import '../../sippo_data/model/profile_model/profile_resource_model/work_experiences_model.dart';
import '../../sippo_data/model/profile_model/profile_widget_model/jobstop_appreciation_info_card_model.dart';
import '../../sippo_data/model/profile_model/profile_widget_model/jobstop_resume_file_info.dart';
import '../../sippo_data/profile_user/work_experiences_repo.dart';

class ProfileUserController extends GetxController {
  final netController = InternetConnectionController.instance;
  late final StreamSubscription<bool>? _connectionSubscription;
  final dashboard = UserDashBoardController.instance;

  ProfileInfoModel get user => dashboard.user;

  static ProfileUserController get instance => Get.find();
  final profileState = ProfileState();

  final _editingId = (-1).obs;

  int get editingId => _editingId.toInt();

  void set editingId(int value) => _editingId.value = value;

  Future<void> fetchAllWorkExperience() async {
    final response = await WorkExperiencesRepo.fetchWorkExperiences();
    await response?.checkStatusResponse(
      onSuccess: (data, statusType) {
        Refresher.dataListUpdater(
          newData: data,
          currentData: profileState.workExList,
          updateData: (data) => profileState.workExList = data,
        );
      },
      onValidateError: (validateError, statusType) {},
      onError: (message, statusType) {},
    );
  }

  Future<void> fetchAllEducation() async {
    final response = await EducationRepo.fetchEducations();
    await response?.checkStatusResponse(
      onSuccess: (data, statusType) {
        Refresher.dataListUpdater(
          newData: data,
          currentData: profileState.educationList,
          updateData: (data) => profileState.educationList = data,
        );
      },
      onValidateError: (validateError, statusType) {},
      onError: (message, statusType) {},
    );
  }

  Future<void> fetchUserSkills() async {
    final response = await SkillsRepo.fetchSkills(isUser: true);
    await response?.checkStatusResponse(
      onSuccess: (data, statusType) {
        Refresher.dataListUpdater(
          newData: data,
          currentData: profileState.skillsList,
          updateData: (data) => profileState.skillsList = data,
        );
      },
      onValidateError: (validateError, statusType) {},
      onError: (message, statusType) {},
    );
  }

  Future<void> fetchUserLanguage() async {
    final response = await LanguageRepo.fetchLanguages(isUser: true);
    await response?.checkStatusResponse(
      onSuccess: (data, statusType) {
        Refresher.dataListUpdater(
          newData: data,
          currentData: profileState.languages,
          updateData: (data) => profileState.languages = data,
        );
      },
      onValidateError: (validateError, statusType) {},
      onError: (message, statusType) {},
    );
  }

  Future<void> fetchResources() async {
    // final List<Future> futures =
    // await Future.wait(futures);
    await Future.wait([
      fetchAllWorkExperience(),
      fetchAllEducation(),
      fetchUserSkills(),
      fetchUserLanguage(),
      // Add more API calls here
    ]);
  }

  void _connected(bool isConn) async => isConn ? await fetchResources() : null;

  void _startListeningToConnection() {
    _connectionSubscription = netController.isConnectedStream.listen(
      _connected,
    );
    fetchResources();
  }

  @override
  void onInit() {
    _startListeningToConnection();
    super.onInit();
  }

  @override
  void onClose() {
    _connectionSubscription?.cancel();
    super.onClose();
  }
}

class ProfileState {
  final _aboutMeText =
      "lorem ispum dolor sit amet, consectetur adipiscing elit in aenean non proident"
          .obs;
  final _showAllWei = false.obs;
  final _showAllEdui = false.obs;
  final _showAllAppreciations = false.obs;
  final _showAllSkills = false.obs;
  final _showAllLangs = false.obs;
  final _wei = <WorkExperiencesModel>[].obs;
  final _educationList = <EducationModel>[].obs;
  final _skills = <String>[].obs;
  final _languages = <LanguageModel>[].obs;
  final _appreciations = <AppreciationInfoCardModel>[].obs;
  final Rx<ResumeFileInfo?> _resumeFiles = ResumeFileInfo.getNull().obs;

  List<WorkExperiencesModel> get workExList => _wei.toList();

  List<EducationModel> get educationList => _educationList.toList();

  List<String> get skillsList => _skills.toList();

  List<AppreciationInfoCardModel> get appreciations => _appreciations.toList();

  List<LanguageModel> get languages => _languages.toList();

  void set workExList(List<WorkExperiencesModel> value) => _wei.value = value;

  void set educationList(List<EducationModel> value) {
    _educationList.value = value;
  }

  void set skillsList(List<String> value) {
    _skills.value = _skills.value = value;
  }

  void set languages(List<LanguageModel> value) => _languages.value = value;

  String get aboutMeText => _aboutMeText.toString();

  bool get showAllWei => _showAllWei.isTrue;

  bool get showAllEdui => _showAllEdui.isTrue;

  bool get showAllSkills => _showAllSkills.isTrue;

  bool get showAllLangs => _showAllLangs.isTrue;

  bool get showAllAppreciations => _showAllAppreciations.isTrue;

  void set showAllWei(bool value) => _showAllWei.value = value;

  void set showAllEdui(bool value) => _showAllEdui.value = value;

  void set showAllSkills(bool value) => _showAllSkills.value = value;

  void set showAllLangs(bool value) => _showAllLangs.value = value;

  void set showAllAppreciations(bool value) =>
      _showAllAppreciations.value = value;

  ResumeFileInfo? get resumeFiles => _resumeFiles.value;

  void set resumeFiles(ResumeFileInfo? value) {
    _resumeFiles.value = value;
  }
}
