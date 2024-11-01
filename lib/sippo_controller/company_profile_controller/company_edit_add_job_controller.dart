import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/sippo_customstyle.dart';
import 'package:sippo/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:sippo/sippo_data/company_repos/company_job_repo.dart';
import 'package:sippo/sippo_data/model/auth_model/company_response_details.dart';
import 'package:sippo/sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';
import 'package:sippo/sippo_data/model/profile_model/company_profile_resource_model/cord_location.dart';
import 'package:sippo/sippo_data/model/profile_model/company_profile_resource_model/work_location_model.dart';
import 'package:sippo/sippo_data/model/salary_model/range_salary_model.dart';
import 'package:sippo/sippo_data/model/specializations_model/specializations_model.dart';
import 'package:sippo/utils/states.dart';
import 'package:sippo/utils/string_formtter.dart';

import '../dashboards_controller/company_dashboard_controller.dart';

class CompanyEditAddJobController extends GetxController {
  static CompanyEditAddJobController get instance => Get.find();
  final newJobState = CompanyEditAddJobState();
  final _states = States().obs;
  final _dashboardController = CompanyDashBoardController.instance;
  final _job = CompanyJobModel().obs;

  bool get isNetworkConnection =>
      InternetConnectionService.instance.isConnected;

  CompanyDetailsModel get company => _dashboardController.company;

  bool get isEditing {
    print(_dashboardController.dashboardState.editId);
    return _dashboardController.dashboardState.editId != -1;
  }

  void changeStates({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    bool? isWarning,
    String? message,
    String? error,
  }) {
    _states.value = states.copyWith(
      message: isLoading == true ? '' : message,
      isSuccess: isLoading == true ? false : isSuccess,
      isError: isLoading == true ? false : isError,
      isWarning: isLoading == true ? false : isWarning,
      isLoading: isLoading,
    );
  }

  Future<void> addNewJob() async {
    final response = await CompanyJobRepo.addNewJob(newJobState.form);
    await response?.checkStatusResponse(
      onSuccess: (data, _) {
        if (data != null) {
          popOut();
        }
      },
      onValidateError: (validateError, _) {
        changeStates(
          isError: true,
          message: validateError?.message,
        );
      },
      onError: (message, _) {
        changeStates(
          isError: true,
          message: "error_occurred_message".tr,
        );
      },
    );
  }

  Future<void> updateJob(int? jobId) async {
    final newJob = newJobState.form..id = _job.value.id;
    if (newJob == _job.value) {
      print(newJob);
      print(_job.value);

      print(
        "CompanyEditAddJobController.updateJob: "
        "nothing change ? = "
        "${newJob == _job.value}",
      );
      return changeStates(
        isWarning: true,
        message: "nothing_changed_job_message".tr,
      );
    }
    final response = await CompanyJobRepo.updateJob(newJobState.form, jobId);
    await response?.checkStatusResponse(
      onSuccess: (data, _) {
        if (data != null) {
          popOut();
        }
      },
      onValidateError: (validateError, _) {
        changeStates(
          isError: true,
          message: validateError?.message,
        );
      },
      onError: (message, _) {
        changeStates(
          isError: true,
          message: "error_occurred_message".tr,
        );
      },
    );
  }

  Future<CompanyJobModel?> getJobById(int id) async {
    final response = await CompanyJobRepo.getJobById(id);
    final data = await response?.checkStatusResponseAndGetData(
      onValidateError: (validateError, _) {
        changeStates(isError: true, error: validateError?.message);
      },
      onError: (message, _) {
        changeStates(isError: true, error: message);
      },
    );
    print(data);
    return data?.copyForEdit();
  }

  Future<void> fetchExperienceLevels() async {
    final response = await CompanyJobRepo.fetchExperienceLevels();
    await response?.checkStatusResponse(
      onSuccess: (data, _) =>
          {if (data != null) newJobState.experienceLevelList = data},
      onValidateError: (validateError, _) {},
      onError: (message, _) {},
    );
  }

  Future<void> fetchEmploymentTypes() async {
    final response = await CompanyJobRepo.fetchEmploymentTypes();
    await response?.checkStatusResponse(
      onSuccess: (data, _) =>
          {if (data != null) newJobState.employmentTypeList = data},
      onValidateError: (validateError, _) {},
      onError: (message, _) {},
    );
  }

  Future<void> onSavedSubmitted() async {
    if (!isNetworkConnection) {
      return changeStates(
        isWarning: true,
        message: "connection_lost_message_1".tr,
      );
    }
    changeStates(isLoading: true);
    if (isEditing) {
      print('isEditing true');
      await updateJob(_dashboardController.dashboardState.editId);
    } else {
      print('isEditing false');
      await addNewJob();
    }
    changeStates(isLoading: false);
  }

  Future<void> openEditing() async {
    if (isEditing) {
      final editingId = _dashboardController.dashboardState.editId;
      _job.value = await getJobById(editingId) ?? _job.value;
      print(_job.value);
      if (_job.value.id != null)
        newJobState.setAll(
          _job.value,
        );
    }
  }

  States get states => _states.value;

  void popOut() {
    final localIsEditing = isEditing;
    Get.back(result: true, closeOverlays: true);
    Get.snackbar(
      localIsEditing ? 'edit_job'.tr : 'new_job'.tr,
      localIsEditing ? 'edit_job_done'.tr : 'job_added_successfully'.tr,
      boxShadows: [boxShadow],
      backgroundColor: SippoColor.backgroudHome,
    );
  }

  @override
  void onInit() {
    super.onInit();

    (() async {
      newJobState.specializationList =
          company.specializations?.where((e) => e.name != null).toList() ?? [];
      newJobState.locationsList =
          company.locations?.where((e) => e.locationAddress != null).toList() ??
              [];
      newJobState.workPLaceTypeList = [
        (title: "Onsite", description: "Employees come to work"),
        (
          title: "Hybrid",
          description: "Employees work directly on site or off site"
        ),
        (
          title: "Remote",
          description: "Employees working off site",
        ),
      ];
      changeStates(isLoading: true);
      await Future.wait([
        fetchExperienceLevels(),
        fetchEmploymentTypes(),
        openEditing(),
      ]);
      changeStates(isLoading: false);
    })();
  }

  @override
  void onClose() {
    newJobState.dispose();
    super.onClose();
  }
}

class CompanyEditAddJobState {
  ({
    String? createdAt,
    bool? isExpired,
    bool? hasApplied,
    bool? isActive
  })? extraInfo;
  static const MAX_SALARY_RANGE = 100000.0;
  static const MIN_SALARY_RANGE = 0.0;
  static const DIVISION = (MAX_SALARY_RANGE - MIN_SALARY_RANGE) ~/ 100;
  final _position = "".obs;
  final _showActionPosition = true.obs;
  final _requirements = "".obs;
  final _showActionRequirements = true.obs;
  final _jobLocation = WorkLocationModel().obs;
  final _showActionLocation = true.obs;
  final _workPLaceType = "".obs;
  final _employmentType = "".obs;
  final _experienceLevel = ExperienceLevel().obs;
  final _specialization = SpecializationModel().obs;
  final _showActionSpecialization = true.obs;

  final _rangeSalary = RangeValues(1500.0, 3500.0).obs;

  var salary = RangeSalaryModel();
  final salaryFrom = TextEditingController();
  final salaryTo = TextEditingController();
  final _showActionSalary = true.obs;

  final _description = "".obs;
  final _showActionDescription = true.obs;

  CompanyJobModel get form => CompanyJobModel(
        title: position,
        requirements: requirements,
        description: description,
        workplaceType: workPLaceType,
        employmentType: employmentType,
        locationAddress: jobLocation.locationAddress,
        longitude: jobLocation.cordLocation?.dLongitude,
        latitude: jobLocation.cordLocation?.dLatitude,
        salaryFrom: salary.from,
        salaryTo: salary.to,
        experienceLevel: experienceLevel,
        specialization: specialization,
        hasApplied: extraInfo?.hasApplied,
        isActive: extraInfo?.isActive,
        isExpired: extraInfo?.isExpired,
        createdAt: extraInfo?.createdAt,
      );
  final _locationsList = <WorkLocationModel>[].obs;
  final _specializationList = <SpecializationModel>[].obs;
  final _experienceLevelList = <ExperienceLevel>[].obs;
  final _workPLaceTypeList = <({String title, String description})>[].obs;
  final _employmentTypeList = <String>[].obs;

  void setAll(CompanyJobModel? value) {
    extraInfo = (
      createdAt: value?.createdAt,
      hasApplied: value?.hasApplied,
      isActive: value?.isActive,
      isExpired: value?.isExpired,
    );
    position = value?.title ?? "";
    requirements = value?.requirements ?? "";
    workPLaceType = value?.workplaceType ?? "";
    employmentType = value?.employmentType ?? "";
    description = value?.description ?? "";
    if (value?.experienceLevel != null)
      experienceLevel = value!.experienceLevel!;
    if (value?.specialization != null) specialization = value!.specialization!;
    jobLocation = WorkLocationModel(
      locationAddress: value?.locationAddress,
      cordLocation: CoordLocation(
        longitude: value?.longitude.toString(),
        latitude: value?.latitude.toString(),
      ),
    );
    salary = RangeSalaryModel(from: value?.salaryFrom, to: value?.salaryTo);
    if (salary.from != null && salary.to != null)
      setSalaryRange(RangeValues(salary.from!, salary.to!));
  }

  List<({String title, String description})> get workPLaceTypeList =>
      _workPLaceTypeList.toList();

  void set workPLaceTypeList(List<({String title, String description})> value) {
    _workPLaceTypeList.value = value;
  }

  List<SpecializationModel> get specializationList => _specializationList;

  void set specializationList(List<SpecializationModel> value) {
    _specializationList.value = value;
  }

  List<String> get employmentTypeList => _employmentTypeList.toList();

  void set employmentTypeList(List<String> value) {
    _employmentTypeList.value = value;
  }

  List<ExperienceLevel> get experienceLevelList =>
      _experienceLevelList.toList();

  void set experienceLevelList(List<ExperienceLevel> value) {
    _experienceLevelList.value = value;
  }

  List<WorkLocationModel> get locationsList => _locationsList.toList();

  void set locationsList(List<WorkLocationModel> value) {
    _locationsList.value = value;
  }

  String get position => _position.trim();

  void set position(String value) {
    _position.value = value;
  }

  String get requirements => _requirements.trim();

  void set requirements(String value) {
    _requirements.value = value;
  }

  SpecializationModel get specialization => _specialization.value;

  void set specialization(SpecializationModel value) {
    _specialization.value = value;
  }

  String get description => _description.trim();

  void set description(String value) {
    _description.value = value;
  }

  RangeValues get rangeSalary => _rangeSalary.value;

  void setSalaryRangeText() {
    final from = double.parse(
      salaryFrom.text.isEmpty ? rangeSalary.start.toString() : salaryFrom.text,
    );
    final to = double.parse(
      salaryTo.text.isEmpty ? rangeSalary.end.toString() : salaryTo.text,
    );
    if ((from < MIN_SALARY_RANGE || from > to || from > MAX_SALARY_RANGE) ||
        (to < MIN_SALARY_RANGE || to < from || to > MAX_SALARY_RANGE)) {
      return;
    }
    salary = salary.copyWith(
      from: from,
      to: to,
    );
    _rangeSalary.value = RangeValues(from, to);
  }

  void setSalaryRange(RangeValues value) {
    salaryFrom.text = value.start.round().toString();
    salaryTo.text = value.end.round().toString();
    salary = salary.copyWith(from: value.start, to: value.end);
    _rangeSalary.value = value;
  }

  String? get salaryForamat {
    if (salary.from == null || salary.to == null) return null;
    if (salary.from! < 0 || salary.to! < salary.from!) return null;
    return "${rangeSalary.start.round().toString().shortStringNumberFormat} - ${rangeSalary.end.round().toString().shortStringNumberFormat}";
  }

  ExperienceLevel get experienceLevel => _experienceLevel.value;

  void set experienceLevel(ExperienceLevel value) {
    _experienceLevel.value = value;
  }

  String get employmentType => _employmentType.trim();

  void set employmentType(String value) {
    _employmentType.value = value;
  }

  String get workPLaceType => _workPLaceType.trim();

  void set workPLaceType(String value) {
    _workPLaceType.value = value;
  }

  WorkLocationModel get jobLocation => _jobLocation.value;

  void set jobLocation(WorkLocationModel value) {
    _jobLocation.value = value;
  }

  bool get showActionPosition => _showActionPosition.isTrue;

  void swithcActionPosition() => _showActionPosition.toggle();

  bool get showActionLocation => _showActionLocation.isTrue;

  void swithcActionLocation() => _showActionLocation.toggle();

  bool get showActionRequirements => _showActionRequirements.isTrue;

  void swithcActionRequirements() => _showActionRequirements.toggle();

  bool get showActionDescription => _showActionDescription.isTrue;

  void swithcActionDescription() => _showActionDescription.toggle();

  bool get showActionSalary => _showActionSalary.isTrue;

  void swithcActionSalary() => _showActionSalary.toggle();
  bool get showActionSpecialization => _showActionSpecialization.isTrue;

  void swithcActionSpecialization() => _showActionSpecialization.toggle();

  void showAllActionButtonOptions() {
    _showActionSalary.value = true;
    _showActionDescription.value = true;
    _showActionRequirements.value = true;
    _showActionLocation.value = true;
    _showActionPosition.value = true;
    _showActionSpecialization.value = true;
  }

  List<String> get locationsLabel {
    return List.generate(locationsList.length, (index) {
      final name = locationsList[index].locationAddress?.name ?? '';
      return "${index + 1}. $name";
    });
  }

  List<String> get specializationLabel =>
      specializationList.map((e) => e.name!).toList();
  void dispose() {
    salaryTo.dispose();
    salaryFrom.dispose();
  }
}
