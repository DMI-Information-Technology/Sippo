import 'package:get/get.dart';
import 'package:jobspot/JopController/dashboards_controller/company_dashboard_controller.dart';

import 'package:jobspot/JobServices/shared_global_data_service.dart';


class CompanyDashBoardControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompanyDashBoardController>(() => CompanyDashBoardController());
    Get.put(SharedGlobalDataService());
  }

  const CompanyDashBoardControllerBinding();
}
