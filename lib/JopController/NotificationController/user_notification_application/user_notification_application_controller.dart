import 'package:get/get.dart';
import 'package:jobspot/JopController/dashboards_controller/user_dashboard_controller.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/profile_edit_model.dart';
import 'package:jobspot/utils/states.dart';

class UserNotificationApplicationController extends GetxController {
  static UserNotificationApplicationController get instance => Get.find();
  final _states = States().obs;
  ProfileInfoModel get user =>UserDashBoardController.instance.user;
  States get states => _states.value;

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

  final _selectedBottomOption = (-1).obs;

  int get selectedBottomOption => _selectedBottomOption.toInt();

  bool isMatchOptionOfIndex(int index) => selectedBottomOption == index;

  void set selectedBottomOption(int value) =>
      _selectedBottomOption.value = value;
  final _selectedNotification = (-1).obs;

  int get selectedNotification => _selectedNotification.toInt();

  void set selectedNotification(int value) =>
      _selectedNotification.value = value;
}
