import 'package:get/get.dart';
import 'package:sippo/sippo_controller/dashboards_controller/company_dashboard_controller.dart';

import 'package:sippo/JobServices/shared_global_data_service.dart';


class CompanyDashBoardControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompanyDashBoardController>(() => CompanyDashBoardController());
    Get.put(SharedGlobalDataService());
  }

  const CompanyDashBoardControllerBinding();
}
