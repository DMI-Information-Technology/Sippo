import 'package:get/get.dart';
import 'package:jobspot/sippo_controller/user_profile_controller/edit_add_education_controller.dart';


class EditAddEducationBindingController implements Bindings {
  @override
  void dependencies() {
    Get.put<EditAddEducationController>(EditAddEducationController());
  }

  const EditAddEducationBindingController();
}
