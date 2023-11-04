import 'dart:async';

import 'package:get/get.dart';
import 'package:jobspot/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/JobServices/shared_global_data_service.dart';
import 'package:jobspot/sippo_controller/ads_controller/ads_controller.dart';
import 'package:jobspot/sippo_controller/dashboards_controller/company_dashboard_controller.dart';
import 'package:jobspot/sippo_controller/home_controllers/job_home_view_controller.dart';
import 'package:jobspot/sippo_custom_widget/find_yor_jop_dashboard_cards.dart';
import 'package:jobspot/sippo_data/model/auth_model/company_response_details.dart';
import 'package:jobspot/sippo_data/model/specializations_model/specializations_model.dart';
import 'package:jobspot/sippo_data/specializations/specializations_repo.dart';
import 'package:jobspot/utils/states.dart';

class CompanyHomeController extends GetxController {
  static CompanyHomeController get instance => Get.find();
  final dashboardController = CompanyDashBoardController.instance;
  final sharedDataService = SharedGlobalDataService.instance;

  final companyHomeState = CompanyHomePageState();

  CompanyDetailsModel get user => dashboardController.company;

  final _states = States().obs;

  States get states => _states.value;

  void resetStates() => _states.value = States();

  void changeStates({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    bool? isWarning,
    String? message,
    String? error,
  }) {
    _states.value = states.copyWith(
      isLoading: isLoading,
      isSuccess: isLoading == true ? false : isSuccess,
      isError: isLoading == true ? false : isError,
      message: message,
      isWarning: isLoading == true ? false : isWarning,
      error: error,
    );
  }

  Future<void> fetchSpecializations() async {
    final response = await SpecializationRepo.fetchSpecializationsResource();
    await response?.checkStatusResponse(
      onSuccess: (data, _) {
        if (data != null)
          companyHomeState.specializationList = data.take(10).toList();
      },
      onValidateError: (validateError, _) {},
      onError: (message, _) {},
    );
  }

  void refreshPage() async {
    if (InternetConnectionService.instance.isNotConnected) return;
    if (states.isLoading) return;
    _states(States(isLoading: true));
    await Future.wait([
      dashboardController.refreshUserProfileInfo(),
      if (Get.isRegistered<AdsViewController>())
        AdsViewController.instance.fetchAds(),
      fetchSpecializations(),
      if (Get.isRegistered<JobStatisticBoardController>())
        JobStatisticBoardController.instance.fetchJobStatistics(),
      if (Get.isRegistered<JobsHomeViewController>())
        JobsHomeViewController.instance.refreshJobs(),
    ]);
    _states(States(isLoading: false));
  }

  @override
  void onInit() {
    super.onInit();
    Timer.periodic(Duration(milliseconds: 700), (timer) {
      if (Get.isRegistered<JobStatisticBoardController>()) {
        JobStatisticBoardController.instance.fetchJobStatistics();
        timer.cancel();
      }
    });
    fetchSpecializations();
  }
}

class CompanyHomePageState {
  final _selectedSpecialization = SpecializationModel().obs;

  SpecializationModel get selectedSpecialization =>
      _selectedSpecialization.value;

  void set selectedSpecialization(SpecializationModel value) {
    if (selectedSpecialization == value) {
      _selectedSpecialization.value = SpecializationModel();
      return;
    }
    _selectedSpecialization.value = value;
  }

  final _specializationList = <SpecializationModel>[].obs;

  List<SpecializationModel> get specializationList =>
      _specializationList.toList();

  set specializationList(List<SpecializationModel> value) {
    _specializationList.value = value;
  }
}
