import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jobspot/JopController/user_community_controller/user_about_companies_controllers.dart';
import 'package:jobspot/sippo_data/model/auth_model/company_response_details.dart';

import '../../sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';
import '../../sippo_data/user_repos/user_companies_abouts_repo.dart';

class ShowAboutsCompaniesJobsController extends GetxController {
  final aboutCompaniesController = UserAboutCompaniesController.instance;
  final pagingJobController =
      PagingController<int, CompanyJobModel>(firstPageKey: 0);

  CompanyDetailsModel get company =>
      aboutCompaniesController.aboutState.company;

  final showJobsState = AboutsCompaniesPostsController();

  Future<void> fetchJobPages(int pageKey) async {
    final query = {'page': "${showJobsState.pageJobNumber}"};
    final response = await UserCompaniesAboutsRepo.fetchAboutCompanyJobs(
      query,
      company.id,
    );
    response?.checkStatusResponse(
      onSuccess: (data, _) {
        final lastPage = data?.meta?.lastPage ?? showJobsState.pageJobNumber;
        if (showJobsState.pageJobNumber >= lastPage) {
          pagingJobController.appendLastPage(data?.data ?? []);
        } else {
          final newDataLength = data?.data?.length ?? 0;
          final int nextKey = pageKey + newDataLength;
          pagingJobController.appendPage(data?.data ?? [], nextKey);
          showJobsState.incrementPageJobNumber();
        }
      },
      onValidateError: (validateError, _) {},
      onError: (message, _) {
        pagingJobController.error = true;
        aboutCompaniesController.changeStates(isError: true, message: message);
      },
    );
  }

  void retryLastFailedRequest() => pagingJobController.retryLastFailedRequest();

  void _pageJobRequester(int pageKey) async {
    aboutCompaniesController.changeStates(isLoading: true);
    await fetchJobPages(pageKey);
    aboutCompaniesController.changeStates(isLoading: false);
  }

  @override
  void onInit() {
    pagingJobController.addPageRequestListener(_pageJobRequester);
    super.onInit();
  }

  @override
  void onClose() {
    pagingJobController.dispose();
    super.onClose();
  }
}

class AboutsCompaniesPostsController {
  var _pageJobNumber = 1;

  int get pageJobNumber => _pageJobNumber.toInt();

  void set pageJobNumber(int value) => _pageJobNumber = value;

  void incrementPageJobNumber() => _pageJobNumber++;
}
