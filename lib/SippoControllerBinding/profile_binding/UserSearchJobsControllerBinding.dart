import 'package:get/get.dart';
import 'package:sippo/sippo_controller/sippo_search_controller/user_search_jobs.dart';

class UserSearchJobsBindingController implements Bindings {
  @override
  void dependencies() {
    Get.put<SearchJobsController>(SearchJobsController());
  }

  const UserSearchJobsBindingController();
}
