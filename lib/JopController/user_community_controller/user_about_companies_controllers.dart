import 'package:get/get.dart';
import 'package:jobspot/JobServices/shared_global_data_service.dart';
import 'package:jobspot/JobServices/ConnectivityController/internet_connection_controller.dart';

import 'package:jobspot/sippo_data/model/auth_model/company_response_details.dart';
import 'package:jobspot/sippo_data/user_repos/user_companies_abouts_repo.dart';

import '../../utils/states.dart';

class UserAboutCompaniesController extends GetxController {
  static UserAboutCompaniesController get instance => Get.find();

  final companyId = SharedGlobalDataService.instance.companyGlobalState.id;

  bool get isNetworkConnected =>
      InternetConnectionService.instance.isConnected;
  final aboutState = UserAboutCompaniesState();
  final _states = States().obs;

  States get states => _states.value;

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
        message: "sorry your connection is lost,"
            " please check your settings before continuing.",
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