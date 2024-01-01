import 'dart:async';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sippo/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:sippo/JobServices/shared_global_data_service.dart';
import 'package:sippo/sippo_data/company_repos/company_job_repo.dart';
import 'package:sippo/sippo_data/model/job_statistics_model/job_statistics_model.dart';
import 'package:sippo/sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';
import 'package:sippo/sippo_data/user_repos/user_jobs_repo.dart';
import 'package:sippo/utils/getx_text_editing_controller.dart';
import 'package:sippo/utils/states.dart';

import '../../core/Refresh.dart';
import '../../sippo_data/user_repos/user_saved_job_repo.dart';

class SearchJobsController extends GetxController {
  final pagingController =
      PagingController<int, CompanyJobModel>(firstPageKey: 0);

  static SearchJobsController get instances => Get.find();

  bool get isNetworkConnected => InternetConnectionService.instance.isConnected;
  final searchJobsState = SearchJobsState();
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
    if (isLoading == true) {
      _states.value = States();
      return;
    }
    _states.value = states.copyWith(
      isLoading: isLoading,
      isSuccess: isLoading == true ? false : isSuccess,
      isError: isLoading == true ? false : isError,
      message: message,
      isWarning: isLoading == true ? false : isWarning,
      error: error,
    );
  }

  void resetStates() => _states.value = States();

  void changeSaveJobState(
    int index,
    bool Function(CompanyJobModel value) isSaved,
  ) {
    pagingController.itemList = Refresher.changePropertyItemState(
      pagingController.itemList,
      index,
      newItemChanger: (indexItem) => indexItem.copyWith(
        isSaved: isSaved(indexItem),
      ),
    );
  }

  Future<void> toggleSavedJobs(int index, int? id) async {
    changeSaveJobState(index, (e) => !(e.isSaved == true));
    final response = await SavedJobsRepo.toggleSavedJob(id);
    await response?.checkStatusResponse(
      onSuccess: (data, _) {},
      onValidateError: (validateError, _) {
        changeSaveJobState(index, (e) => e.isSaved == true);
      },
      onError: (message, _) {
        changeSaveJobState(index, (e) => e.isSaved == true);
      },
    );
  }

  void onToggleSavedJobsSubmitted(int index, int? id) async {
    if (InternetConnectionService.instance.isNotConnected) return;
    await toggleSavedJobs(index, id);
  }

  Future<void> fetchSearchJobsPages(
    int pageKey,
  ) async {
    final response =
        await SippoJobsRepo.fetchJobs(searchJobsState.buildQuerySearch);
    response?.checkStatusResponse(
      onSuccess: (data, _) {
        final lastPage = data?.meta?.lastPage ?? searchJobsState.pageNumber;
        if (searchJobsState.pageNumber >= lastPage) {
          pagingController.appendLastPage(data?.data ?? []);
        } else {
          final newDataLength = data?.data?.length ?? 0;
          final int nextKey = pageKey + newDataLength;
          pagingController.appendPage(data?.data ?? [], nextKey);
          searchJobsState.incrementPageNumber();
        }
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
    searchJobsState.pageNumber = 1;
    pagingController.refresh();
  }

  void onSelectedEmploymentTypeSubmitted(({String value, String title}) v) {
    if (states.isLoading || searchJobsState.employmentType == v) return;
    searchJobsState.employmentType = v;
    refreshPage();
  }

  void retryLastFieldRequest() {
    pagingController.retryLastFailedRequest();
  }

  void _pageRequester(int pageKey) async {
    changeStates(isLoading: true);
    await fetchSearchJobsPages(pageKey);
    changeStates(isLoading: false);
  }

  Future<void> fetchEmploymentTypes() async {
    final response = await CompanyJobRepo.fetchEmploymentTypes();
    await response?.checkStatusResponse(
      onSuccess: (data, _) {
        if (data != null)
          searchJobsState.employmentTypeList = List.generate(
            data.length,
            (index) => (value: '${index + 1}', title: data[index]),
          );
      },
      onValidateError: (validateError, _) {},
      onError: (message, _) {},
    );
  }

  void startSearchJob(JobStatisticsData? jobStatistics) async {
    await fetchEmploymentTypes();
    if (jobStatistics?.type == 'employment_type')
      searchJobsState.employmentType =
          searchJobsState.employmentTypeList.firstWhereOrNull(
                (e) => e.title == jobStatistics?.label,
              ) ??
              searchJobsState.employmentType;
  }

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map<String, int?> && args.containsKey('specialization_id')) {
      final special = args['specialization_id'];
      searchJobsState.querySearch['specialization_id'] =
          (special ?? '').toString();
    }
    searchJobsState.textSearch.text =
        SharedGlobalDataService.instance.searchTextKey;
    final jobStatistics = SharedGlobalDataService.instance.jobStatistic;
    switch (jobStatistics?.type) {
      case "employment_type":
        searchJobsState.employmentType =
            (value: '', title: jobStatistics?.label ?? '');
      case "workplace_type":
        searchJobsState.querySearch[jobStatistics?.type ?? ""] =
            jobStatistics?.label ?? "";
    }
    startSearchJob(jobStatistics);
    pagingController.addPageRequestListener(_pageRequester);
  }

  @override
  void onClose() {
    pagingController.dispose();
    searchJobsState.close();
    super.onClose();
  }
}

class SearchJobsState {
  final _isHeightOverAppBar = false.obs;

  bool get isHeightOverAppBar => _isHeightOverAppBar.isTrue;

  set isHeightOverAppBar(bool value) => _isHeightOverAppBar.value = value;
  var _pageNumber = 1;

  int get pageNumber => _pageNumber.toInt();

  void set pageNumber(int value) => _pageNumber = value;

  void incrementPageNumber() => _pageNumber++;

  final textSearch = GetXTextEditingController();
  final querySearch = <String, String>{};

  final Rx<({String? value, String? title})> _employmentTyp =
      (value: '', title: '').obs;

  ({String? value, String? title}) get employmentType => _employmentTyp.value;

  set employmentType(({String? value, String? title}) value) {
    if (value == employmentType) {
      _employmentTyp.value = (value: '', title: '');
      return;
    }
    _employmentTyp.value = value;
  }

  final _employmentTypeList = <({String value, String title})>[].obs;

  List<({String value, String title})> get employmentTypeList =>
      _employmentTypeList.toList();

  set employmentTypeList(List<({String value, String title})> value) {
    _employmentTypeList.value = value;
  }

  void clearQuerySearch() {
    employmentType = (title: '', value: '');
    textSearch.text = '';
    querySearch.clear();
  }

  Map<String, String> get buildQuerySearch => {
        ...querySearch,
        'page': pageNumber.toString(),
        'text': textSearch.text.split(' ').join('+'),
        'employment_type': employmentType.title?.split(' ').join('+') ?? '',
        'per_page': '6',
      }..removeWhere((key, value) => value.trim().isEmpty);

  void close() {
    textSearch.dispose();
  }
}
