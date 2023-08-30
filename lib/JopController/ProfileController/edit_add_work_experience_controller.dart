import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jobspot/JopController/ProfileController/profile_user_controller.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/work_experiences_model.dart';
import 'package:jobspot/sippo_data/profile_user/work_experiences_repo.dart';

import '../../utils/states.dart';

class EditAddWorkExperienceController extends GetxController {
  final _title = "".obs;
  final _company = "".obs;
  final startDate = TextEditingController();
  final endDate = TextEditingController();
  final _description = "".obs;
  final _isCurrentJob = false.obs;

  static EditAddWorkExperienceController get instance => Get.find();
  final _states = States().obs;

  States get states => _states.value;

  WorkExperiencesModel get workExForm => WorkExperiencesModel(
        company: company,
        description: description,
        endDate: endDate.text,
        isCurrentJob: isCurrentJob,
        jobTitle: title,
        startDate: startDate.text,
      );

  final _profileUserController = ProfileUserController.instance;
  final Rx<WorkExperiencesModel?> _workExperience = WorkExperiencesModel().obs;

  // Future<WorkExperiencesModel?> _getWorkExperienceById(int id) async {
  //   return null;
  // }

  bool get isEditing => _profileUserController.editingId != -1;

  Future<void> updateWorkExperienceById() async {
    final newWorkEx = workExForm..id = _workExperience.value?.id;
    if (newWorkEx == _workExperience.value) return;
    // make response
    final response = await WorkExperiencesRepo.updateWorkExperiencesById(
      newWorkEx,
      _workExperience.value?.id,
    );
    // check response
    await response?.checkStatusResponse(
      onSuccess: (data, statusType) async {
        if (data == null) {
          await _profileUserController.fetchAllWorkExperience();
          return;
        }
        final oldDataIndex = _profileUserController.wei.indexWhere((e) {
          return e.id == data.id;
        });
        if (oldDataIndex == -1) {
          print("updateWorkExperienceById: not found.");
          return;
        }
        _profileUserController.wei = _profileUserController.wei
          ..[oldDataIndex] = data;
      },
      onValidateError: (validateError, statusType) {
        /* handle validation errors response */
      },
      onError: (message, statusType) {
        /* handle other error response */
      },
    );
    return null;
  }

  Future<void> addNewWorkExperience() async {
    // make response
    final response = await WorkExperiencesRepo.addWorkExperiences(workExForm);
    // check response
    await response?.checkStatusResponse(
      onSuccess: (data, statusType) async {
        if (data == null) {
          await _profileUserController.fetchAllWorkExperience();
          return;
        }
        _profileUserController.wei = _profileUserController.wei..add(data);
      },
      onValidateError: (validateError, statusType) {
        /* handle validation errors response */
      },
      onError: (message, statusType) {
        /* handle other error response */
      },
    );
    return null;
  }

  Future<void> openEditing() async {
    if (!isEditing) return;
    // _workExperience.value = await _getWorkExperienceById(
    //   _profileUserController.editingId,
    // );
    final editingWorkEx = _profileUserController.wei.firstWhereOrNull((e) {
      return e.id == _profileUserController.editingId;
    });
    print("openEditing: is editing work experience is null ? ${editingWorkEx == null}");
    if (editingWorkEx == null) return;
    _workExperience.value = editingWorkEx;
    _title.value = _workExperience.value?.jobTitle ?? "";
    _company.value = _workExperience.value?.company ?? "";
    startDate.text = _workExperience.value?.startDate ?? "";
    endDate.text = _workExperience.value?.endDate ?? "";
    _description.value = _workExperience.value?.description ?? "";
    _isCurrentJob.value = _workExperience.value?.isCurrentJob ?? false;
  }

  Future<void> onSaveSubmitted() async {
    if (isEditing) {
      await updateWorkExperienceById();
      return;
    }
    await addNewWorkExperience();
  }

  @override
  void onInit() {
    super.onInit();
    openEditing();
  }

  @override
  void onClose() {
    _profileUserController.editingId = -1;
    super.onClose();
  }

  String get title => _title.toString();

  String get company => _company.toString();

  String get description => _description.toString();

  bool get isCurrentJob => _isCurrentJob.isTrue;

  void clearFields() {
    _title.value = "";
    _company.value = "";
    startDate.text = "";
    endDate.text = "";
    _description.value = "";
    _isCurrentJob.value = false;
  }

  void set title(String value) {
    _title.value = value.trim();
  }

  void set company(String value) {
    _company.value = value.trim();
  }

  void set description(String value) {
    _description.value = value.trim();
  }

  void set isCurrentJob(bool value) {
    _isCurrentJob.value = value;
  }
}
