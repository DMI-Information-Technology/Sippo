import 'package:get/get.dart';
import 'package:jobspot/JopController/dashboards_controller/company_dashboard_controller.dart';


class CompanyDashBoardControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompanyDashBoardController>(() => CompanyDashBoardController());
  }

  const CompanyDashBoardControllerBinding();
}
