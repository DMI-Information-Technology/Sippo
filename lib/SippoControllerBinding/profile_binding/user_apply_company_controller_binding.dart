import 'package:get/get.dart';
import 'package:sippo/sippo_controller/user_core_functions/apply_company_controller.dart';
class UserApplyCompanyBindingController implements Bindings {
  @override
  void dependencies() {
    Get.put<ApplyCompanyController>(ApplyCompanyController());
  }

  const UserApplyCompanyBindingController();
}
