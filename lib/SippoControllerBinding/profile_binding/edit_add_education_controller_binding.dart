import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import '../../JopController/ProfileController/edit_add_education_controller.dart';


class EditAddEducationBindingController implements Bindings {
  @override
  void dependencies() {
    Get.put<EditAddEducationController>(EditAddEducationController());
  }

  const EditAddEducationBindingController();
}
