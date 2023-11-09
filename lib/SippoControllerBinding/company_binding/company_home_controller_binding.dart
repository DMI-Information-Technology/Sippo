import 'package:get/get.dart';
import 'package:jobspot/sippo_controller/home_controllers/company_home_controller.dart';
import 'package:jobspot/sippo_custom_widget/find_yor_jop_dashboard_cards.dart';

class CompanyHomeBindingController implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompanyHomeController>(() => CompanyHomeController());
    Get.lazyPut<JobStatisticBoardController>(
          () => JobStatisticBoardController(),
    );
  }

  const CompanyHomeBindingController();
}
