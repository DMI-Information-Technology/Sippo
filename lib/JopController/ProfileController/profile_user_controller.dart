import 'dart:async';

import 'package:get/get.dart';
import 'package:jobspot/JopController/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/JopController/UserDashboardController/user_dashboard_controller.dart';
import 'package:jobspot/core/Refresh.dart';
import 'package:jobspot/sippo_data/model/auth_model/user_response_model.dart';

import '../../sippo_data/model/profile_model/profile_resource_model/work_experiences_model.dart';
import '../../sippo_data/model/profile_model/profile_widget_model/jobstop_appreciation_info_card_model.dart';
import '../../sippo_data/model/profile_model/profile_widget_model/jobstop_education_info_card_model.dart';
import '../../sippo_data/model/profile_model/profile_widget_model/jobstop_language_info_card_model.dart';
import '../../sippo_data/model/profile_model/profile_widget_model/jobstop_resume_file_info.dart';
import '../../sippo_data/profile_user/work_experiences_repo.dart';

class ProfileUserController extends GetxController {
  final netController = InternetConnectionController.instance;
  StreamSubscription<bool>? _connectionSubscription;
  final dashboard = UserDashBoardController.instance;

  UserResponseModel get user => dashboard.user;

  static ProfileUserController get instance => Get.find();
  final _aboutMeText =
      "lorem ipsujfm vcxmkmvfkjhkgd jkflmvf lkfvmfdv klffdleoopmmvfmlvk ijggjjm,dfvom,.m,mcxvomfm "
          .obs;
  final _showAllWei = false.obs;
  final _showAllEdui = false.obs;
  final _showAllAppreciations = false.obs;
  final _showAllSkills = false.obs;
  final _showAllLangs = false.obs;

  final _wei = <WorkExperiencesModel>[].obs;
  final _edui = <EducationInfoCardModel>[].obs;
  final _skills = <String>[].obs;
  final _languages = <LanguageInfoCardModel>[].obs;
  final _appreciations = <AppreciationInfoCardModel>[].obs;

  List<AppreciationInfoCardModel> get appreciations => _appreciations.toList();

  List<WorkExperiencesModel> get wei => _wei.toList();

  void set wei(List<WorkExperiencesModel> value) => _wei.value = value;

  List<EducationInfoCardModel> get edui => _edui.toList();

  List<LanguageInfoCardModel> get languages => _languages.toList();

  List<String> get skills => _skills.toList();

  String get aboutMeText => _aboutMeText.toString();

  bool get showAllWei => _showAllWei.isTrue;

  bool get showAllEdui => _showAllEdui.isTrue;

  bool get showAllSkills => _showAllSkills.isTrue;

  bool get showAllLangs => _showAllLangs.isTrue;

  bool get showAllAppreciations => _showAllAppreciations.isTrue;

  final Rx<ResumeFileInfo?> _resumeFiles = ResumeFileInfo.getNull().obs;

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

  final _editingId = (-1).obs;

  int get editingId => _editingId.toInt();

  void set editingId(int value) => _editingId.value = value;

  Future<void> fetchAllWorkExperience() async {
    final response = await WorkExperiencesRepo.fetchWorkExperiences();
    await response?.checkStatusResponse(
      onSuccess: (data, statusType) {
        Refresher.dataListUpdater(
          newData: data,
          currentData: wei,
          updateData: (data) => _wei.value = data,
        );
      },
      onValidateError: (validateError, statusType) {},
      onError: (message, statusType) {},
    );
  }

  void _startListeningToConnection() {
    _connectionSubscription = netController.isConnectedStream.listen(
      (isConnected) async {
        if (isConnected) {
          print("fetchAllWorkExperience is target");
          await fetchAllWorkExperience();
        }
      },
    );
  }

  @override
  void onInit() {
    (() async {
      await fetchAllWorkExperience();
      _startListeningToConnection();
    })();
    super.onInit();
  }

  @override
  void onClose() {
    _connectionSubscription?.cancel();
    super.onClose();
  }
}
