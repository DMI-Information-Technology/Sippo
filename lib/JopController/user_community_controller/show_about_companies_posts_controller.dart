import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jobspot/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/JopController/user_community_controller/user_about_companies_controllers.dart';
import 'package:jobspot/sippo_data/model/auth_model/company_response_details.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/company_post_model.dart';
import 'package:jobspot/sippo_data/user_repos/user_companies_abouts_repo.dart';

import '../../utils/states.dart';

class ShowAboutsCompaniesPostsController extends GetxController {
  final _aboutCompaniesController = UserAboutCompaniesController.instance;

  static ShowAboutsCompaniesPostsController get instance => Get.find();

  CompanyDetailsModel get company =>
      _aboutCompaniesController.aboutState.company;
  final pagingController =
      PagingController<int, CompanyDetailsPostModel>(firstPageKey: 0);
  final showPostState = AboutsCompaniesPostsController();
 final _states = States().obs;
  States get states => _states.value;
  void set states(States value) => _states.value = value;

  Future<void> fetchPostsPages(int pageKey) async {
    final query = {'page': "${showPostState.pageNumber}"};
    final response = await UserCompaniesAboutsRepo.fetchAboutCompanyPosts(
      query,
      _aboutCompaniesController.aboutState.company.id,
    );
    response?.checkStatusResponse(
      onSuccess: (data, _) {
        final lastPage = data?.meta?.lastPage ?? showPostState.pageNumber;
        if (showPostState.pageNumber >= lastPage) {
          pagingController.appendLastPage(data?.data ?? []);
        } else {
          final newDataLength = data?.data?.length ?? 0;
          final int nextKey = pageKey + newDataLength;
          pagingController.appendPage(data?.data ?? [], nextKey);
          showPostState.incrementPagePostNumber();
        }
      },
      onValidateError: (validateError, _) {},
      onError: (message, _) {
        pagingController.error = true;
        states = states.copyWith(isError: true, message: message);
      },
    );
  }

  Future<void> refreshPage() async {
    if (InternetConnectionService.instance.isNotConnected) return;
    if (states.isLoading) return;
    showPostState.pageNumber = 1;
    pagingController.refresh();
  }

  void _pagePostRequester(int pageKey) async {
states = States(isLoading: true);
    await fetchPostsPages(pageKey);
states = states.copyWith(isLoading: false);
  }

  @override
  void onInit() {
    pagingController.addPageRequestListener(_pagePostRequester);
    super.onInit();
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}

class AboutsCompaniesPostsController {
  var _pagePostNumber = 1;

  int get pageNumber => _pagePostNumber.toInt();

  void set pageNumber(int value) => _pagePostNumber = value;

  void incrementPagePostNumber() => _pagePostNumber++;
}
