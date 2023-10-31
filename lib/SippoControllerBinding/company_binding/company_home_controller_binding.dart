import 'package:get/get.dart';
import 'package:jobspot/sippo_controller/home_controllers/company_home_controller.dart';

class CompanyHomeBindingController implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompanyHomeController>(() => CompanyHomeController());
  }

  const CompanyHomeBindingController();
}
