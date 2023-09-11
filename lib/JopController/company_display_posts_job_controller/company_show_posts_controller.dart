import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jobspot/JopController/company_display_posts_job_controller/company_show_job_post_wrapper_controller.dart';
import 'package:jobspot/sippo_data/company_user/company_posts_repo.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/company_post_model.dart';

import '../../sippo_data/model/auth_model/company_response_details.dart';
import '../../utils/states.dart';

class CompanyShowPostsController extends GetxController {
  final pagingController =
      PagingController<int, CompanyResponsePostModel>(firstPageKey: 0);
  final showWrapperController = CompanyShowJobPostWrapperController.instance;

  States get states => showWrapperController.states;

  void refreshPostsAfterEdit(dynamic value) {
    if (value is bool && value.runtimeType == bool && value == true) {
      refreshPage();
    }
  }

  final postsState = CompanyShowPostsState();

  CompanyResponseDetailsModel get company => showWrapperController.company;

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
    if (!showWrapperController.isNetworkConnection) {
      showWrapperController.changeStates(
        isWarning: true,
        isSuccess: false,
        message:
            "sorry your connection is lost, please check your settings before continuing.",
      );
      return;
    }
    await deletePostById(postId);
  }

  void refreshPage() {
    if (!showWrapperController.isNetworkConnection) {
      showWrapperController.changeStates(
        isWarning: true,
        isSuccess: false,
        message:
            "sorry your connection is lost, please check your settings before continuing.",
      );
      return;
    }
    postsState.pageNumber = 1;
    pagingController.refresh();
  }

  void retryLastFieldRequest() {
    pagingController.retryLastFailedRequest();
  }

  void _pageRequester(int pageKey) async {
    if (states.isLoading) return;
    showWrapperController.changeStates(isLoading: true);
    await fetchPostPages(pageKey);
    showWrapperController.changeStates(isLoading: false);
  }

  @override
  void onInit() {
    pagingController.addPageRequestListener(_pageRequester);
    super.onInit();
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
