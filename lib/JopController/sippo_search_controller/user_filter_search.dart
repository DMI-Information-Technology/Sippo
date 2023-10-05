import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JopController/sippo_search_controller/user_search_jobs.dart';
import 'package:jobspot/sippo_data/company_repos/company_job_repo.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';
import 'package:jobspot/sippo_data/model/salary_model/range_salary_model.dart';
import 'package:jobspot/sippo_data/model/specializations_model/specializations_model.dart';
import 'package:jobspot/sippo_data/specializations/specializations_repo.dart';

class UserFilterSearchController extends GetxController {
  final filterSearchState = FilterSearchState();

  static UserFilterSearchController get instance => Get.find();
  final userSearchJobsController = UserSearchJobsController.instances;

  Future<void> fetchExperienceLevels() async {
    final response = await CompanyJobRepo.fetchExperienceLevels();
    await response?.checkStatusResponse(
      onSuccess: (data, _) =>
          {if (data != null) filterSearchState.experienceLevelList = data},
      onValidateError: (validateError, _) {},
      onError: (message, _) {},
    );
  }

  Future<void> fetchSpecializations() async {
    final response = await SpecializationRepo.fetchSpecializationsResource();
    await response?.checkStatusResponse(
      onSuccess: (data, _) {
        if (data != null) filterSearchState.specializationList = data;
      },
      onValidateError: (validateError, _) {},
      onError: (message, _) {},
    );
  }

  Future<void> onApplyFilterSubmitted() async {
    userSearchJobsController.searchJobsState.querySearch.addAll(
      filterSearchState.buildQueryFilterSearch,
    );
    userSearchJobsController.refreshPage();
  }

  @override
  void onInit() {
    super.onInit();
    filterSearchState.specializationFocusNode.addListener(() {
      refresh();
    });
    filterSearchState.workPLaceTypeList = [
      (value: '1', title: "Onsite"),
      (value: '2', title: "Hybrid"),
      (value: '3', title: "Remote"),
    ];
    Future.wait([
      fetchExperienceLevels(),
      fetchSpecializations(),
    ]);
  }

  @override
  void onClose() {
    // filterSearchState.close();
    super.onClose();
  }
}

class FilterSearchState {
  final _specializationSearch = "".obs;

  String get specializationsSearch => _specializationSearch.toString();

  set specializationsSearch(String value) =>
      _specializationSearch.value = value;
  final _experienceLevel = ExperienceLevel().obs;
  final specializationFocusNode = FocusNode();
  final _specialization = SpecializationModel().obs;

  final _rangeSalary = RangeValues(1500.0, 9500.0).obs;
  var salary = RangeSalaryModel();
  final _specializationList = <SpecializationModel>[].obs;
  final _experienceLevelList = <ExperienceLevel>[].obs;

  ExperienceLevel get experienceLevel => _experienceLevel.value;

  set experienceLevel(ExperienceLevel value) {
    if (value == experienceLevel) {
      experienceLevel = ExperienceLevel();
      return;
    }
    _experienceLevel.value = value;
  }

  SpecializationModel get specialization => _specialization.value;

  set specialization(SpecializationModel value) {
    if (value == specialization) {
      specialization = SpecializationModel();
      return;
    }
    _specialization.value = value;
  }

  RangeValues get rangeSalary => _rangeSalary.value;

  String get startSalary => rangeSalary.start.round().toString();

  String get endSalary => rangeSalary.end.round().toString();

  set rangeSalary(RangeValues value) {
    _rangeSalary.value = value;
  }

  List<SpecializationModel> get specializationList =>
      _specializationList.toList();

  List<SpecializationModel> filteredSpecializations(String searchKey) =>
      _specializationList.where((e) {
        final specialName = e.name;
        if (specialName == null || specialName.isEmpty) return false;
        return specialName.contains(searchKey.trim());
      }).toList();

  set specializationList(List<SpecializationModel> value) {
    _specializationList.value = value;
  }

  List<ExperienceLevel> get experienceLevelList =>
      _experienceLevelList.toList();

  set experienceLevelList(List<ExperienceLevel> value) {
    _experienceLevelList.value = value;
  }

  final Rx<({String? value, String? title})> _workPlaceType =
      (value: '', title: '').obs;

  ({String? value, String? title}) get workPlaceType => _workPlaceType.value;

  set workPlaceType(({String? value, String? title}) value) {
    _workPlaceType.value = value;
  }

  final _workPLaceTypeList = <({String value, String title})>[].obs;

  List<({String value, String title})> get workPLaceTypeList =>
      _workPLaceTypeList.toList();

  set workPLaceTypeList(List<({String value, String title})> value) {
    _workPLaceTypeList.value = value;
  }

  Map<String, String> get buildQueryFilterSearch => {
        'salary_from': rangeSalary.start.round().toString(),
        'salary_to': rangeSalary.end.round().toString(),
        'workplace_type': workPlaceType.value?.split(' ').join('+') ?? '',
        'experience_level': experienceLevel.value ?? '',
        'specialization_id': specialization.id?.toString() ?? '',
      };
// void close() {
//   specializationSearch.dispose();
// }
}
