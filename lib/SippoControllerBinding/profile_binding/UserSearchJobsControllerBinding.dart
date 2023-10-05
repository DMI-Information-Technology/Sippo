import 'package:get/get.dart';
import 'package:jobspot/JopController/sippo_search_controller/user_search_jobs.dart';

class UserSearchJobsBindingController implements Bindings {
  @override
  void dependencies() {
    Get.put<UserSearchJobsController>(UserSearchJobsController());
  }

  const UserSearchJobsBindingController();
}
