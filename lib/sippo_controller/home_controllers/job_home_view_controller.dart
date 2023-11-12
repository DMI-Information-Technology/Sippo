import 'package:get/get.dart';
import 'package:jobspot/sippo_data/model/specializations_model/specializations_model.dart';

import '../../JobServices/ConnectivityController/internet_connection_controller.dart';
import '../../core/Refresh.dart';
import '../../sippo_data/model/job_statistics_model/job_statistics_model.dart';
import '../../sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';
import '../../sippo_data/user_repos/user_jobs_repo.dart';
import '../../sippo_data/user_repos/user_saved_job_repo.dart';
import '../../utils/states.dart';

class JobsHomeViewController extends GetxController {
  static JobsHomeViewController get instance => Get.find();
  final _jobStatistic = JobStatisticsModel().obs;

  JobStatisticsModel get jobStatistic => _jobStatistic.value;

  void set jobStatistic(JobStatisticsModel value) =>
      _jobStatistic.value = value;

  bool get isNetworkConnected => InternetConnectionService.instance.isConnected;
  final _jobStates = States().obs;

  States get jobStates => _jobStates.value;

  Future<States> get jobStatesAsFuture async => jobStates;

  void resetJobStates() => _jobStates.value = States();

  void changeJobsStates({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    bool? isWarning,
    String? message,
    String? error,
  }) {
    if (isLoading == true) {
      _jobStates.value = States(isLoading: true);
      return;
    }
    _jobStates.value = jobStates.copyWith(
      isLoading: isLoading,
      isSuccess: isSuccess,
      isError: isError,
      message: message,
      isWarning: isWarning,
      error: error,
    );
  }

  Future<void> fetchJobPages([SpecializationModel? special]) async {
    final query = {
      'page': "1",
      "per_page": "5",
      if (special?.id != null) 'specialization_id': '${special?.id ?? ''}'
    };
    final response = await SippoJobsRepo.fetchJobs(query);
    response?.checkStatusResponse(
      onSuccess: (page, _) {
        final data = page?.data;
        if (data != null) {
          jobsList = data.take(5).toList();
          changeJobsStates(
            isError: false,
            isSuccess: true,
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

  void pageJobsRequester([SpecializationModel? special]) async {
    changeJobsStates(isLoading: true);
    await fetchJobPages(special);
    changeJobsStates(isLoading: false);
  }

  final _jobsList = <CompanyJobModel>[].obs;

  List<CompanyJobModel> get jobsList => _jobsList.toList();

  int get jobsListLength => _jobsList.length;

  void set jobsList(List<CompanyJobModel> value) {
    _jobsList.value = value;
  }

  Future<void> refreshJobs([SpecializationModel? special]) async {
    if (!isNetworkConnected) {
      if (jobsList.isEmpty)
        changeJobsStates(
          isError: true,
          isSuccess: false,
          message: "connection_lost_message_1".tr,
        );
      return;
    }
    if (jobStates.isLoading) return;
    pageJobsRequester(special);
  }

  void changeIsSaved(int index, bool isSaved) {
    print('change is  saved $isSaved');
    jobsList = Refresher.changePropertyItemState(jobsList, index,
            newItemChanger: (indexItem) {
          return indexItem.copyWith(isSaved: isSaved);
        }) ??
        jobsList;
  }

  Future<void> toggleSavedJobs(int? id, int index) async {
    changeIsSaved(index, !(jobsList[index].isSaved == true));
    final response = await SavedJobsRepo.toggleSavedJob(id);
    await response?.checkStatusResponse(
      onSuccess: (data, _) {},
      onValidateError: (validateError, _) {
        changeIsSaved(index, jobsList[index].isSaved == true);
      },
      onError: (message, _) {
        changeIsSaved(index, jobsList[index].isSaved == true);
      },
    );
  }

  @override
  void onInit() {
    pageJobsRequester();
    super.onInit();
  }

  void onToggleSavedJobsTap(int? id, int index) async {
    if (!isNetworkConnected) return;
    await toggleSavedJobs(id, index);
  }
}
