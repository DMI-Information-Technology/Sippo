import 'package:get/get.dart';
import 'package:sippo/sippo_controller/company_profile_controller/edit_add_specialization_company_controller.dart';

class CompanyEditAddSpecializationBindingController implements Bindings {
  @override
  void dependencies() {
    Get.put(EditAddSpecializationCompanyController());
  }

  const CompanyEditAddSpecializationBindingController();
}
