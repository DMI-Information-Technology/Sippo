import 'package:get/get.dart';
import 'package:jobspot/JopController/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/JopController/dashboards_controller/company_dashboard_controller.dart';
import 'package:jobspot/sippo_data/model/auth_model/company_response_details.dart';

import '../../../utils/states.dart';

class CompanyNotificationApplicationController extends GetxController {
  static CompanyNotificationApplicationController get instance => Get.find();

  CompanyDetailsResponseModel get company =>
      CompanyDashBoardController.instance.company;
  final _states = States().obs;

  bool get isNetworkConnected =>
      InternetConnectionController.instance.isConnected;

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
}

class CompanyNotificationApplicationState {}
