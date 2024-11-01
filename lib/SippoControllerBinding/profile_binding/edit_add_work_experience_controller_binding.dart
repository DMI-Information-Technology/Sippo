import 'package:get/get.dart';

import 'package:sippo/sippo_controller/user_profile_controller/edit_add_work_experience_controller.dart';

class EditAddWorkExperienceBindingController implements Bindings {
  @override
  void dependencies() {
    Get.put<EditAddWorkExperienceController>(EditAddWorkExperienceController());
  }

  const EditAddWorkExperienceBindingController();
}
