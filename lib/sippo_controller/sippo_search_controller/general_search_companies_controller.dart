import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sippo/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:sippo/sippo_controller/sippo_search_controller/general_search_controller.dart';
import 'package:sippo/sippo_data/model/auth_model/company_response_details.dart';
import 'package:sippo/sippo_data/user_repos/user_companies_abouts_repo.dart';
import 'package:sippo/utils/states.dart';

class GeneralSearchCompaniesController extends GetxController {
  final generalSearchController = GeneralSearchController.instance;

  static GeneralSearchCompaniesController get instance => Get.find();
  final pagingController =
      PagingController<int, CompanyDetailsModel>(firstPageKey: 0);
  final searchCompaniesState = GeneralSearchCompaniesState(perPage: 6);
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
  Future<void> fetchSearchCompaniesPages(
    int pageKey,
  ) async {
    final response = await UserCompaniesAboutsRepo.fetchCompanies(
      searchCompaniesState.buildQuerySearch,
    );
    response?.checkStatusResponse(
      onSuccess: (data, _) {
        final lastPage =
            data?.meta?.lastPage ?? searchCompaniesState.pageNumber;
        if (searchCompaniesState.pageNumber >= lastPage) {
          pagingController.appendLastPage(data?.data ?? []);
        } else {
          final newDataLength = data?.data?.length ?? 0;
          final int nextKey = pageKey + newDataLength;
          pagingController.appendPage(data?.data ?? [], nextKey);
          searchCompaniesState.incrementPageNumber();
        }
      },
      onValidateError: (validateError, _) {},
      onError: (message, _) {
        pagingController.error = true;
        changeStates(isError: true, message: message);
      },
    );
  }

  void retryLastFailedRequest() {
    print("dd");
    if (InternetConnectionService.instance.isNotConnected) return;
    if (states.isLoading) return;
    changeStates(isError: false, message: '');
    pagingController.retryLastFailedRequest();
    _pageCompaniesRequester(searchCompaniesState.pageNumber);
  }

  void _pageCompaniesRequester(int pageKey) async {
    changeStates(isLoading: true);
    await fetchSearchCompaniesPages(pageKey);
    changeStates(isLoading: false);
  }

  void refreshPage() {
    print('hello');
    if (InternetConnectionService.instance.isNotConnected) return;
    if (states.isLoading) return;
    searchCompaniesState.pageNumber = 1;
    pagingController.refresh();
    _pageCompaniesRequester(searchCompaniesState.pageNumber);
  }

  void onLoadMoreCompaniesSubmitted() {
    Get.focusScope?.unfocus();
    if (InternetConnectionService.instance.isNotConnected) return;
    if (states.isLoading) return;
    _pageCompaniesRequester(searchCompaniesState.pageNumber);
  }

  @override
  void onInit() {
    super.onInit();
    _pageCompaniesRequester(searchCompaniesState.pageNumber);
  }
}

class GeneralSearchCompaniesState {
  var pageNumber = 1;
  final int perPage;

  GeneralSearchCompaniesState({required this.perPage});

  void incrementPageNumber() => pageNumber++;

  Map<String, String> get buildQuerySearch => {
        'page': '${pageNumber}',
        'per_page': "$perPage",
        'name': GeneralSearchController
            .instance.generalSearchState.searchController.text
            .split(" ")
            .join("+"),
      };
}

class GeneralTopSearchCompaniesController extends GetxController {
  final generalSearchController = GeneralSearchController.instance;

  static GeneralTopSearchCompaniesController get instance => Get.find();
  final pagingController =
      PagingController<int, CompanyDetailsModel>(firstPageKey: 0);
  final searchCompaniesState = GeneralSearchCompaniesState(perPage: 4);

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
  Future<void> fetchSearchCompaniesPages(
    int pageKey,
  ) async {
    final response = await UserCompaniesAboutsRepo.fetchCompanies(
      searchCompaniesState.buildQuerySearch,
    );
    response?.checkStatusResponse(
      onSuccess: (data, _) {
        final lastPage =
            data?.meta?.lastPage ?? searchCompaniesState.pageNumber;
        if (searchCompaniesState.pageNumber >= lastPage) {
          pagingController.appendLastPage(data?.data ?? []);
        } else {
          final newDataLength = data?.data?.length ?? 0;
          final int nextKey = pageKey + newDataLength;
          pagingController.appendPage(data?.data ?? [], nextKey);
          searchCompaniesState.incrementPageNumber();
        }
      },
      onValidateError: (validateError, _) {},
      onError: (message, _) {
        pagingController.error = true;
        changeStates(isError: true, message: message);
      },
    );
  }

  void retryLastFailedRequest() {
    print("dd");
    if (InternetConnectionService.instance.isNotConnected) return;
    if (states.isLoading) return;
    changeStates(isError: false, message: '');
    pagingController.retryLastFailedRequest();
    _pageCompaniesRequester(searchCompaniesState.pageNumber);
  }

  void _pageCompaniesRequester(int pageKey) async {
    changeStates(isLoading: true);
    await fetchSearchCompaniesPages(pageKey);
    changeStates(isLoading: false);
  }

  void refreshPage() {
    if (InternetConnectionService.instance.isNotConnected) return;
    if (states.isLoading) return;
    searchCompaniesState.pageNumber = 1;
    pagingController.refresh();
    _pageCompaniesRequester(searchCompaniesState.pageNumber);
  }


  @override
  void onInit() {
    super.onInit();
    _pageCompaniesRequester(searchCompaniesState.pageNumber);
  }
}
