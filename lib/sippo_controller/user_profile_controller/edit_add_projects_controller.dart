import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jobspot/sippo_controller/user_profile_controller/profile_user_controller.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/user_projects_model.dart';
import 'package:jobspot/sippo_data/user_repos/user_projects_repo.dart';
import 'package:jobspot/utils/getx_text_editing_controller.dart';
import 'package:jobspot/utils/helper.dart' as helper;
import 'package:jobspot/utils/states.dart';

import 'package:jobspot/custom_app_controller/switch_status_controller.dart';

class EditAddProjectsController extends GetxController {
  EditAddProjectsState projectState = EditAddProjectsState();
  final formKey = GlobalKey<FormState>();
  final loadingOverly = SwitchStatusController();

  static EditAddProjectsController get instance => Get.find();
  final _states = States().obs;

  States get states => _states.value;

  void successState(bool value, [String? message]) {
    _states.value = states.copyWith(isSuccess: value, message: message);
  }

  void warningState(bool value, [String? message]) {
    _states.value = states.copyWith(isWarning: value, message: message);
  }

  final _profileUserController = ProfileUserController.instance;
  final projects = UserProjectsModel().obs;

  bool isTextLoading(bool isEmptyValue) {
    return isEmptyValue && states.isLoading;
  }

  bool get isEditing => _profileUserController.editingId != -1;

  Future<void> addNewProjects() async {
    // make response
    final response = await UserProjectRepo.addProject(projectState.form);
    // check response
    await response?.checkStatusResponse(
      onSuccess: (data, statusType) {
        if (data == null) {
          _profileUserController.fetchAllProjects();
        } else {
          _profileUserController.profileState.projectsList =
              _profileUserController.profileState.projectsList..add(data);
        }
        _states.value = states.copyWith(isSuccess: true);
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

  Future<void> updateProjectById() async {
    final newProject = projectState.formWithId(projects.value.id);
    if (newProject == projects.value) {
      print(
        "EditAddProjectsController.updateWorkExperience: "
        "nothing change ? = ${newProject == projects.value}",
      );
      return warningState(true, "nothing is changed in the work experience.");
    }
    // make response
    final response = await UserProjectRepo.updateProjectsById(
      newProject,
      projects.value.id,
    );
    // check response
    await response?.checkStatusResponse(
      onSuccess: (data, _) async {
        if (data != null) {
          final oldDataIndex =
              _profileUserController.profileState.projectsList.indexWhere(
            (e) => e.id == data.id,
          );
          if (oldDataIndex == -1) {
            print("updateProjectById: not found.");
          } else {
            _profileUserController.profileState.projectsList =
                _profileUserController.profileState.projectsList
                  ..[oldDataIndex] = data;
            projects.value = data;
          }
        } else {
          await _profileUserController.fetchAllWorkExperience();
        }
        successState(true, 'the project updated successfully.');
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

  // Future<UserProjectsModel?> getProjectById(int id) async {
  //   final response = await UserProjectRepo.getProjectById(id);
  //   final data = await response?.checkStatusResponseAndGetData(
  //     onSuccess: (data, statusType) {
  //       // _states.value = states.copyWith(isSuccess: true);
  //     },
  //     onValidateError: (validateError, _) {
  //       _states.value =
  //           states.copyWith(isError: true, error: validateError?.message);
  //     },
  //     onError: (message, _) {
  //       _states.value = states.copyWith(isError: true, error: message);
  //     },
  //   );
  //   return data;
  // }

  Future<void> deleteProjectById() async {
    if (projects.value.id == null) {
      print(
        "EditAddProjectsController.deleteProjectById: is _project.value.id==null ? = ${projects.value.id == null}",
      );
      return;
    }
    final response = await UserProjectRepo.deleteProjectById(
      projects.value.id,
    );
    await response?.checkStatusResponse(
      onSuccess: (data, _) async {
        if (data != null && data) {
          print(
            "EditAddProjectsController.deleteProjectById checkStatusResponse : work experience is deleted.",
          );
          final oldData = _profileUserController.profileState.projectsList;
          oldData.removeWhere((e) => e.id == projects.value.id);
          _profileUserController.profileState.projectsList = oldData;
          _states.value = states.copyWith(isSuccess: true);
        } else {
          await _profileUserController.fetchAllProjects();
        }
        _profileUserController.editingId = -1;
        projects.value = UserProjectsModel();
        projectState.clearFields();
        successState(true, 'the project is deleted successfully.');
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
    // if (isEditing) {
    //   // print(await getProjectById(_profileUserController.editingId));
    //   // projects.value =
    //   //     await getProjectById(_profileUserController.editingId) ??
    //   //         projects.value;
    // }
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
    _states.value = States(isLoading: true);
    if (isEditing)
      await updateProjectById();
    else
      await addNewProjects();
    _states.value = states.copyWith(isLoading: false);
  }

  Future<void> onDeleteSubmitted() async {
    if (states.isLoading) return;
    _states.value = states.copyWith(isLoading: true);
    await deleteProjectById();
    _states.value = states.copyWith(isLoading: false);
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
    _profileUserController.editingId = -1;
    loadingOverly.dispose();
    projectState.disposeTextControllers();
    super.onClose();
  }
}

class EditAddProjectsState {
  final name = GetXTextEditingController();
  final desc = GetXTextEditingController();
  final date = GetXTextEditingController();

  void clearFields() {
    name.controller.text = "";
    desc.controller.text = "";
    date.controller.text = "";
  }

  void setAll(UserProjectsModel? data) {
    print("setAll: $data");
    name.controller.text = data?.name ?? "";
    desc.controller.text = data?.description ?? "";
    date.controller.text = helper.customDateFormatter(
      data?.date ?? '',
      "yyyy-MM-dd",
    );
  }

  UserProjectsModel get form => UserProjectsModel(
        name: name.controller.text,
        description: desc.controller.text,
        date: date.controller.text,
      );

  UserProjectsModel formWithId(int? id) => UserProjectsModel(
        id: id,
        name: name.controller.text,
        description: desc.controller.text,
        date: date.controller.text,
      );

  void disposeTextControllers() {
    desc.dispose();
    date.dispose();
  }
}
