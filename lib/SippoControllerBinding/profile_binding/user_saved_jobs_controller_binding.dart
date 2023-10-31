import 'package:get/get.dart';
import 'package:jobspot/sippo_controller/user_profile_controller/user_saved_jobs_controller.dart';

class UserSavedJobBindingController implements Bindings {
  @override
  void dependencies() {
    Get.put<UserSavedJobsController>(UserSavedJobsController());
  }

  const UserSavedJobBindingController();
}
