import 'package:get/get.dart';
import 'package:sippo/sippo_controller/user_profile_controller/edit_add_skills_controller.dart';


class EditAddSkillsBindingController implements Bindings {
  @override
  void dependencies() {
    Get.put<EditAddSkillsController>(EditAddSkillsController());
  }

  const EditAddSkillsBindingController();
}
