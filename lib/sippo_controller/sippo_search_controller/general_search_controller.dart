import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:sippo/sippo_controller/sippo_search_controller/general_search_users_view_controller.dart';
import 'package:sippo/utils/getx_text_editing_controller.dart';
import 'general_search_companies_controller.dart';
import 'genral_search_jobs_controller.dart';

class GeneralSearchController extends GetxController {
  static GeneralSearchController get instance => Get.find();
  late final TabController tabController;
  final RestorableInt tabIndex = RestorableInt(0);
  final generalSearchState = GeneralSearchState();

  bool get isRefreshPrevented =>
      InternetConnectionService.instance.isNotConnected;

  void onSearchSubmitted() async {
    print(isRefreshPrevented);
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
    print('tab index: ${generalSearchState.tabsIndex}');
    switch (generalSearchState.tabsIndex) {
      case 0:
        if (Get.isRegistered<GeneralTopSearchCompaniesController>()) {
          GeneralTopSearchCompaniesController.instance.refreshPage();
        }
        if (Get.isRegistered<GeneralTopSearchJobsController>()) {
          GeneralTopSearchJobsController.instance.refreshPage();
        }
      case 1:
        if (Get.isRegistered<GeneralSearchCompaniesController>()) {
          GeneralSearchCompaniesController.instance.refreshPage();
        }
      case 2:
        if (Get.isRegistered<GeneralSearchJobsController>()) {
          GeneralSearchJobsController.instance.refreshPage();
        }
      case 3:
        if (Get.isRegistered<GeneralSearchProfilesViewController>()) {
          GeneralSearchProfilesViewController.instance.refreshPage();
        }
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

class   GeneralSearchState {
  var _tabsIndex = 0;
  final searchController = GetXTextEditingController();
  bool isSearchFiledCleared = true;


  int get tabsIndex => _tabsIndex;

  void set tabsIndex(int value) {
    Get.focusScope?.unfocus();
    if (value > 4 || value < 0 || value == tabsIndex) return;
    isJobTab = value == 2;
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
