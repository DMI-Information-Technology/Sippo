import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JopController/company_profile_controller/company_edit_add_job_controller.dart';
import 'package:jobspot/JopController/sippo_search_controller/user_search_jobs.dart';
import 'package:jobspot/sippo_data/company_repos/company_job_repo.dart';
import 'package:jobspot/sippo_data/model/locations_model/location_address_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';
import 'package:jobspot/sippo_data/model/salary_model/range_salary_model.dart';
import 'package:jobspot/sippo_data/model/specializations_model/specializations_model.dart';
import 'package:jobspot/sippo_data/specializations/specializations_repo.dart';

import '../../sippo_data/locations/locationsRepo.dart';

class SippoFilterSearchController extends GetxController {
  final filterSearchState = FilterSearchState();

  static SippoFilterSearchController get instance => Get.find();
  final userSearchJobsController = SearchJobsController.instances;

  Future<void> fetchExperienceLevels() async {
    final response = await CompanyJobRepo.fetchExperienceLevels();
    await response?.checkStatusResponse(
      onSuccess: (data, _) {
        if (data != null) filterSearchState.experienceLevelList = data;
      },
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

  Future<void> fetchLocationsAddress() async {
    final response = await LocationsRepo.fetchLocations();
    await response?.checkStatusResponse(
      onSuccess: (data, _) {
        if (data != null) {
          filterSearchState.locationAddressList = data;
        }
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
    filterSearchState.specializationFocusNode.addListener(() => refresh());
    filterSearchState.workPLaceTypeList = [
      (value: '1', title: "Onsite"),
      (value: '2', title: "Hybrid"),
      (value: '3', title: "Remote"),
    ];
    Future.wait([
      fetchLocationsAddress(),
      fetchExperienceLevels(),
      fetchSpecializations(),
    ]);
  }

  @override
  void onClose() {
    filterSearchState.close();
    super.onClose();
  }
}

class FilterSearchState {
  final _specializationSearch = "".obs;
  final specializationsSearchController = TextEditingController(text: '');

  String get specializationsSearch => _specializationSearch.toString();

  set specializationsSearch(String value) =>
      _specializationSearch.value = value;
  final _specializationList = <SpecializationModel>[].obs;

  SpecializationModel get specialization => _specialization.value;

  set specialization(SpecializationModel value) {
    if (value == specialization) {
      _specialization.value = SpecializationModel();
      return;
    }
    _specialization.value = value;
  }

  final specializationFocusNode = FocusNode();
  final _specialization = SpecializationModel().obs;

  List<SpecializationModel> get specializationList =>
      _specializationList.toList();

  set specializationList(List<SpecializationModel> value) {
    _specializationList.value = value;
  }

  List<SpecializationModel> filteredSpecializations(String searchKey) =>
      _specializationList.where((e) {
        final specialName = e.name;
        if (specialName == null || specialName.isEmpty) return false;
        return specialName
            .toLowerCase()
            .contains(searchKey.trim().toLowerCase());
      }).toList();

  final _experienceLevel = ExperienceLevel().obs;
  final _locationAddress = LocationAddress().obs;
  final _rangeSalary = RangeValues(
    CompanyEditAddJobState.MIN_SALARY_RANGE,
    CompanyEditAddJobState.MAX_SALARY_RANGE,
  ).obs;
  var salary = RangeSalaryModel();
  final _experienceLevelList = <ExperienceLevel>[].obs;
  final _locationAddressList = <LocationAddress>[].obs;

  ExperienceLevel get experienceLevel => _experienceLevel.value;

  set experienceLevel(ExperienceLevel value) {
    if (value == experienceLevel) {
      _experienceLevel.value = ExperienceLevel();
      return;
    }
    _experienceLevel.value = value;
  }

  LocationAddress get locationAddress => _locationAddress.value;

  void set locationAddress(LocationAddress value) =>
      _locationAddress.value = value;

  RangeValues get rangeSalary => _rangeSalary.value;

  String get startSalary => rangeSalary.start.round().toString();

  String get endSalary => rangeSalary.end.round().toString();

  set rangeSalary(RangeValues value) => _rangeSalary.value = value;

  List<ExperienceLevel> get experienceLevelList =>
      _experienceLevelList.toList();

  set experienceLevelList(List<ExperienceLevel> value) {
    _experienceLevelList.value = value;
  }

  List<LocationAddress> get locationAddressList =>
      _locationAddressList.toList();

  set locationAddressList(List<LocationAddress> value) {
    _locationAddressList.value = value;
  }

  List<String> get locationsAddressNameList => locationAddressList
      .where((e) => e.name != null)
      .map((e) => e.name ?? '')
      .toList();
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
        'specialization_id': "${specialization.id ?? ''}",
        'location_id': "${locationAddress.id ?? ''}",
      };

  void close() {
    specializationsSearchController.dispose();
    specializationFocusNode.dispose();
  }
}
