import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jobspot/JopController/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/sippo_data/model/auth_model/company_response_details.dart';

import '../../utils/getx_text_editing_controller.dart';
import '../../utils/states.dart';
import 'general_search_companies_controller.dart';
import 'genral_search_jobs_controller.dart';

class UserGeneralSearchController extends GetxController {
  // final pagingJobsController =
  //     PagingController<int, CompanyJobModel>(firstPageKey: 0);
  final pagingCompaniesController =
      PagingController<int, CompanyDetailsResponseModel>(firstPageKey: 0);

  static UserGeneralSearchController get instance => Get.find();
  final _states = States().obs;

  States get states => _states.value;
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

  void onSearchSubmitted() async {
    if (states.isLoading) return;
    if (!InternetConnectionController.instance.isConnected) return;
    refreshSearchPage();
  }

  void onClearSearchFiledSubmitted() {
    generalSearchState.searchController.clearText();
    refreshSearchPage();
  }

  void refreshSearchPage() {

    if (generalSearchState.tabsIndex == 0) {
      if (Get.isRegistered<GeneralSearchCompaniesController>()) {

        GeneralSearchCompaniesController.instance.refreshPage();
      }
      return;
    }
    if (Get.isRegistered<GeneralSearchJobsController>()) {
      GeneralSearchJobsController.instance.refreshPage();
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

  int get tabsIndex => _tabsIndex;

  void set tabsIndex(int value) {
    if (value > 1 || value < 0 || value == tabsIndex) return;
    _tabsIndex = value;
  }

  bool get isTextSearchNotEmpty => searchController.text.isEmpty;
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
    // print(isArrowBack);
    hasFocus = !focusNode.hasFocus;
  }

  void close() {
    searchController.dispose();
    focusNode.removeListener(_onHasFocus);
    focusNode.dispose();
  }
}
