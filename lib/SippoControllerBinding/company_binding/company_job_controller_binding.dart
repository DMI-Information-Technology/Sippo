import 'package:get/get.dart';
import 'package:jobspot/JopController/company_profile_controller/company_edit_add_job_controller.dart';

class CompanyJobBindingController implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompanyEditAddJobController>(
        () => CompanyEditAddJobController());
  }

  const CompanyJobBindingController();
}