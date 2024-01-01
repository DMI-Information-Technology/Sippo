import 'package:get/get.dart';

import 'package:sippo/sippo_controller/JobDescriptionController/job_description_controller.dart';

class UserJobDescriptionBindingController implements Bindings {
  @override
  void dependencies() {
    Get.put<JobCompanyDetailsController>(JobCompanyDetailsController());
  }

  const UserJobDescriptionBindingController();
}
