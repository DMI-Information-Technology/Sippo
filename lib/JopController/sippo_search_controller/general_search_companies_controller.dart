import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jobspot/JopController/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/JopController/sippo_search_controller/general_search_controller.dart';
import 'package:jobspot/sippo_data/model/auth_model/company_response_details.dart';
import 'package:jobspot/sippo_data/user_repos/user_companies_abouts_repo.dart';
import 'package:jobspot/utils/states.dart';

class GeneralSearchCompaniesController extends GetxController {
  final generalSearchController = UserGeneralSearchController.instance;

  static GeneralSearchCompaniesController get instance => Get.find();
  final pagingController =
      PagingController<int, CompanyDetailsResponseModel>(firstPageKey: 0);
  final searchCompaniesState = GeneralSearchCompaniesState();

  States get states => generalSearchController.states;

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
        generalSearchController.changeStates(isError: true, message: message);
      },
    );
  }

  void retryLastFailedRequest() {
    print("dd");
    if (InternetConnectionController.instance.isNotConnected) return;
    if (generalSearchController.states.isLoading) return;
    generalSearchController.changeStates(isError: false, message: '');
    pagingController.retryLastFailedRequest();
    _pageCompaniesRequester(searchCompaniesState.pageNumber);
  }

  void _pageCompaniesRequester(int pageKey) async {
    generalSearchController.changeStates(isLoading: true);
    await fetchSearchCompaniesPages(pageKey);
    generalSearchController.changeStates(isLoading: false);
  }

  void refreshPage() {
    if (InternetConnectionController.instance.isNotConnected) return;
    if (generalSearchController.states.isLoading) return;
    searchCompaniesState.pageNumber = 1;
    pagingController.refresh();
    _pageCompaniesRequester(searchCompaniesState.pageNumber);
  }

  void onLoadMoreCompaniesSubmitted() {
    if (InternetConnectionController.instance.isNotConnected) return;
    if (generalSearchController.states.isLoading) return;
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
