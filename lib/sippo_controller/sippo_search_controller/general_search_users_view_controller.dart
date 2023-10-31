import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jobspot/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/sippo_controller/sippo_search_controller/general_search_controller.dart';
import 'package:jobspot/sippo_data/company_repos/compan_user_profile_view_repo.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/company_user_profile_view_model.dart';
import 'package:jobspot/utils/states.dart';

import 'package:jobspot/sippo_data/locations/locationsRepo.dart';
import 'package:jobspot/sippo_data/model/locations_model/location_address_model.dart';

class GeneralSearchProfilesViewController extends GetxController {
  final generalSearchController = GeneralSearchController.instance;

  static GeneralSearchProfilesViewController get instance => Get.find();
  final pagingController =
      PagingController<int, ProfileViewResourceModel>(firstPageKey: 0);
  final searchProfilesViewState = GeneralSearchProfilesViewState();

  final _states = States().obs;
  States get states => _states.value;
  void changeStates({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    bool? isWarning,
    String? message,
    String? error,
  }) =>
      _states.value = states.copyWith(
        isLoading: isLoading,
        isSuccess: isLoading == true ? false : isSuccess,
        isError: isLoading == true ? false : isError,
        message: message,
        isWarning: isLoading == true ? false : isWarning,
        error: error,
      );
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
        changeStates(isError: true, message: message);
      },
    );
  }

  Future<void> fetchLocationsAddress() async {
    searchProfilesViewState.states.value = States(isLoading: true);
    final response = await LocationsRepo.fetchLocations();
    searchProfilesViewState.states.value = States(isLoading: false);
    await response?.checkStatusResponse(
      onSuccess: (data, _) {
        if (data != null) {
          searchProfilesViewState.locationsAddressList = data
            ..insert(
              0,
              LocationAddress(id: null, name: 'All'),
            );
          searchProfilesViewState.states.value = States(isSuccess: true);
        }
      },
      onValidateError: (validateError, _) {},
      onError: (message, _) {
        searchProfilesViewState.states.value = States(isError: true);
      },
    );
  }

  void retryLastFailedRequest() {
    print("dd");
    if (InternetConnectionService.instance.isNotConnected) return;
    if (states.isLoading) return;
    changeStates(isError: false, message: '');
    pagingController.retryLastFailedRequest();
    _pageProfilesViewRequester(searchProfilesViewState.pageNumber);
  }

  void _pageProfilesViewRequester(int pageKey) async {
    changeStates(isLoading: true);
    await fetchSearchProfilesUsersPages(pageKey);
    changeStates(isLoading: false);
  }

  void refreshPage() {
    if (InternetConnectionService.instance.isNotConnected) return;
    if (states.isLoading) return;
    searchProfilesViewState.pageNumber = 1;
    pagingController.refresh();
    _pageProfilesViewRequester(searchProfilesViewState.pageNumber);
  }

  void onLoadMoreProfilesViewSubmitted() {
    if (InternetConnectionService.instance.isNotConnected) return;
    if (states.isLoading) return;
    _pageProfilesViewRequester(searchProfilesViewState.pageNumber);
  }

  @override
  void onInit() {
    super.onInit();
    fetchLocationsAddress();
    _pageProfilesViewRequester(searchProfilesViewState.pageNumber);
  }
}

class GeneralSearchProfilesViewState {
  final _locationsAddress = <LocationAddress>[].obs;

  List<LocationAddress> get locationsAddressList => _locationsAddress.toList();
  final states = States().obs;

  void resetStates() => states.value = States();

  List<String> get locationsAddressNameList => locationsAddressList
      .where((e) => e.name != null)
      .map((e) => e.name ?? '')
      .toList();

  set locationsAddressList(List<LocationAddress> value) =>
      _locationsAddress.value = value;
  final _selectedLocationAddressName = LocationAddress().obs;

  LocationAddress get selectedLocationAddress =>
      _selectedLocationAddressName.value;

  void set selectedLocationAddress(LocationAddress value) {
    _selectedLocationAddressName.value = value;
  }

  var pageNumber = 1;

  void incrementPageNumber() => pageNumber++;

  Map<String, String> get buildQuerySearch => {
        'page': '${pageNumber}',
        'per_page': "6",
        'location_id': (selectedLocationAddress.id ?? "").toString(),
        'name': GeneralSearchController
            .instance.generalSearchState.searchController.text
            .split(" ")
            .join("+"),
      }..removeWhere((_, v) => v.isEmpty);
}
