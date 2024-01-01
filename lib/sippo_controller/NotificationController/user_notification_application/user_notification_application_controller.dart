import 'package:get/get.dart';
import 'package:sippo/custom_app_controller/switch_status_controller.dart';
import 'package:sippo/sippo_controller/dashboards_controller/user_dashboard_controller.dart';
import 'package:sippo/sippo_data/model/profile_model/profile_resource_model/profile_edit_model.dart';
import 'package:sippo/sippo_data/notification_repo/notifications_repo.dart';
import 'package:sippo/utils/states.dart';

import 'user_notification_controller.dart';

class UserNotificationApplicationController extends GetxController {
  static UserNotificationApplicationController get instance => Get.find();
  final _states = States().obs;

  ProfileInfoModel get user => UserDashBoardController.instance.user;

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
    if (isLoading == true) {
      _states.value = States(isLoading: true);
      return;
    }
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
        if (Get.isRegistered<UserNotificationController>())
          UserNotificationController.instance.refreshPage();
      },
      onValidateError: (validateError, _) {},
      onError: (message, _) {},
    );
  }

  final showNotificationReadAllButton = SwitchStatusController();

  bool get hasNotificationsToRead {
    return showNotificationReadAllButton.status;
  }

  final _selectedNotification = (-1).obs;

  int get selectedNotification => _selectedNotification.toInt();

  void set selectedNotification(int value) =>
      _selectedNotification.value = value;
}
