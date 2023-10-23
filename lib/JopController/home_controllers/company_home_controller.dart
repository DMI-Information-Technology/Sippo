import 'dart:async';

import 'package:get/get.dart';
import 'package:jobspot/JobServices/shared_global_data_service.dart';
import 'package:jobspot/JopController/dashboards_controller/company_dashboard_controller.dart';
import 'package:jobspot/JopController/home_controllers/job_home_view_controller.dart';
import 'package:jobspot/sippo_data/job_statistics_repo/job_statistics_repo.dart';
import 'package:jobspot/sippo_data/model/auth_model/company_response_details.dart';
import 'package:jobspot/sippo_data/model/job_statistics_model/job_statistics_model.dart';
import 'package:jobspot/utils/states.dart';

class CompanyHomeController extends GetxController {
  static CompanyHomeController get instance => Get.find();
  final dashboardController = CompanyDashBoardController.instance;
  final sharedDataService = SharedGlobalDataService.instance;

  final jobsHomeState = CompanyHomePageState();

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

  Future<void> fetchJobStatistics() async {
    final response = await JobStatisticsRepo.fetchLocations();
    await response?.checkStatusResponse(
      onSuccess: (data, _) {
        if (data != null) jobsHomeState.jobStatistic = data;
      },
      onValidateError: (validateError, _) {},
      onError: (message, _) {},
    );
  }

  void refreshPage() async {
    await Future.wait([
      dashboardController.refreshUserProfileInfo(),
      if (Get.isRegistered<JobsHomeViewController>())
        JobsHomeViewController.instance.refreshJobs(),
      fetchJobStatistics(),
    ]);
  }

  @override
  void onInit() {
    super.onInit();
    fetchJobStatistics();
  }
}

class CompanyHomePageState {
  final _jobStatistic = JobStatisticsModel().obs;

  JobStatisticsModel get jobStatistic => _jobStatistic.value;

  set jobStatistic(JobStatisticsModel value) {
    _jobStatistic.value = value;
  }
}
