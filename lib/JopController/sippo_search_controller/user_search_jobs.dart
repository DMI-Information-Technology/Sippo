import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jobspot/JobServices/shared_global_data_service.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';
import 'package:jobspot/sippo_data/user_repos/user_jobs_repo.dart';
import 'package:jobspot/utils/getx_text_editing_controller.dart';

import 'package:jobspot/sippo_data/company_repos/company_job_repo.dart';
import 'package:jobspot/utils/states.dart';
import 'package:jobspot/JobServices/ConnectivityController/internet_connection_controller.dart';


class UserSearchJobsController extends GetxController {
  final pagingController =
      PagingController<int, CompanyJobModel>(firstPageKey: 0);

  static UserSearchJobsController get instances => Get.find();

  bool get isNetworkConnected =>
      InternetConnectionService.instance.isConnected;
  final searchJobsState = UserSearchJobsState();
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

  void resetStates() => _states.value = States();

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
    if (states.isLoading || searchJobsState.employmentTyp == v) return;
    searchJobsState.employmentTyp = v;
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

  @override
  void onInit() {
    super.onInit();
    searchJobsState.textSearch.text =
        SharedGlobalDataService.instance.searchTextKey;
    fetchEmploymentTypes();
    pagingController.addPageRequestListener(_pageRequester);
  }

  @override
  void onClose() {
    pagingController.dispose();
    searchJobsState.close();
    super.onClose();
  }
}

class UserSearchJobsState {
  var _pageNumber = 1;

  int get pageNumber => _pageNumber.toInt();

  void set pageNumber(int value) => _pageNumber = value;

  void incrementPageNumber() => _pageNumber++;

  final textSearch = GetXTextEditingController();
  final querySearch = <String, String>{};

  final Rx<({String? value, String? title})> _employmentTyp =
      (value: '', title: '').obs;

  ({String? value, String? title}) get employmentTyp => _employmentTyp.value;

  set employmentTyp(({String? value, String? title}) value) {
    if (value == employmentTyp) {
      employmentTyp = (value: '', title: '');
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

  Map<String, String> get buildQuerySearch => {
        ...querySearch,
        'page': pageNumber.toString(),
        'text': textSearch.text.trim().split(' ').join('+'),
        'employment_type': employmentTyp.title?.split(' ').join('+') ?? '',
        'per_page': '6',
      }..removeWhere((key, value) => value.trim().isEmpty);

  void close() {
    textSearch.dispose();
  }
}
