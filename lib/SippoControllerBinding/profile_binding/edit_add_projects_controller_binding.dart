import 'package:get/get.dart';
import 'package:jobspot/JopController/user_profile_controller/edit_add_projects_controller.dart';

class EditAddProjectsBindingController implements Bindings {
  @override
  void dependencies() {
    Get.put<EditAddProjectsController>(EditAddProjectsController());
  }

  const EditAddProjectsBindingController();
}
