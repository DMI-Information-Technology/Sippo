import 'package:get/get.dart';
import 'package:jobspot/JopController/UserDashboardController/user_dashboard_controller.dart';

class UserDashBoardControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserDashBoardController>(() => UserDashBoardController());
  }

  const UserDashBoardControllerBinding();
}
