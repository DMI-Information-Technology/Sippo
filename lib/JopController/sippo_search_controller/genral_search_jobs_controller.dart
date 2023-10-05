import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jobspot/JopController/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/JopController/sippo_search_controller/general_search_controller.dart';

import '../../sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';
import '../../sippo_data/user_repos/user_jobs_repo.dart';
import '../../utils/states.dart';

class GeneralSearchJobsController extends GetxController {
  final generalSearchController = UserGeneralSearchController.instance;

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

  void retryLastFailedRequest() {
    if (InternetConnectionController.instance.isNotConnected) return;

    if (generalSearchController.states.isLoading) return;
    generalSearchController.changeStates(isError: false, message: '');
    pagingController.retryLastFailedRequest();
    _pageJobRequester(searchJobsState.pageNumber);
  }

  void _pageJobRequester(int pageKey) async {
    generalSearchController.changeStates(isLoading: true);
    await fetchSearchJobsPages(pageKey);
    generalSearchController.changeStates(isLoading: false);
  }

  void refreshPage() {
    if (InternetConnectionController.instance.isNotConnected) return;
    if (generalSearchController.states.isLoading) return;
    searchJobsState.pageNumber = 1;
    pagingController.refresh();
    _pageJobRequester(searchJobsState.pageNumber);
  }

  void onLoadMoreJobsSubmitted() {
    _pageJobRequester(searchJobsState.pageNumber);
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
