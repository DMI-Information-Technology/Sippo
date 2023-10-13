import 'package:get/get.dart';
import 'package:jobspot/sippo_data/model/auth_model/company_response_details.dart';

import '../../utils/states.dart';
import 'package:jobspot/JobServices/ConnectivityController/internet_connection_controller.dart';

import '../dashboards_controller/company_dashboard_controller.dart';

class CompanyShowJobPostWrapperController extends GetxController {
  static CompanyShowJobPostWrapperController get instance => Get.find();
  final _dashboardController = CompanyDashBoardController.instance;

  CompanyDetailsModel get company => _dashboardController.company;

  int get editPostId => _dashboardController.dashboardState.editId;

  void set editPostId(int value) {
    _dashboardController.dashboardState.editId = value;
  }

  bool get isNetworkConnected =>
      InternetConnectionService.instance.isConnected;
  final _selected = 0.obs;
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

  int get selected => _selected.toInt();

  void switchSelectedTap(int value) {
    _selected.value = value < 2 ? value : selected;
  }

  @override
  void onInit() {
    super.onInit();
  }
}
