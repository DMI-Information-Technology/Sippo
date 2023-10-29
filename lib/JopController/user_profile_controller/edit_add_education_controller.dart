import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JopController/user_profile_controller/profile_user_controller.dart';
import 'package:jobspot/custom_app_controller/switch_status_controller.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/education_model.dart';
import 'package:jobspot/sippo_data/user_repos/education_repo.dart';
import 'package:jobspot/utils/getx_text_editing_controller.dart';
import 'package:jobspot/utils/helper.dart' as helper;
import 'package:jobspot/utils/states.dart';

class EditAddEducationController extends GetxController {
  static EditAddEducationController get instance => Get.find();
  final GlobalKey<FormState> formKey = GlobalKey();
  final loadingOverly = SwitchStatusController();
  final _states = States().obs;

  States get states => _states.value;
  final eduState = EditAddEducationState();

  final _profileUserController = ProfileUserController.instance;

  List<EducationModel> get educationProfileList =>
      _profileUserController.profileState.educationList;

  void successState(bool value, [String? message]) {
    _states.value = states.copyWith(isSuccess: value, message: message);
  }

  void warningState(bool value, [String? message]) {
    _states.value = states.copyWith(isWarning: value, message: message);
  }

  final _education = EducationModel().obs;

  bool isTextLoading(bool isEmptyValue) {
    return isEmptyValue && states.isLoading;
  }

  int get editingId => _profileUserController.editingId;

  bool get isEditing => _profileUserController.editingId != -1;

  Future<void> addNewEducation() async {
    // make response
    final response = await EducationRepo.addEducation(eduState.form);
    // check response
    await response?.checkStatusResponse(
      onSuccess: (data, statusType) async {
        if (data != null) {
          _profileUserController.profileState.educationList =
              educationProfileList..add(data);
        } else {
          await _profileUserController.fetchAllEducation();
        }
        successState(true, 'new education is added successfully.');
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

  Future<void> updateEducationById() async {
    final newEdu = eduState.form..id = _education.value.id;
    if (newEdu == _education.value) {
      print(
        "EditAddEducationController.updateEducationById: "
        "nothing change ? = ${newEdu == _education.value}",
      );
      return warningState(true, "nothing is changed in the education.");
    }
    final response = await EducationRepo.updateEducationById(
      eduState.form,
      _education.value.id,
    );
    await response?.checkStatusResponse(
      onSuccess: (data, _) async {
        if (data != null) {
          final oldDataIndex = educationProfileList.indexWhere(
            (e) {
              return e.id == data.id;
            },
          );
          if (oldDataIndex == -1) {
            print("updateEducationById: not found.");
          } else {
            _profileUserController.profileState.educationList =
                educationProfileList..[oldDataIndex] = data;
            _education.value = data;
          }
        } else {
          await _profileUserController.fetchAllEducation();
        }
        successState(true, 'the education updated successfully.');
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

  Future<EducationModel?> getEducationById(int id) async {
    final response = await EducationRepo.getEducationById(id);
    final data = await response?.checkStatusResponseAndGetData(
      onSuccess: (data, statusType) {
        // _states.value = states.copyWith(isSuccess: true);
      },
      onValidateError: (validateError, _) {
        _states.value =
            states.copyWith(isError: true, error: validateError?.message);
      },
      onError: (message, _) {
        _states.value = states.copyWith(isError: true, error: message);
      },
    );
    return data;
  }

  Future<void> deleteEducationById() async {
    if (_education.value.id == null) {
      print(
        "EditAddEducationController.deleteEducation: is _education.value.id==null ? = ${_education.value.id == null}",
      );
      return;
    }
    final response = await EducationRepo.deleteEducationById(
      _education.value.id,
    );
    await response?.checkStatusResponse(
      onSuccess: (data, _) async {
        if (data != null && data) {
          print(
            "EditAddEducationController.deleteEducationById checkStatusResponse : education is deleted.",
          );
          final oldData = educationProfileList
            ..removeWhere((e) => e.id == _education.value.id);
          _profileUserController.profileState.educationList = oldData;
          _states.value = states.copyWith(isSuccess: true);
        } else {
          await _profileUserController.fetchAllEducation();
        }
        _profileUserController.editingId = -1;
        _education.value = EducationModel();
        eduState.clearFields();
        successState(true, 'the education is deleted successfully.');
      },
      onValidateError: (validateError, _) {
        _states.value =
            states.copyWith(isError: true, error: validateError?.message);
      },
      onError: (message, _) {
        _states.value = states.copyWith(isError: true, error: message);
      },
    );
  }

  Future<void> onSavedSubmitted() async {
    if (!_profileUserController.netController.isConnected) {
      warningState(
        true,
        "sorry your connection is lost, please check your settings before continuing.",
      );
      return;
    }
    if (states.isLoading) return;
    _states.value = states.copyWith(isLoading: true);
    if (isEditing)
      await updateEducationById();
    else
      await addNewEducation();
    _states.value = states.copyWith(isLoading: false);
  }

  Future<void> onDeleteSubmitted() async {
    if (states.isLoading) return;
    _states.value = States(isLoading: true);
    await deleteEducationById();
    _states.value = states.copyWith(isLoading: false);
  }

  Future<void> openEditing() async {
    _states.value = States(isLoading: true);
    if (isEditing) {
      _education.value = await getEducationById(editingId) ?? _education.value;
      if (_education.value.id != null) eduState.setAll(_education.value);
    }
    _states.value = states.copyWith(isLoading: false);
    print("isLoading: ${states.isLoading}");
  }

  StreamSubscription<States>? statesSubs;

  @override
  void onInit() {
    statesSubs = _states.listen((value) {
      if (value.isLoading) {
        loadingOverly.start();
      } else {
        loadingOverly.pause();
      }
    });
    super.onInit();
    openEditing();
  }

  @override
  void onClose() {
    eduState.disposeTextControllers();
    loadingOverly.dispose();
    _profileUserController.editingId = -1;
    super.onClose();
  }
}

class EditAddEducationState {
  final data = [
    "Associate's Degree",
    "Bachelor's Degree",
    "Master's Degree",
    "Doctorate (Ph.D.)",
    "Doctor of Education (Ed.D.)",
    "Doctor of Philosophy in Education (Ph.D. in Education)",
    "Bachelor of Arts in Education (B.A.Ed.)",
    "Bachelor of Science in Education (B.S.Ed.)",
    "Master of Arts in Teaching (M.A.T.)",
    "Master of Education (M.Ed.)",
    "Master of Science in Education (M.S.Ed.)",
    "Education Specialist (Ed.S.)",
    "Postgraduate Certificate in Education (PGCE)",
    "Certificate in Education (Cert.Ed.)",
    "Professional Development Programs"
  ];
  final level = GetXTextEditingController();
  final institution = GetXTextEditingController();
  final fieldStudy = GetXTextEditingController();
  final startDate = GetXTextEditingController();
  final endDate = GetXTextEditingController();
  final description = GetXTextEditingController();
  final _isCurrent = false.obs;

  bool get isCurrent => _isCurrent.isTrue;

  void set isCurrent(bool value) {
    _isCurrent.value = value;
  }

  void clearFields() {
    level.controller.text = "";
    institution.controller.text = "";
    fieldStudy.controller.text = "";
    startDate.controller.text = "";
    endDate.controller.text = "";
    description.controller.text = "";
    _isCurrent.value = false;
  }

  void setAll(EducationModel? data) {
    level.controller.text = data?.level ?? "";
    institution.controller.text = data?.institution ?? "";
    fieldStudy.controller.text = data?.field ?? "";

    startDate.controller.text = helper.customDateFormatter(
      data?.startDate ?? '2000-1-1',
      "yyyy-MM-dd",
    );
    endDate.controller.text = helper.customDateFormatter(
      data?.endDate ?? '2000-1-1',
      "yyyy-MM-dd",
    );

    description.controller.text = data?.description ?? "";
    _isCurrent.value = data?.isCurrent ?? false;
  }

  EducationModel get form => EducationModel(
        level: level.controller.text,
        institution: institution.controller.text,
        field: fieldStudy.controller.text,
        endDate: endDate.controller.text,
        startDate: startDate.controller.text,
        isCurrent: isCurrent,
        description: description.controller.text,
      );

  void disposeTextControllers() {
    level.dispose();
    institution.dispose();
    fieldStudy.dispose();
    description.dispose();
    endDate.dispose();
    startDate.dispose();
  }
}
