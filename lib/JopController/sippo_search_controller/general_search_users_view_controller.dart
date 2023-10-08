import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jobspot/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/JopController/sippo_search_controller/general_search_controller.dart';
import 'package:jobspot/sippo_data/company_repos/compan_user_profile_view_repo.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/company_user_profile_view_model.dart';

import 'package:jobspot/utils/states.dart';

class GeneralSearchProfilesViewController extends GetxController {
  final generalSearchController = UserGeneralSearchController.instance;

  static GeneralSearchProfilesViewController get instance => Get.find();
  final pagingController =
  PagingController<int, ProfileViewResourceModel>(firstPageKey: 0);
  final searchProfilesViewState = GeneralSearchProfilesViewState();

  States get states => generalSearchController.states;

  Future<void> fetchSearchProfilesUsersPages(
      int pageKey,
      ) async {
    final response = await CompanyUserProfileViewRepo.fetchUserProfilesView(
      searchProfilesViewState.buildQuerySearch,
    );
    response?.checkStatusResponse(
      onSuccess: (data, _) {
        final lastPage =
            data?.meta?.lastPage ?? searchProfilesViewState.pageNumber;
        if (searchProfilesViewState.pageNumber >= lastPage) {
          pagingController.appendLastPage(data?.data ?? []);
        } else {
          final newDataLength = data?.data?.length ?? 0;
          final int nextKey = pageKey + newDataLength;
          pagingController.appendPage(data?.data ?? [], nextKey);
          searchProfilesViewState.incrementPageNumber();
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
    print("dd");
    if (InternetConnectionService.instance.isNotConnected) return;
    if (generalSearchController.states.isLoading) return;
    generalSearchController.changeStates(isError: false, message: '');
    pagingController.retryLastFailedRequest();
    _pageProfilesViewRequester(searchProfilesViewState.pageNumber);
  }

  void _pageProfilesViewRequester(int pageKey) async {
    generalSearchController.changeStates(isLoading: true);
    await fetchSearchProfilesUsersPages(pageKey);
    generalSearchController.changeStates(isLoading: false);
  }

  void refreshPage() {
    if (InternetConnectionService.instance.isNotConnected) return;
    if (generalSearchController.states.isLoading) return;
    searchProfilesViewState.pageNumber = 1;
    pagingController.refresh();
    _pageProfilesViewRequester(searchProfilesViewState.pageNumber);
  }

  void onLoadMoreProfilesViewSubmitted() {
    if (InternetConnectionService.instance.isNotConnected) return;
    if (generalSearchController.states.isLoading) return;
    _pageProfilesViewRequester(searchProfilesViewState.pageNumber);
  }

  @override
  void onInit() {
    super.onInit();
    _pageProfilesViewRequester(searchProfilesViewState.pageNumber);
  }
}

class GeneralSearchProfilesViewState {
  var pageNumber = 1;

  void incrementPageNumber() => pageNumber++;

  Map<String, String> get buildQuerySearch => {
    'page': '${pageNumber}',
    'per_page': "6",
    'name': UserGeneralSearchController
        .instance.generalSearchState.searchController.text
        .split(" ")
        .join("+"),
  };
}
