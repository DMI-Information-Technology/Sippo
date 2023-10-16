import 'package:get/get.dart';
import 'package:jobspot/JopController/user_core_functions/apply_jobs_controllers.dart';

class UserApplyJobBindingController implements Bindings {
  @override
  void dependencies() {
    Get.put<ApplyJobsController>(ApplyJobsController());
  }

  const UserApplyJobBindingController();
}
