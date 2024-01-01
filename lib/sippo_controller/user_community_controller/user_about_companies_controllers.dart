import 'package:get/get.dart';
import 'package:sippo/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:sippo/JobServices/shared_global_data_service.dart';
import 'package:sippo/sippo_data/model/auth_model/company_response_details.dart';
import 'package:sippo/sippo_data/user_repos/user_companies_abouts_repo.dart';
import 'package:sippo/utils/states.dart';

import 'show_about_companies_jobs_controller.dart';
import 'show_about_companies_posts_controller.dart';

class UserAboutCompaniesController extends GetxController {
  static UserAboutCompaniesController get instance => Get.find();

  final companyId = SharedGlobalDataService.instance.companyGlobalState.id;

  bool get isNetworkConnected => InternetConnectionService.instance.isConnected;
  final aboutState = UserAboutCompaniesState();
  final _states = States().obs;

  States get states => _states.value;

  void resetStates() => _states.value = States();

  void changeStates({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    bool? isWarning,
    String? message,
    String? error,
  }) {
    print("is loading:  $isLoading");
    _states.value = states.copyWith(
      isLoading: isLoading,
      isSuccess: isLoading == true ? false : isSuccess,
      isError: isLoading == true ? false : isError,
      message: message,
      isWarning: isLoading == true ? false : isWarning,
      error: error,
    );
  }

  Future<void> toggleFollow(int id) async {
    final followingState = aboutState.company.isFollowed;
    aboutState.company = aboutState.company.copyWith(
      isFollowed: !(followingState == true),
    );
    final response = await UserCompaniesAboutsRepo.toggleFollow(id);
    await response?.checkStatusResponse(
      onSuccess: (data, _) {
        if (data != null) {
          aboutState.company = data;
          SharedGlobalDataService.instance.companyGlobalState.details =
              aboutState.company;
        }
      },
      onValidateError: (validateError, _) {
        aboutState.company = aboutState.company.copyWith(
          isFollowed: followingState == true,
        );
      },
      onError: (message, _) {
        aboutState.company = aboutState.company.copyWith(
          isFollowed: followingState == true,
        );
      },
    );
  }

  Future<void> getCompanyById(int id) async {
    final response = await UserCompaniesAboutsRepo.getCompanyById(id);
    await response?.checkStatusResponse(
      onSuccess: (data, _) {
        if (data != null) aboutState.company = data;
      },
      onValidateError: (validateError, _) {},
      onError: (message, _) {},
    );
  }

  void onToggleSubmitted() async {
    if (states.isLoading) return;
    if (!isNetworkConnected) {
      changeStates(
        isWarning: true,
        isSuccess: false,
        message: "connection_lost_message_1".tr,
      );
      return;
    }

    if (companyId != -1) {
      changeStates(isLoading: true);
      await toggleFollow(companyId);
      changeStates(isLoading: false);
    }
  }

  void startController() async {
    aboutState.company =
        SharedGlobalDataService.instance.companyGlobalState.details ??
            aboutState.company;
    if (companyId != -1) {
      changeStates(isLoading: true);
      await getCompanyById(companyId);
      changeStates(isLoading: false);
    }
    final tapIndex = SharedGlobalDataService.instance.companyGlobalState
        .args?[SharedGlobalDataService.SELECTED_TAP_INDEX];
    if (tapIndex != null && tapIndex is int && tapIndex >= 0 && tapIndex < 3) {
      aboutState.selectedTaps = tapIndex;
    }
  }

  void onRefreshPaged() async {
    switch (aboutState.selectedTaps) {
      case 1:
        if (Get.isRegistered<ShowAboutsCompaniesPostsController>()) {
          await ShowAboutsCompaniesPostsController.instance.refreshPage();
        }
      case 2:
        if (Get.isRegistered<ShowAboutsCompaniesJobsController>()) {
          await ShowAboutsCompaniesJobsController.instance.refreshPage();
        }
    }
  }

  @override
  void onInit() {
    startController();
    super.onInit();
  }
}

class UserAboutCompaniesState {
  final _company = CompanyDetailsModel().obs;

  CompanyDetailsModel get company => _company.value;

  void set company(CompanyDetailsModel value) => _company.value = value;

  final _selectedTaps = 0.obs;

  int get selectedTaps => _selectedTaps.toInt();

  void set selectedTaps(int value) {
    _selectedTaps.value = value;
  }
}
