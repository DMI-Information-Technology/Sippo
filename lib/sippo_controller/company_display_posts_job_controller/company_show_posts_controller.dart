import 'dart:async';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sippo/sippo_controller/company_display_posts_job_controller/company_show_job_post_wrapper_controller.dart';
import 'package:sippo/sippo_data/company_repos/company_posts_repo.dart';
import 'package:sippo/sippo_data/model/auth_model/company_response_details.dart';
import 'package:sippo/sippo_data/model/profile_model/company_profile_resource_model/company_post_model.dart';
import 'package:sippo/utils/states.dart';

class CompanyShowPostsController extends GetxController {
  final pagingController =
      PagingController<int, CompanyDetailsPostModel>(firstPageKey: 0);
  final showWrapperController = CompanyShowJobPostWrapperController.instance;

  States get states => showWrapperController.states;

  void refreshPostsAfterEdit(dynamic value) {
    if (value case bool _) {
      refreshPage();
    }
  }

  final postsState = CompanyShowPostsState();

  CompanyDetailsModel get company => showWrapperController.company;

  Future<void> fetchPostPages(int pageKey) async {
    final query = {'page': "${postsState.pageNumber}"};
    final response = await CompanyPostRepo.fetchPosts(query);
    response?.checkStatusResponse(
      onSuccess: (data, _) {
        final lastPage = data?.meta?.lastPage ?? postsState.pageNumber;
        if (postsState.pageNumber >= lastPage) {
          pagingController.appendLastPage(data?.data ?? []);
        } else {
          final newDataLength = data?.data?.length ?? 0;
          final int nextKey = pageKey + newDataLength;
          pagingController.appendPage(data?.data ?? [], nextKey);
          postsState.incrementPageNumber();
        }
      },
      onValidateError: (validateError, _) {},
      onError: (message, _) {
        pagingController.error = true;
        showWrapperController.changeStates(isError: true, message: message);
      },
    );
  }

  Future<void> deletePostById(int? id) async {
    showWrapperController.changeStates(isLoading: true);
    final response = await CompanyPostRepo.deletePostById(id);
    final result = await response?.checkStatusResponseAndGetData(
      onSuccess: (data, _) {
        showWrapperController.changeStates(isSuccess: true);
      },
      onValidateError: (validateError, _) {
        showWrapperController.changeStates(
            isError: true, error: validateError?.message);
      },
      onError: (message, _) {
        showWrapperController.changeStates(isError: true, message: message);
      },
    );
    showWrapperController.changeStates(isLoading: false);
    if (result == true) refreshPage();
  }

  Future<void> onDeletePostSubmitted(int? postId) async {
    if (!showWrapperController.isNetworkConnected) {
      showWrapperController.changeStates(
        isWarning: true,
        isSuccess: false,
        message: "connection_lost_message_1".tr,
      );
      return;
    }
    await deletePostById(postId);
  }

  void refreshPage() {
    if (!showWrapperController.isNetworkConnected) {
      showWrapperController.changeStates(
        isWarning: true,
        isSuccess: false,
        message: "sorry your connection is lost,"
            " please check your settings before continuing.",
      );
      return;
    }
    if (states.isLoading) return;
    postsState.pageNumber = 1;
    pagingController.refresh();
  }

  void retryLastFieldRequest() {
    pagingController.retryLastFailedRequest();
  }

  void _pageRequester(int pageKey) async {
    showWrapperController.changeStates(isLoading: true);
    await fetchPostPages(pageKey);
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

class CompanyShowPostsState {
  var _pageNumber = 1;

  int get pageNumber => _pageNumber.toInt();

  void set pageNumber(int value) => _pageNumber = value;

  void incrementPageNumber() => _pageNumber++;
}
