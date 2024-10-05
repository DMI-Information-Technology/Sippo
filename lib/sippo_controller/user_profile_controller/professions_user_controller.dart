import 'dart:async';

import 'package:get/get.dart';
import 'package:sippo/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:sippo/custom_app_controller/switch_status_controller.dart';
import 'package:sippo/sippo_controller/dashboards_controller/user_dashboard_controller.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';
import 'package:sippo/sippo_data/model/profile_model/profile_resource_model/profession_user_model.dart';
import 'package:sippo/sippo_data/model/profile_model/profile_resource_model/professions_user_model.dart';
import 'package:sippo/sippo_data/model/profile_model/profile_resource_model/profile_edit_model.dart';
import 'package:sippo/sippo_data/user_repos/professions_repo.dart';
import 'package:sippo/utils/helper.dart';
import 'package:sippo/utils/states.dart';

class ProfessionsUserController extends GetxController {
  static ProfessionsUserController get instance => Get.find();

  ProfileInfoModel get user => UserDashBoardController.instance.user;
  final loadingOverly = SwitchStatusController();

  bool get isModifyStateChanged =>
      modifyStates.isError || modifyStates.isWarning;
  final _fetchStates = States().obs;

  States get fetchStates => _fetchStates.value;

  void set fetchStates(States state) => _fetchStates.value = state;
  final _modifyStates = States().obs;

  States get modifyStates => _modifyStates.value;

  void set modifyStates(States state) => _modifyStates.value = state;

  void resetState() => _modifyStates.value = States();

  bool get isNetworkConnected => InternetConnectionService.instance.isConnected;
  final _professions = <ProfessionUserModel>[].obs;

  List<ProfessionUserModel> get professions => _professions.toList();

  set professions(List<ProfessionUserModel> value) {
    _professions.value = value;
  }

  int get professionsLength => _professions.length;
  final _selectedProfessions = <ProfessionUserModel>[].obs;

  List<ProfessionUserModel> get selectedProfessions {
    return _selectedProfessions.toList();
  }

  void set selectedProfessions(List<ProfessionUserModel> value) {
    _selectedProfessions.value = value;
  }

  bool isProfessionSelected(ProfessionUserModel value) {
    return _professions.firstWhereOrNull(
          (e) => e.id == value.id,
        ) !=
        null;
  }

  bool fromSelectedProfession(ProfessionUserModel value) {
    return _selectedProfessions.firstWhereOrNull(
          (e) => e.id == value.id,
        ) !=
        null;
  }

  void toggleProfessionUser(ProfessionUserModel value) {
    if (fromSelectedProfession(value)) {
      return _selectedProfessions.removeWhere(
        (e) => e.id == value.id,
      );
    }
    _selectedProfessions.add(value);
  }

  List<int> get professionsId {
    final result = <int>[];
    selectedProfessions.forEach((e) {if (e.id case int id) result.add(id);});
    return result;
  }

  Future<void> fetchProfessions() async {
    if (!isNetworkConnected) return;
    fetchStates = States(isLoading: true);
    final response = await ProfessionsRepo.fetchProfessions();
    fetchStates = States(isLoading: false);
    await response?.checkStatusResponse(
      onSuccess: (data, statusType) {
        if (data != null) {
          professions = data;
          fetchStates = States(isSuccess: true);
        }
      },
      onValidateError: (validateError, statusType) {
        fetchStates = States(isError: true, message: validateError?.message);
      },
      onError: (message, statusType) {
        fetchStates = States(isError: true, message: message);
      },
    );
  }

  Future<void> updateProfessions() async {
    if (!isNetworkConnected) return;
    if (modifyStates.isLoading) return;
    if (selectedProfessions.length == 0 || selectedProfessions.length > 3) {
      _modifyStates(
        States(
          isError: true,
          message: 'pick_professions_message'.tr,
        ),
      );
      return;
    }
    if (listEquality(selectedProfessions, user.professions)) {
      _modifyStates(
        States(
          isWarning: true,
          message: 'nothing_changed_specializations'.tr,
        ),
      );
      return;
    }
    modifyStates = States(isLoading: true);
    final response =
        await ProfessionsRepo.updateUserProfessions(ProfessionsUserModel(
      professions: professionsId,
    ));
    modifyStates = States(isLoading: false);

    await response.checkStatusResponse(
      onSuccess: (data, _) async {
        if (data == null || data.isEmpty) {
          UserDashBoardController.instance.userInformationRefresh();
        } else {
          UserDashBoardController.instance.user =
              user.copyWith(professions: data);
        }
        Get.dialog(
          CustomAlertDialog(
            title: 'profession_title'.tr,
            description: 'professions_added'.tr,
            confirmBtnTitle: 'ok'.tr,
            onConfirm: () => {if (Get.isOverlaysOpen) Get.back()},
          ),
        ).then((_) => Get.back());
      },
      onValidateError: (validateError, _) {
        modifyStates = States(isError: true, message: validateError?.message);
      },
      onError: (message, _) {
        modifyStates = States(isError: true, message: message);
      },
    );
  }

  StreamSubscription<States>? fetchStateStubs;
  StreamSubscription<States>? modifyStatesSubs;

  @override
  void onInit() {
    fetchStateStubs = _fetchStates.listen((value) {
      if (value.isLoading) {
        loadingOverly.start();
      } else {
        loadingOverly.pause();
      }
    });
    modifyStatesSubs = _modifyStates.listen((value) {
      if (value.isLoading) {
        loadingOverly.start();
      } else {
        loadingOverly.pause();
      }
    });
    selectedProfessions = user.professions?.toList() ?? selectedProfessions;
    fetchProfessions();
    super.onInit();
  }

  @override
  void onClose() {
    fetchStateStubs?.cancel();
    modifyStatesSubs?.cancel();
    super.onClose();
  }
}
