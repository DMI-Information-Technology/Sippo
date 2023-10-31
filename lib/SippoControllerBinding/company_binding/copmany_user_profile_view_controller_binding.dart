import 'package:get/get.dart';

import 'package:jobspot/sippo_controller/company_profile_controller/profile_user_view_controller.dart';

class CompanyUserProfileViewBindingController implements Bindings {
  @override
  void dependencies() {
    Get.put<ProfileUserViewController>(ProfileUserViewController());
  }

  const CompanyUserProfileViewBindingController();
}
