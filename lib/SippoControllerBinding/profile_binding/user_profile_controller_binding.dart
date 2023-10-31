
import 'package:get/get.dart';
import 'package:jobspot/sippo_controller/user_profile_controller/profile_user_controller.dart';

class UserProfileBindingController implements Bindings {
  @override
  void dependencies() {
    Get.put<ProfileUserController>(ProfileUserController());
  }

  const UserProfileBindingController();
}
