import 'package:get/get.dart';
import 'package:jobspot/JobServices/shared_global_data_service.dart';
import 'package:jobspot/sippo_controller/dashboards_controller/user_dashboard_controller.dart';

class GuestDashBoardControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GuestDashBoardController>(() => GuestDashBoardController());
    Get.put(SharedGlobalDataService());
  }

  const GuestDashBoardControllerBinding();
}
