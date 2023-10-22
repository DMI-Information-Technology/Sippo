import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jobspot/JopController/user_community_controller/user_about_companies_controllers.dart';
import 'package:jobspot/sippo_data/model/auth_model/company_response_details.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';
import 'package:jobspot/sippo_data/user_repos/user_companies_abouts_repo.dart';
import 'package:jobspot/utils/states.dart';

import '../../JobServices/ConnectivityController/internet_connection_controller.dart';
import '../../core/Refresh.dart';
import '../../sippo_data/user_repos/user_saved_job_repo.dart';

class ShowAboutsCompaniesJobsController extends GetxController {
  static ShowAboutsCompaniesJobsController get instance => Get.find();
  final _aboutCompaniesController = UserAboutCompaniesController.instance;
  final pagingController =
      PagingController<int, CompanyJobModel>(firstPageKey: 0);
  final _states = States().obs;

  States get states => _states.value;

  void set states(States value) => _states.value = value;

  CompanyDetailsModel get company =>
      _aboutCompaniesController.aboutState.company;

  final showJobsState = AboutsCompaniesPostsController();

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

  Future<void> toggleSavedJobs(int index, int? id) async {
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
  void onToggleSavedJobsSubmitted(int index, int? id) async {
    if (InternetConnectionService.instance.isNotConnected) return;
    await toggleSavedJobs(index, id);
  }

  Future<void> fetchJobPages(int pageKey) async {
    final query = {'page': "${showJobsState.pageNumber}"};
    final response = await UserCompaniesAboutsRepo.fetchAboutCompanyJobs(
      query,
      company.id,
    );
    response?.checkStatusResponse(
      onSuccess: (data, _) {
        final lastPage = data?.meta?.lastPage ?? showJobsState.pageNumber;
        if (showJobsState.pageNumber >= lastPage) {
          pagingController.appendLastPage(data?.data ?? []);
        } else {
          final newDataLength = data?.data?.length ?? 0;
          final int nextKey = pageKey + newDataLength;
          pagingController.appendPage(data?.data ?? [], nextKey);
          showJobsState.incrementPageJobNumber();
        }
      },
      onValidateError: (validateError, _) {},
      onError: (message, _) {
        pagingController.error = true;
        states = states.copyWith(isError: true, message: message);
      },
    );
  }


  void retryLastFailedRequest() => pagingController.retryLastFailedRequest();

  void _pageJobRequester(int pageKey) async {
    states = States(isLoading: true);
    await fetchJobPages(pageKey);
    states = states.copyWith(isLoading: false);
  }

  Future<void> refreshPage() async {
    if (InternetConnectionService.instance.isNotConnected) return;
    if (states.isLoading) return;
    showJobsState.pageNumber = 1;
    pagingController.refresh();
  }

  @override
  void onInit() {
    pagingController.addPageRequestListener(_pageJobRequester);
    super.onInit();
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}

class AboutsCompaniesPostsController {
  var _pageNumber = 1;

  int get pageNumber => _pageNumber.toInt();

  void set pageNumber(int value) => _pageNumber = value;

  void incrementPageJobNumber() => _pageNumber++;
}
