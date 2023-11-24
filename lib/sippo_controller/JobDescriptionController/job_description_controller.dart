import 'dart:ui';

import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/JobServices/shared_global_data_service.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';
import 'package:jobspot/sippo_data/user_repos/user_jobs_repo.dart';
import 'package:jobspot/utils/states.dart';

import '../../JobGlobalclass/routes.dart';
import '../../sippo_data/user_repos/user_saved_job_repo.dart';

class JobCompanyDetailsController extends GetxController {
  static JobCompanyDetailsController get instance => Get.find();
  final sharedDataService = SharedGlobalDataService.instance;

  CompanyJobModel? get requestedJobDetails =>
      sharedDataService.jobGlobalState.details;

  int get jobId => sharedDataService.jobGlobalState.id;

  final jobDetailsState = JobCompanyDetailsState();
  final _states = States().obs;

  States get states => _states.value;

  Future<void> toggleSavedJobs(int? id) async {
    jobDetailsState.jopDetails = jobDetailsState.jopDetails
        .copyWith(isSaved: !(jobDetailsState.jopDetails.isSaved == true));
    final response = await SavedJobsRepo.toggleSavedJob(id);
    await response?.checkStatusResponse(
      onSuccess: (data, _) {
        sharedDataService.jobGlobalState.details = jobDetailsState.jopDetails;
      },
      onValidateError: (validateError, _) {
        jobDetailsState.jopDetails =
            jobDetailsState.jopDetails.copyWith(isSaved: false);
      },
      onError: (message, _) {
        jobDetailsState.jopDetails =
            jobDetailsState.jopDetails.copyWith(isSaved: false);
      },
    );
  }

  void onToggleSavedJobs() async {
    if (InternetConnectionService.instance.isNotConnected) return;
    if (states.isLoading) return;
    _states.value = States(isLoading: true);
    await toggleSavedJobs(jobId);
    _states.value = states.copyWith(isLoading: false);
  }

  Future<CompanyJobModel?> getJobById(int? id) async {
    final response = await SippoJobsRepo.getJobById(id);
    final data = await response?.checkStatusResponseAndGetData(
      onValidateError: (validateError, _) {
        changeStates(isError: true, error: validateError?.message);
      },
      onError: (message, _) {
        changeStates(isError: true, error: message);
      },
    );
    print(data?.company?.images);
    return data;
  }

  void requestJobDetails() async {
    changeStates(isLoading: true);
    final job = requestedJobDetails;
    if (job != null && !job.isJobContentBlank) {
      jobDetailsState.jopDetails = job;
      jobDetailsState.jopDetails = await getJobById(job.id) ?? job;
    } else if (jobId != -1) {
      jobDetailsState.jopDetails =
          await getJobById(jobId) ?? jobDetailsState.jopDetails;
    }
    sharedDataService.jobGlobalState.details = jobDetailsState.jopDetails;
    sharedDataService.jobGlobalState.id = jobDetailsState.jopDetails.id ?? -1;
    changeStates(isLoading: false);
    final args = sharedDataService.jobGlobalState.args;
    if (args != null && args.containsKey(SharedGlobalDataService.GO_TO_APPLY)) {
      if (args[SharedGlobalDataService.GO_TO_APPLY] case bool _) applyTapped();
    }
  }

  void applyTapped() {
    Get.toNamed(SippoRoutes.userApplyJobs)?.then((_) {
      setJobDetailsState();
    });
  }

  void changeStates({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    bool? isWarning,
    String? message,
    String? error,
  }) {
    print("is loading:  $isLoading");
    _states.value = states.copyWith(
      isLoading: isLoading,
      isSuccess: isLoading == true ? false : isSuccess,
      isError: isLoading == true ? false : isError,
      message: message,
      isWarning: isLoading == true ? false : isWarning,
      error: error,
    );
  }

  @override
  void onInit() {
    requestJobDetails();
    super.onInit();
  }

  void setJobDetailsState() {
    final job = requestedJobDetails;
    if (job != null) {
      jobDetailsState.jopDetails = job;
    }
  }
}

class JobCompanyDetailsState {
  final _isHeightOverAppBar = false.obs;

  bool get isHeightOverAppBar => _isHeightOverAppBar.isTrue;

  set isHeightOverAppBar(bool value) => _isHeightOverAppBar.value = value;
  final _jopDetails = CompanyJobModel().obs;

  CompanyJobModel get jopDetails => _jopDetails.value;

  void set jopDetails(CompanyJobModel value) {
    _jopDetails.value = value;
  }

  final _selectedPageView = 0.obs;

  int get selectedPageView => _selectedPageView.toInt();

  Color changeDescriptionButtonColor() =>
      selectedPageView == 0 ? SippoColor.primarycolor : SippoColor.lightprimary;

  Color changeCompanyButtonColor() =>
      selectedPageView == 1 ? SippoColor.primarycolor : SippoColor.lightprimary;

  void set selectedPageView(int value) {
    _selectedPageView.value = value;
  }

  void switchPageView() => selectedPageView = selectedPageView == 0 ? 1 : 0;
}
