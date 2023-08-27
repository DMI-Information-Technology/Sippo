import 'package:get/get.dart';

import '../../JopController/ProfileController/edit_add_work_experience_controller.dart';

class EditAddWorkExperienceBindingController implements Bindings {
  @override
  void dependencies() {
    Get.put<EditAddWorkExperienceController>(EditAddWorkExperienceController());
  }

  const EditAddWorkExperienceBindingController();
}
