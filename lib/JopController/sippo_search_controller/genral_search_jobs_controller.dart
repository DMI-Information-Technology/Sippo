import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jobspot/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/JopController/sippo_search_controller/general_search_controller.dart';
import 'package:jobspot/core/Refresh.dart';

import '../../sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';
import '../../sippo_data/user_repos/user_jobs_repo.dart';
import '../../sippo_data/user_repos/user_saved_job_repo.dart';
import '../../utils/states.dart';

class GeneralSearchJobsController extends GetxController {
  final generalSearchController = UserGeneralSearchController.instance;
  final networkController = InternetConnectionService.instance;

  static GeneralSearchJobsController get instance => Get.find();
  final pagingController =
      PagingController<int, CompanyJobModel>(firstPageKey: 0);
  final searchJobsState = GeneralSearchJobsState();

  States get states => generalSearchController.states;

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
        generalSearchController.changeStates(isError: true, message: message);
      },
    );
  }

  void _pageJobRequester(int pageKey) async {
    generalSearchController.changeStates(isLoading: true);
    await fetchSearchJobsPages(pageKey);
    generalSearchController.changeStates(isLoading: false);
  }

  void retryLastFailedRequest() {
    if (isRefreshPrevented) return;
    generalSearchController.changeStates(isError: false, message: '');
    pagingController.retryLastFailedRequest();
    _pageJobRequester(searchJobsState.pageNumber);
  }

  void refreshPage() {
    if (isRefreshPrevented) return;
    searchJobsState.pageNumber = 1;
    pagingController.refresh();
    _pageJobRequester(searchJobsState.pageNumber);
  }

  void onLoadMoreJobsSubmitted() {
    Get.focusScope?.unfocus();
    if (isRefreshPrevented) return;
    _pageJobRequester(searchJobsState.pageNumber);
  }

  bool get isRefreshPrevented =>
      networkController.isNotConnected ||
      generalSearchController.states.isLoading;

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

  Future<void> toggleSavedJobs(int? id) async {
    final index = pagingController.itemList?.indexWhere((e) => e.id == id)??-1;
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

  void onToggleSavedJobsSubmitted(int? id) async {
    if (networkController.isNotConnected) return;
    await toggleSavedJobs(id);
  }

  @override
  void onInit() {
    super.onInit();
    _pageJobRequester(searchJobsState.pageNumber);
    // pagingController.addPageRequestListener(_pageJobRequester);
  }
}

class GeneralSearchJobsState {
  var pageNumber = 1;

  void incrementPageNumber() => pageNumber++;

  Map<String, String> get buildQuerySearch => {
        'page': '${pageNumber}',
        'per_page': "6",
        'text': UserGeneralSearchController
            .instance.generalSearchState.searchController.text
            .split(" ")
            .join("+"),
      };
}
