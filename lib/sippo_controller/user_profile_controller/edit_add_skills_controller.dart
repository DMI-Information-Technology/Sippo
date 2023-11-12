import 'dart:async';

import 'package:get/get.dart';
import 'package:jobspot/core/Refresh.dart';
import 'package:jobspot/custom_app_controller/switch_status_controller.dart';
import 'package:jobspot/sippo_controller/user_profile_controller/profile_user_controller.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/skills_model.dart';
import 'package:jobspot/sippo_data/user_repos/skills_repo.dart';
import 'package:jobspot/utils/states.dart';

class EditAddSkillsController extends GetxController {
  static EditAddSkillsController get instance => Get.find();
  final _profileController = ProfileUserController.instance;
  final loadingController = SwitchStatusController();

  List<String> get _profileSkills => _profileController.profileState.skillsList;
  final _states = States().obs;
  final skillsState = SkillsState();

  States get states => _states.value;

  void successState(bool value, [String? message]) {
    _states.value = states.copyWith(isSuccess: value, message: message);
  }

  void warningState(bool value, [String? message]) {
    _states.value = states.copyWith(isWarning: value, message: message);
  }

  Future<void> addSkills() async {
    final response =
        await SkillsRepo.addSkills(SkillsModel(skills: skillsState.skillsList));

    await response?.checkStatusResponse(
      onSuccess: (data, statusType) {
        if (data != null && data.status?.trim() != "success") {
          _profileController.profileState.skillsList = skillsState.skillsList;
        } else {
          _profileController.fetchUserSkills();
        }
        _states.value = states.copyWith(isSuccess: true);
      },
      onValidateError: (validateError, _) {
        resetSkillsState();
        _states.value =
            states.copyWith(isError: true, error: validateError?.message);
      },
      onError: (message, _) {
        resetSkillsState();
        _states.value = states.copyWith(isError: true, message: message);
      },
    );
  }

  Future<void> fetchSuggestionsSkills() async {
    final response = await SkillsRepo.fetchSkills();
    await response?.checkStatusResponse(
      onSuccess: (data, statusType) {
        Refresher.dataListUpdater(
          newData: data,
          currentData: skillsState.suggestionsSkills,
          updateData: (data) => skillsState.suggestionsSkills = data,
        );
      },
      onValidateError: (validateError, statusType) {},
      onError: (message, statusType) {},
    );
  }

  void pushSkill(String skill) {
    if (skillsState.skillsList.contains(skill)) return;
    skillsState.addSkillsList(skill);
  }

  void removeSkill(int index) {
    if (skillsState.skillsList.length == 1)
      return warningState(true, "cannot_remove_all_skills".tr);
    skillsState.removeSkillsListAt(index);
  }

  Future<void> onSaveSubmitted() async {
    if (!_profileController.netController.isConnected) {
      resetSkillsState();
      return warningState(
        true,
        'connection_lost_message_1'.tr,
      );
    }
    final nothingChanged =
        _profileSkills.length == skillsState.skillsList.length &&
            _profileSkills.every((e) => skillsState.skillsList.contains(e));
    _states.value = States(isLoading: true);
    if (!nothingChanged) {
      await addSkills();
    }
    _states.value = states.copyWith(isLoading: false);
    print('is loading: ${states.isLoading}');
    print('is success: ${states.isSuccess}');
  }

  void resetSkillsState() {
    if (_profileSkills.isNotEmpty) {
      skillsState.skillsList = _profileSkills;
    }
  }

  StreamSubscription<States>? statesSubs;

  @override
  void onInit() {
    statesSubs = _states.listen(
      (value) {
        if (value.isLoading) {
          loadingController.start();
        } else {
          loadingController.pause();
        }
      },
    );
    (() async {
      await fetchSuggestionsSkills();
      resetSkillsState();
    })();
    super.onInit();
  }

  @override
  void onClose() {
    statesSubs?.cancel();
    loadingController.dispose();
    super.onClose();
  }
}

class SkillsState {
  final _selectedChip = (-1).obs;

  int get selectedChip => _selectedChip.toInt();

  void set selectedChip(int value) => _selectedChip.value = value;

  final _isChangeSkills = false.obs;

  bool get isChangeSkills => _isChangeSkills.isTrue;

  set isChangeSkills(bool value) => _isChangeSkills.value = value;

  final _skillsList = <String>[].obs;

  List<String> get skillsList => _skillsList;

  void set skillsList(List<String> value) => _skillsList.value = value;

  void addSkillsList(String value) => _skillsList.add(value);

  void removeSkillsListAt(int index) => _skillsList.removeAt(index);

  final _suggestionsSkills = <String>[].obs;

  List<String> get suggestionsSkills => _suggestionsSkills;

  void set suggestionsSkills(List<String> value) =>
      _suggestionsSkills.value = value;
}
