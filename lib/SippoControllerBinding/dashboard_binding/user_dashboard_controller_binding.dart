import 'package:get/get.dart';
import 'package:jobspot/JopController/dashboards_controller/user_dashboard_controller.dart';

import '../../JobServices/shared_global_data_service.dart';

class UserDashboardControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserDashBoardController>(() => UserDashBoardController());
    Get.put(SharedGlobalDataService());

  }

  const UserDashboardControllerBinding();
}
