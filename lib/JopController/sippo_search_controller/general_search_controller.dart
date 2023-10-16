import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/JopController/sippo_search_controller/general_search_users_view_controller.dart';

import 'package:jobspot/utils/getx_text_editing_controller.dart';
import 'package:jobspot/utils/states.dart';
import 'general_search_companies_controller.dart';
import 'genral_search_jobs_controller.dart';

class UserGeneralSearchController extends GetxController {
  static UserGeneralSearchController get instance => Get.find();
  final _states = States().obs;

  States get states => _states.value;

  void resetStates() => _states.value = States();
  final generalSearchState = GeneralSearchState();

  void changeStates({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    bool? isWarning,
    String? message,
    String? error,
  }) =>
      _states.value = states.copyWith(
        isLoading: isLoading,
        isSuccess: isLoading == true ? false : isSuccess,
        isError: isLoading == true ? false : isError,
        message: message,
        isWarning: isLoading == true ? false : isWarning,
        error: error,
      );

  bool get isRefreshPrevented =>
      states.isLoading || InternetConnectionService.instance.isNotConnected;

  void onSearchSubmitted() async {
    if (isRefreshPrevented) return;
    if (generalSearchState.isTextSearchEmpty) {
      generalSearchState.searchController.clear();
      Get.focusScope?.unfocus();
      return;
    }
    generalSearchState.isSearchFiledCleared = false;
    refreshSearchPage();
  }

  void onClearSearchFiledSubmitted() {
    if (generalSearchState.isTextSearchNotEmpty) {
      generalSearchState.searchController.clear();
      return;
    }
    if (generalSearchState.isSearchFiledCleared) {
      Get.focusScope?.unfocus();
      return;
    }
    generalSearchState.isSearchFiledCleared = true;
    generalSearchState.searchController.clear();
    refreshSearchPage();
  }

  void refreshSearchPage() {
    switch (generalSearchState.tabsIndex) {
      case 0:
        if (Get.isRegistered<GeneralSearchCompaniesController>()) {
          GeneralSearchCompaniesController.instance.refreshPage();
        }
        break;
      case 1:
        if (Get.isRegistered<GeneralSearchJobsController>()) {
          GeneralSearchJobsController.instance.refreshPage();
        }
        break;
      case 2:
        if (Get.isRegistered<GeneralSearchProfilesViewController>()) {
          GeneralSearchProfilesViewController.instance.refreshPage();
        }
        break;
    }
  }

  @override
  void onInit() {
    super.onInit();
    generalSearchState.startListenState();
  }

  @override
  void onClose() {
    generalSearchState.close();
    super.onClose();
  }
}

class GeneralSearchState {
  var _tabsIndex = 0;
  final searchController = GetXTextEditingController();
  bool isSearchFiledCleared = true;

  int get tabsIndex => _tabsIndex;

  void set tabsIndex(int value) {
    Get.focusScope?.unfocus();
    if (value > 3 || value < 0 || value == tabsIndex) return;
    isJobTab = value == 1;
    _tabsIndex = value;
  }

  bool get isTextSearchNotEmpty => !searchController.isTextEmpty;

  bool get isTextSearchEmpty => searchController.isTextEmpty;
  final _hasFocus = true.obs;

  bool get hasFocus => _hasFocus.isTrue;

  set hasFocus(bool value) {
    _hasFocus.value = value;
  }

  final _isJobTab = false.obs;
  final focusNode = FocusNode();

  bool get isJobTab => _isJobTab.isTrue;

  set isJobTab(bool value) {
    _isJobTab.value = value;
  }

  void startListenState() {
    focusNode.addListener(_onHasFocus);
  }

  void _onHasFocus() {
    hasFocus = !focusNode.hasFocus;
  }

  void close() {
    searchController.dispose();
    focusNode.dispose();
  }
}
