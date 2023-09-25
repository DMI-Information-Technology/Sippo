import 'dart:async';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jobspot/JopController/user_community_controller/user_community_controller.dart';
import 'package:jobspot/sippo_data/user_repos/user_community_repo.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/company_post_model.dart';

import '../../utils/states.dart';

class UserShowCommunityPostsController extends GetxController {
  final pagingController =
      PagingController<int, CompanyDetailsPostModel>(firstPageKey: 0);
  final communityController = UserCommunityController.instance;

  States get states => communityController.states;

  final postsState = UserShowCommunityPostsState();

  Future<void> fetchCommunityPostsPages(int pageKey) async {
    final query = {'page': "${postsState.pageNumber}"};
    final response = await UserCommunityRepo.fetchCommunityPosts(query);
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
        communityController.changeStates(isError: true, message: message);
      },
    );
  }

  void refreshPage() {
    if (!communityController.isNetworkConnected) {
      communityController.changeStates(
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
    communityController.changeStates(isLoading: true);
    await fetchCommunityPostsPages(pageKey);
    communityController.changeStates(isLoading: false);
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

class UserShowCommunityPostsState {
  var _pageNumber = 1;

  int get pageNumber => _pageNumber.toInt();

  void set pageNumber(int value) => _pageNumber = value;

  void incrementPageNumber() => _pageNumber++;
}
