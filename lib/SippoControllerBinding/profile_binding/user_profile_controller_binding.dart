
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:jobspot/JopController/user_profile_controller/profile_user_controller.dart';

class UserProfileBindingController implements Bindings {
  @override
  void dependencies() {
    Get.put<ProfileUserController>(ProfileUserController());
  }

  const UserProfileBindingController();
}
