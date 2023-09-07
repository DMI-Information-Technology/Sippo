import 'package:get/get.dart';
import 'package:jobspot/JopController/ProfileController/edit_add_skills_controller.dart';


class EditAddSkillsBindingController implements Bindings {
  @override
  void dependencies() {
    Get.put<EditAddSkillsController>(EditAddSkillsController());
  }

  const EditAddSkillsBindingController();
}
