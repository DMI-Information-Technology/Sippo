import 'dart:async';

import 'package:get/get.dart';
import 'package:jobspot/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/JobServices/shared_global_data_service.dart';
import 'package:jobspot/sippo_controller/ads_controller/ads_controller.dart';
import 'package:jobspot/sippo_controller/dashboards_controller/user_dashboard_controller.dart';
import 'package:jobspot/sippo_controller/home_controllers/job_home_view_controller.dart';
import 'package:jobspot/sippo_custom_widget/find_yor_jop_dashboard_cards.dart';
import 'package:jobspot/sippo_data/model/job_statistics_model/job_statistics_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/profile_edit_model.dart';
import 'package:jobspot/sippo_data/model/specializations_model/specializations_model.dart';
import 'package:jobspot/sippo_data/specializations/specializations_repo.dart';
import 'package:jobspot/utils/states.dart';

class UserHomeController extends GetxController {
  static UserHomeController get instance => Get.find();
  final dashboardController = UserDashBoardController.instance;
  final sharedDataService = SharedGlobalDataService.instance;

  final userHomeState = UserHomePageState();

  ProfileInfoModel get user => dashboardController.user;

  bool get isNetworkConnected => InternetConnectionService.instance.isConnected;
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
          userHomeState.specializationList = data.take(10).toList();
      },
      onValidateError: (validateError, _) {},
      onError: (message, _) {},
    );
  }

  void refreshPage() async {
    if (!isNetworkConnected) return;
    if (states.isLoading) return;
    changeStates(isLoading: true);
    await Future.wait([
      dashboardController.userInformationRefresh(),
      if (Get.isRegistered<AdsViewController>())
        AdsViewController.instance.fetchAds(),
      fetchSpecializations(),
      if (Get.isRegistered<JobStatisticBoardController>())
        JobStatisticBoardController.instance.fetchJobStatistics(),
      if (Get.isRegistered<JobsHomeViewController>())
        JobsHomeViewController.instance.refreshJobs(),
    ]);
    changeStates(isLoading: false);
  }

  @override
  void onInit() {
    super.onInit();
    Timer.periodic(const Duration(milliseconds: 700), (timer) {
      if (Get.isRegistered<JobStatisticBoardController>()) {
        JobStatisticBoardController.instance.fetchJobStatistics();
        timer.cancel();
      }
    });
    fetchSpecializations();
  }
}

class UserHomePageState {
  final _jobStatistic = JobStatisticsModel().obs;

  JobStatisticsModel get jobsStatistic => _jobStatistic.value;

  set jobsStatistic(JobStatisticsModel value) {
    _jobStatistic.value = value;
  }

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
