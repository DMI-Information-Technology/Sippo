import 'package:get/get.dart';

import 'package:sippo/sippo_controller/company_profile_controller/profile_company_controller.dart';

class ProfileCompanyBindingController implements Bindings {
  @override
  void dependencies() {
    Get.put<ProfileCompanyController>(ProfileCompanyController());
  }

  const ProfileCompanyBindingController();
}
