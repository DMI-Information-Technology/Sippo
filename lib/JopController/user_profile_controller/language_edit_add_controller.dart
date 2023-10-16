import 'package:get/get.dart';
import 'package:jobspot/JopController/user_profile_controller/profile_user_controller.dart';

import 'package:jobspot/core/Refresh.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/language_model.dart';
import 'package:jobspot/sippo_data/user_repos/language_repo.dart';
import 'package:jobspot/utils/states.dart';

class LanguageEditAddController extends GetxController {
  final _profileController = ProfileUserController.instance;

  List<LanguageModel> get langProfileList =>
      _profileController.profileState.languages;

  final _suggestionsLanguage = <LanguageModel>[].obs;

  List<LanguageModel> get suggestionsLanguage => _suggestionsLanguage.toList();

  Future<void> fetchSuggestionsLanguages() async {
    final response = await LanguageRepo.fetchLanguages();
    await response?.checkStatusResponse(
      onSuccess: (data, statusType) {
        Refresher.dataListUpdater(
          newData: data,
          currentData: suggestionsLanguage,
          updateData: (data) => _suggestionsLanguage.value = data,
        );
      },
      onValidateError: (validateError, statusType) {},
      onError: (message, statusType) {},
    );
  }

  static LanguageEditAddController get instance => Get.find();

  final _states = States().obs;

  States get states => _states.value;

  void successState(bool value, [String? message]) {
    _states.value = states.copyWith(isSuccess: value, message: message);
  }

  void warningState(bool value, [String? message]) {
    _states.value = states.copyWith(isWarning: value, message: message);
  }

  void resetState() {
    _states.value = States();
  }

  final _newLanguage = LanguageModel().obs;

  void resetNewLanguage() {
    _newLanguage.value = LanguageModel();
  }

  LanguageModel get newLanguage => _newLanguage.value;

  void setNewLanguage({
    int? id,
    String? name,
    bool? isNative,
    String? level,
  }) {
    _newLanguage.value = _newLanguage.value.copyWith(
      id: id,
      isNative: isNative,
      level: level,
      name: name,
    );
  }

  Future<void> addNewLanguage() async {
    final response = await LanguageRepo.addNewLanguage(newLanguage);
    await response?.checkStatusResponse(
      onSuccess: (data, statusType) async {
        if (data != null) {
          _profileController.profileState.languages = langProfileList
            ..add(data);
          print(langProfileList);
        } else {
          await _profileController.fetchUserLanguage();
        }
        successState(true, 'New language added successfully.');
      },
      onValidateError: (validateError, _) {
        _states.value =
            states.copyWith(isError: true, error: validateError?.message);
      },
      onError: (message, _) {
        _states.value = states.copyWith(isError: true, message: message);
      },
    );
  }

  Future<void> deleteLanguageById(int? id, int index) async {
    if (id == null) {
      return;
    }
    final response = await LanguageRepo.deleteLanguageById(id);
    await response?.checkStatusResponse(
      onSuccess: (data, _) async {
        if (data != null && data) {
          _profileController.profileState.languages = langProfileList
            ..removeAt(index);
        } else {
          await _profileController.fetchUserLanguage();
        }
        successState(true, 'Language deleted successfully.');
      },
      onValidateError: (validateError, _) {
        _states.value =
            states.copyWith(isError: true, error: validateError?.message);
      },
      onError: (message, _) {
        _states.value = states.copyWith(isError: true, message: message);
      },
    );
  }

  Future<void> onSavedSubmitted() async {
    if (!_profileController.netController.isConnected) {
      warningState(
        true,
        "sorry your connection is lost, please check your settings before continuing.",
      );
      return;
    }
    _states.value = states.copyWith(isLoading: true);
    if (newLanguage.id == null) {
      print("Lang.onSavedSubmitted: select language before submission.");
      warningState(true, "select language before submission.");
    } else if (!langProfileList.any((e) => e.id == newLanguage.id)) {
      await addNewLanguage();
    }
    _states.value = states.copyWith(isLoading: false);
  }

  Future<void> onDeletedSubmitted(int? id, int index) async {
    if (!_profileController.netController.isConnected) {
      warningState(
        true,
        "sorry your connection is lost, please check your settings before continuing.",
      );
      return;
    }
    _states.value = states.copyWith(isLoading: true);
    await deleteLanguageById(id, index);
    _states.value = states.copyWith(isLoading: false);
  }

  @override
  void onInit() {
    (() async {
      await fetchSuggestionsLanguages();
    })();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

class LanguageState {}
