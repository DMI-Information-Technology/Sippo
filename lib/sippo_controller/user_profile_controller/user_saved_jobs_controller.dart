import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sippo/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:sippo/JobServices/shared_global_data_service.dart';
import 'package:sippo/sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';
import 'package:sippo/sippo_data/user_repos/user_saved_job_repo.dart';
import 'package:sippo/utils/states.dart';

import '../dashboards_controller/user_dashboard_controller.dart';

class UserSavedJobsController extends GetxController {
  static UserSavedJobsController get instance => Get.find();
  final pagingController =
      PagingController<int, CompanyJobModel>(firstPageKey: 0);

  bool get isNetworkConnected => InternetConnectionService.instance.isConnected;
  final savedJobState = SavedJobsJobState();

  final _states = States().obs;

  States get states => _states.value;

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

  final dashboardController = UserDashBoardController.instance;
  final sharedDataService = SharedGlobalDataService.instance;

  void set jobDetailsId(int? value) {
    sharedDataService.jobGlobalState.id = value ?? -1;
  }

  void set requestedJobDetails(CompanyJobModel? value) {
    if (value != null) sharedDataService.jobGlobalState.details = value;
  }

  void clearRequestedJobDetails() {
    sharedDataService.jobGlobalState.clearDetails(
      () => CompanyJobModel(),
    );
  }

  Future<void> fetchSavedJobsPages(int pageKey) async {
    final query = {'page': "${savedJobState.pageNumber}"};
    final response = await SavedJobsRepo.fetchSavedJobs(query);
    response?.checkStatusResponse(
      onSuccess: (data, _) {
        pagingController.appendLastPage(data ?? []);
        // final lastPage = data?.meta?.lastPage ?? savedJobState.pageNumber;
        // if (savedJobState.pageNumber >= lastPage) {
        //   pagingController.appendLastPage(data?.data ?? []);
        // } else {
        //   final newDataLength = data?.data?.length ?? 0;
        //   final int nextKey = pageKey + newDataLength;
        //   pagingController.appendPage(data?.data ?? [], nextKey);
        //   savedJobState.incrementPageNumber();
        // }
      },
      onValidateError: (validateError, _) {},
      onError: (message, _) {
        pagingController.error = true;
        changeStates(isError: true, message: message);
      },
    );
  }

  void refreshPage() {
    if (!isNetworkConnected) return;
    if (states.isLoading) return;
    savedJobState.pageNumber = 1;
    pagingController.refresh();
  }

  void retryLastFieldRequest() {
    pagingController.retryLastFailedRequest();
  }

  void _pageRequester(int pageKey) async {
    changeStates(isLoading: true);
    await fetchSavedJobsPages(pageKey);
    changeStates(isLoading: false);
  }

  Future<void> removeSavedJob(int? id) async {
    final index = pagingController.itemList?.indexWhere((e) => e.id == id);
    final response = await SavedJobsRepo.toggleSavedJob(id);
    await response?.checkStatusResponse(
      onSuccess: (data, _) {
        if (data != null && (index != null && index != -1)) {
          pagingController.itemList = pagingController.itemList?.toList()
            ?..removeAt(index);
        }
      },
      onValidateError: (validateError, _) {},
      onError: (message, _) {},
    );
  }

  void onRemoveOptionSubmitted(int? id) async {
    if (!isNetworkConnected) return;
    await removeSavedJob(id);
  }

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener(_pageRequester);
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }

  Future<void> removeAllJobs() async {
    if (states.isLoading) return;
    _states.value = States(isLoading: true);
    final response = await SavedJobsRepo.removeAllSavedJobs();
    changeStates(isLoading: false);
    await response?.checkStatusResponse(
      onSuccess: (data, _) {
        if (pagingController.itemList?.isNotEmpty == true) {
          refreshPage();
        }
      },
      onValidateError: (validate, _) {},
      onError: (message, _) {},
    );
  }
}

class SavedJobsJobState {
  var _pageNumber = 1;

  int get pageNumber => _pageNumber.toInt();

  void set pageNumber(int value) => _pageNumber = value;

  void incrementPageNumber() => _pageNumber++;
  final _selectedOption = (-1).obs;

  int get selectedOption => _selectedOption.toInt();

  void set selectedOption(int value) {
    _selectedOption.value = value;
  }
}
