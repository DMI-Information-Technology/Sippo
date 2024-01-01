import 'package:get/get.dart';
import 'package:sippo/sippo_controller/company_profile_controller/company_edit_add_post_controller.dart';

class CompanyPostBindingController implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompanyEditAddPostController>(
        () => CompanyEditAddPostController());
  }

  const CompanyPostBindingController();
}
