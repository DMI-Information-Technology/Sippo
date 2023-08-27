import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:jobspot/JopController/UserDashboardController/user_dashboard_controller.dart';

class UserDashBoardControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<UserDashBoardController>(UserDashBoardController());
  }

  const UserDashBoardControllerBinding();
}
