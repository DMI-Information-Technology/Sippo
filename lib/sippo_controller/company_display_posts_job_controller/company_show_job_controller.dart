import 'dart:async';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sippo/sippo_controller/company_display_posts_job_controller/company_show_job_post_wrapper_controller.dart';
import 'package:sippo/sippo_data/company_repos/company_job_repo.dart';
import 'package:sippo/sippo_data/model/auth_model/company_response_details.dart';
import 'package:sippo/sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';
import 'package:sippo/utils/states.dart';

class CompanyShowJobController extends GetxController {
  final pagingController =
      PagingController<int, CompanyJobModel>(firstPageKey: 0);
  final showWrapperController = CompanyShowJobPostWrapperController.instance;

  States get states => showWrapperController.states;

  void refreshJobsAfterEdit(dynamic value) {
    if (value case bool _) {
      refreshPage();
    }
  }

  final jobState = CompanyShowJobState();

  CompanyDetailsModel get company => showWrapperController.company;

  Future<void> fetchJobPages(int pageKey) async {
    final query = {'page': "${jobState.pageNumber}"};
    final response = await CompanyJobRepo.fetchJobs(query);
    response?.checkStatusResponse(
      onSuccess: (data, _) {
        final lastPage = data?.meta?.lastPage ?? jobState.pageNumber;
        if (jobState.pageNumber >= lastPage) {
          pagingController.appendLastPage(data?.data ?? []);
        } else {
          final newDataLength = data?.data?.length ?? 0;
          final int nextKey = pageKey + newDataLength;
          pagingController.appendPage(data?.data ?? [], nextKey);
          jobState.incrementPageNumber();
        }
      },
      onValidateError: (validateError, _) {},
      onError: (message, _) {
        pagingController.error = true;
        showWrapperController.changeStates(isError: true, message: message);
      },
    );
  }

  Future<void> updateStatusJobById(int? id) async {
    showWrapperController.changeStates(isLoading: true);
    final response = await CompanyJobRepo.updateStatusJobById(id);
    final result = await response?.checkStatusResponseAndGetData(
      onValidateError: (validateError, _) {
        showWrapperController.changeStates(
            isError: true, error: validateError?.message);
      },
      onError: (message, _) {
        showWrapperController.changeStates(isError: true, message: message);
      },
    );
    showWrapperController.changeStates(isLoading: false);
    if (result != null) {
      refreshPage();
      showWrapperController.changeStates(
        isSuccess: true,
        message: 'job_status_updated_message'.tr,
      );
    }
  }

  Future<void> onUpdateStatusJobSubmitted(int? postId) async {
    if (!showWrapperController.isNetworkConnected) {
      showWrapperController.changeStates(
        isWarning: true,
        isSuccess: false,
        message: "connection_lost_message_1".tr,
      );
      return;
    }
    showWrapperController.changeStates(isLoading: true);
    await updateStatusJobById(postId);
  }

  void refreshPage() {
    if (!showWrapperController.isNetworkConnected) {
      showWrapperController.changeStates(
        isWarning: true,
        isSuccess: false,
        message: "connection_lost_message_1".tr,
      );
      return;
    }
    if (states.isLoading) return;
    jobState.pageNumber = 1;
    pagingController.refresh();
  }

  void retryLastFieldRequest() {
    pagingController.retryLastFailedRequest();
  }

  void _pageRequester(int pageKey) async {
    showWrapperController.changeStates(isLoading: true);
    await fetchJobPages(pageKey);
    showWrapperController.changeStates(isLoading: false);
  }

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener(_pageRequester);
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}

class CompanyShowJobState {
  var _pageNumber = 1;

  int get pageNumber => _pageNumber.toInt();

  void set pageNumber(int value) => _pageNumber = value;

  void incrementPageNumber() => _pageNumber++;
}
