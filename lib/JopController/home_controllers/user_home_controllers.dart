import 'package:get/get.dart';
import 'package:jobspot/JopController/dashboards_controller/user_dashboard_controller.dart';
import 'package:jobspot/sippo_data/model/auth_model/company_response_details.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/profile_edit_model.dart';
import 'package:jobspot/sippo_data/user_repos/user_jobs_repo.dart';

import '../../sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';
import '../../utils/states.dart';
import '../ConnectivityController/internet_connection_controller.dart';

class UserHomeController extends GetxController {
  static UserHomeController get instance => Get.find();
  final dashboardController = UserDashBoardController.instance;

  void set jobDetailsId(int? value) {
    dashboardController.jobDashboardState.id = value ?? -1;
  }

  void set requestedJobDetails(CompanyJobModel? value) {
    if (value != null) dashboardController.jobDashboardState.details = value;
  }

  void clearRequestedJobDetails() {
    dashboardController.jobDashboardState.clearDetails(
      () => CompanyJobModel(),
    );
  }

  void set companyDetailsId(int? value) {
    dashboardController.companyDashboardState.id = value ?? -1;
  }

  void set requestedCompanyDetails(CompanyDetailsResponseModel? value) {
    if (value != null)
      dashboardController.companyDashboardState.details = value;
  }

  void clearRequestedCompanyDetails() {
    dashboardController.companyDashboardState.clearDetails(
      () => CompanyDetailsResponseModel(),
    );
  }

  final jobsHomeState = JobsHomeState();

  ProfileInfoModel get user => dashboardController.user;

  bool get isNetworkConnected =>
      InternetConnectionController.instance.isConnected;
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

  void refreshPage() async {
    await Future.wait([
      jobsHomeState.refreshJobs(),
      dashboardController.userInformationRefresh(),
    ]);
  }

  @override
  void onInit() {
    super.onInit();
    jobsHomeState.pageJobsRequester(0);
  }
}

class JobsHomeState {
  bool get isNetworkConnected =>
      InternetConnectionController.instance.isConnected;
  final _jobStates = States().obs;

  States get jobStates => _jobStates.value;

  void resetJobStates() => _jobStates.value = States();

  void changeJobsStates({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    bool? isWarning,
    String? message,
    String? error,
  }) {
    _jobStates.value = jobStates.copyWith(
      isLoading: isLoading,
      isSuccess: isLoading == true ? false : isSuccess,
      isError: isLoading == true ? false : isError,
      message: isLoading == true ? '' : message,
      isWarning: isLoading == true ? false : isWarning,
      error: error,
    );
  }

  Future<void> fetchJobPages(int pageKey) async {
    final query = {'page': "1", "per_page": "3"};
    final response = await UserJobRepo.fetchJobs(query);
    response?.checkStatusResponse(
      onSuccess: (page, _) {
        final data = page?.data;
        if (data != null) {
          jobsList = data.take(3).toList();
          changeJobsStates(
            isError: false,
            isSuccess: true,
            message: "the job has been fetched successfully.",
          );
          // pagingJobsController.appendLastPage(data.take(3).toList());
        }
      },
      onValidateError: (validateError, _) {},
      onError: (message, _) {
        // pagingJobsController.error = true;
        changeJobsStates(
          isError: true,
          isSuccess: false,
          message: message,
        );
      },
    );
  }

  void pageJobsRequester(int pageKey) async {
    changeJobsStates(isLoading: true);
    await fetchJobPages(pageKey);
    changeJobsStates(isLoading: false);
  }

  final _jobsList = <CompanyJobModel>[].obs;

  List<CompanyJobModel> get jobsList => _jobsList.toList();

  void set jobsList(List<CompanyJobModel> value) {
    _jobsList.value = value;
  }

  Future<void> refreshJobs() async {
    if (!isNetworkConnected) {
      if (jobsList.isEmpty)
        changeJobsStates(
          isError: true,
          isSuccess: false,
          message:
              "sorry your connection is lost, please check your settings before continuing.",
        );
      return;
    }
    if (jobStates.isLoading) return;
    // resetJobStates();
    pageJobsRequester(1);
  }
}
