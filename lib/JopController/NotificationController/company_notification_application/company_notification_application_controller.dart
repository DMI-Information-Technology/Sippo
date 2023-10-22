import 'package:get/get.dart';
import 'package:jobspot/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/JopController/NotificationController/company_notification_application/company_notification_controller.dart';
import 'package:jobspot/JopController/dashboards_controller/company_dashboard_controller.dart';
import 'package:jobspot/custom_app_controller/switch_status_controller.dart';
import 'package:jobspot/sippo_data/model/auth_model/company_response_details.dart';
import 'package:jobspot/sippo_data/notification_repo/notifications_repo.dart';
import 'package:jobspot/utils/states.dart';

class CompanyNotificationApplicationController extends GetxController {
  static CompanyNotificationApplicationController get instance => Get.find();
  final loadingOverlayController = SwitchStatusController();

  CompanyDetailsModel get company =>
      CompanyDashBoardController.instance.company;
  final _states = States().obs;

  bool get isNetworkConnected => InternetConnectionService.instance.isConnected;

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

  Future<void> markAllNotificationsAsRead() async {
    final response = await NotificationRepo.markedAllNotificationAsRead();
    await response?.checkStatusResponse(
      onSuccess: (data, _) {
        if (data == null) return;
        if (Get.isRegistered<CompanyNotificationController>())
          CompanyNotificationController.instance.refreshPage();
      },
      onValidateError: (validateError, _) {},
      onError: (message, _) {},
    );
  }

  @override
  void onClose() {
    loadingOverlayController.dispose();
    super.onClose();
  }
}

class CompanyNotificationApplicationState {}
