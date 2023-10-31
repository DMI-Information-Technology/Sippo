import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jobspot/sippo_controller/user_profile_controller/profile_user_controller.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/work_experiences_model.dart';
import 'package:jobspot/sippo_data/user_repos/work_experiences_repo.dart';

import 'package:jobspot/utils/getx_text_editing_controller.dart';
import 'package:jobspot/utils/helper.dart' as helper;
import 'package:jobspot/utils/states.dart';

class EditAddWorkExperienceController extends GetxController {
  EditAddWorkExperienceState workExState = EditAddWorkExperienceState();
  final GlobalKey<FormState> formKey = GlobalKey();

  static EditAddWorkExperienceController get instance => Get.find();
  final _states = States().obs;

  States get states => _states.value;

  void successState(bool value, [String? message]) {
    _states.value = states.copyWith(isSuccess: value, message: message);
  }

  void warningState(bool value, [String? message]) {
    _states.value = states.copyWith(isWarning: value, message: message);
  }

  final _profileUserController = ProfileUserController.instance;
  final _workExperience = WorkExperiencesModel().obs;

  bool isTextLoading(bool isEmptyValue) {
    return isEmptyValue && states.isLoading;
  }

  bool get isEditing => _profileUserController.editingId != -1;

  Future<void> addNewWorkExperience() async {
    // make response
    final response =
        await WorkExperiencesRepo.addWorkExperiences(workExState.form);
    // check response
    await response?.checkStatusResponse(
      onSuccess: (data, statusType) async {
        if (data == null) {
          await _profileUserController.fetchAllWorkExperience();
        } else {
          _profileUserController.profileState.workExList =
              _profileUserController.profileState.workExList..add(data);
        }
        successState(true, 'new work experience is added successfully.');
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

  Future<void> updateWorkExperienceById() async {
    final newWorkEx = workExState.form..id = _workExperience.value.id;
    if (newWorkEx == _workExperience.value) {
      print(
        "EditAddWorkExController.updateWorkExperience: "
        "nothing change ? = ${newWorkEx == _workExperience.value}",
      );
      return warningState(true, "nothing is changed in the work experience.");
    }
    // make response
    final response = await WorkExperiencesRepo.updateWorkExperiencesById(
      newWorkEx,
      _workExperience.value.id,
    );
    // check response
    await response?.checkStatusResponse(
      onSuccess: (data, _) async {
        if (data != null) {
          final oldDataIndex =
              _profileUserController.profileState.workExList.indexWhere(
            (e) {
              return e.id == data.id;
            },
          );
          if (oldDataIndex == -1) {
            print("updateWorkExperienceById: not found.");
          } else {
            _profileUserController.profileState.workExList =
                _profileUserController.profileState.workExList
                  ..[oldDataIndex] = data;
            _workExperience.value = data;
          }
        } else {
          await _profileUserController.fetchAllWorkExperience();
        }
        successState(true, 'the work experience updated successfully.');
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

  Future<WorkExperiencesModel?> getWorkExperienceById(int id) async {
    final response = await WorkExperiencesRepo.getWorkExperiencesById(id);
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

  Future<void> deleteWorkExperienceById() async {
    if (_workExperience.value.id == null) {
      print(
        "EditAddWorkExController.deleteWorkExperience: is _workExperience.value.id==null ? = ${_workExperience.value.id == null}",
      );
      return;
    }
    final response = await WorkExperiencesRepo.deleteWorkExperiencesById(
      _workExperience.value.id,
    );
    await response?.checkStatusResponse(
      onSuccess: (data, _) async {
        if (data != null && data) {
          print(
            "EditAddExController.deleteWorkExperienceById checkStatusResponse : work experience is deleted.",
          );
          final oldData = _profileUserController.profileState.workExList;
          oldData.removeWhere((e) => e.id == _workExperience.value.id);
          _profileUserController.profileState.workExList = oldData;
          _states.value = states.copyWith(isSuccess: true);
        } else {
          await _profileUserController.fetchAllWorkExperience();
        }
        _profileUserController.editingId = -1;
        _workExperience.value = WorkExperiencesModel();
        workExState.clearFields();
        successState(true, 'the work experience is deleted successfully.');
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

  Future<void> openEditing() async {
    _states.value = states.copyWith(isLoading: true);
    if (isEditing) {
      _workExperience.value =
          await getWorkExperienceById(_profileUserController.editingId) ??
              _workExperience.value;
      if (_workExperience.value.id != null)
        workExState.setAll(
          _workExperience.value,
        );
    }
    _states.value = states.copyWith(isLoading: false);
  }

  Future<void> onSaveSubmitted() async {
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
      await updateWorkExperienceById();
    else
      await addNewWorkExperience();
    _states.value = states.copyWith(isLoading: false);
  }

  Future<void> onDeleteSubmitted() async {
    if (states.isLoading) return;
    _states.value = states.copyWith(isLoading: true);
    await deleteWorkExperienceById();
    _states.value = states.copyWith(isLoading: false);
  }

  @override
  void onInit() {
    super.onInit();
    openEditing();
  }

  @override
  void onClose() {
    _profileUserController.editingId = -1;
    workExState.disposeTextControllers();
    super.onClose();
  }
}

class EditAddWorkExperienceState {
  final title = GetXTextEditingController();
  final company = GetXTextEditingController();
  final startDate = GetXTextEditingController();
  final endDate = GetXTextEditingController();
  final description = GetXTextEditingController();
  final _isCurrentJob = false.obs;

  bool get isCurrentJob => _isCurrentJob.isTrue;

  void clearFields() {
    title.controller.text = "";
    company.controller.text = "";
    startDate.controller.text = "";
    endDate.controller.text = "";
    description.controller.text = "";
    _isCurrentJob.value = false;
  }

  void setAll(WorkExperiencesModel? data) {
    print("setAll: $data");
    title.controller.text = data?.jobTitle ?? "";
    company.controller.text = data?.company ?? "";
    startDate.controller.text = helper.customDateFormatter(
      data?.startDate ?? '',
      "yyyy-MM-dd",
    );
    endDate.controller.text = helper.customDateFormatter(
      data?.endDate ?? '',
      "yyyy-MM-dd",
    );
    description.controller.text = data?.description ?? "";
    isCurrentJob = data?.isCurrentJob ?? false;
  }

  void set isCurrentJob(bool value) {
    _isCurrentJob.value = value;
  }

  WorkExperiencesModel get form => WorkExperiencesModel(
        company: company.controller.text,
        description: description.controller.text,
        endDate: endDate.controller.text,
        isCurrentJob: isCurrentJob,
        jobTitle: title.controller.text,
        startDate: startDate.controller.text,
      );

  void disposeTextControllers() {
    title.dispose();
    company.dispose();
    description.dispose();
    endDate.dispose();
    startDate.dispose();
  }
}
