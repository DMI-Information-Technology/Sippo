import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jobspot/JopController/user_community_controller/user_about_companies_controllers.dart';
import 'package:jobspot/sippo_data/model/auth_model/company_response_details.dart';
import '../../sippo_data/model/profile_model/company_profile_resource_model/company_post_model.dart';
import '../../sippo_data/user_repos/user_companies_abouts_repo.dart';

class ShowAboutsCompaniesPostsController extends GetxController {
  final aboutCompaniesController = UserAboutCompaniesController.instance;

  CompanyDetailsModel get company =>
      aboutCompaniesController.aboutState.company;
  final pagingPostsController =
      PagingController<int, CompanyDetailsPostModel>(firstPageKey: 0);
  final showPostState = AboutsCompaniesPostsController();

  Future<void> fetchPostsPages(int pageKey) async {
    final query = {'page': "${showPostState.pagePostNumber}"};
    final response = await UserCompaniesAboutsRepo.fetchAboutCompanyPosts(
      query,
      aboutCompaniesController.aboutState.company.id,
    );
    response?.checkStatusResponse(
      onSuccess: (data, _) {
        final lastPage = data?.meta?.lastPage ?? showPostState.pagePostNumber;
        if (showPostState.pagePostNumber >= lastPage) {
          pagingPostsController.appendLastPage(data?.data ?? []);
        } else {
          final newDataLength = data?.data?.length ?? 0;
          final int nextKey = pageKey + newDataLength;
          pagingPostsController.appendPage(data?.data ?? [], nextKey);
          showPostState.incrementPagePostNumber();
        }
      },
      onValidateError: (validateError, _) {},
      onError: (message, _) {
        pagingPostsController.error = true;
        aboutCompaniesController.changeStates(isError: true, message: message);
      },
    );
  }

  void _pagePostRequester(int pageKey) async {
    aboutCompaniesController.changeStates(isLoading: true);
    await fetchPostsPages(pageKey);
    aboutCompaniesController.changeStates(isLoading: false);
  }

  @override
  void onInit() {
    pagingPostsController.addPageRequestListener(_pagePostRequester);
    super.onInit();
  }

  @override
  void onClose() {
    pagingPostsController.dispose();
    super.onClose();
  }
}

class AboutsCompaniesPostsController {
  var _pagePostNumber = 1;

  int get pagePostNumber => _pagePostNumber.toInt();

  void set pagePostNumber(int value) => _pagePostNumber = value;

  void incrementPagePostNumber() => _pagePostNumber++;
}
