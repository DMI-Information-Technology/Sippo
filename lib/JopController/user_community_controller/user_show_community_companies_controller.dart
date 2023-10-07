import 'dart:async';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jobspot/JopController/user_community_controller/user_community_controller.dart';
import 'package:jobspot/sippo_data/model/auth_model/company_response_details.dart';
import 'package:jobspot/sippo_data/user_repos/user_community_repo.dart';

import '../../sippo_data/user_repos/user_companies_abouts_repo.dart';
import '../../utils/states.dart';

class UserShowCommunityCompaniesController extends GetxController {
  final pagingController =
      PagingController<int, CompanyDetailsResponseModel>(firstPageKey: 0);
  final communityController = UserCommunityController.instance;

  States get states => communityController.states;

  final postsState = UserShowCommunityCompaniesState();

  Future<void> fetchCommunityCompanies(int pageKey) async {
    final query = {'page': "${postsState.pageNumber}"};
    final response = await UserCommunityRepo.fetchCommunityCompanies(query);
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

  void changeFollowingState(
    CompanyDetailsResponseModel? company,
    bool Function(bool? isFollowing) predicate,
  ) {
    final followingState = company?.isFollowed;
    pagingController.itemList = pagingController.itemList?.map((e) {
      if (e.id == company?.id) {
        e = company?.copyWith(isFollowed: predicate(followingState)) ?? e;
      }
      return e;
    }).toList();
  }

  Future<void> toggleFollow(CompanyDetailsResponseModel company) async {
    changeFollowingState(company, (isFollowing) => !(isFollowing == true));
    final response = await UserCompaniesAboutsRepo.toggleFollow(company.id);
    await response?.checkStatusResponse(
      onSuccess: (data, _) {
        if (data != null) {
          pagingController.itemList = pagingController.itemList?.map((e) {
            if (e.id == company.id) e = data;
            return e;
          }).toList();
        }
      },
      onValidateError: (validateError, _) {
        changeFollowingState(company, (isFollowing) => isFollowing == true);
      },
      onError: (message, _) {
        changeFollowingState(company, (isFollowing) => isFollowing == true);
      },
    );
  }

  void onToggleSubmitted(CompanyDetailsResponseModel company) async {
    print("is Loading: ${states.isLoading}");
    if (states.isLoading) return;
    if (!communityController.isNetworkConnected) {
      communityController.changeStates(
        isWarning: true,
        isSuccess: false,
        message: "sorry your connection is lost,"
            " please check your settings before continuing.",
      );
      return;
    }
    if (company.id == null) return;
    communityController.changeStates(isLoading: true);
    await toggleFollow(company);
    communityController.changeStates(isLoading: false);
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
    await fetchCommunityCompanies(pageKey);
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

class UserShowCommunityCompaniesState {
  var _pageNumber = 1;

  int get pageNumber => _pageNumber.toInt();

  void set pageNumber(int value) => _pageNumber = value;

  void incrementPageNumber() => _pageNumber++;
}
