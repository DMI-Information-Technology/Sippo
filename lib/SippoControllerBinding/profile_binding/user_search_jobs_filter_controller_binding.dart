import 'package:get/get.dart';
import 'package:jobspot/JopController/sippo_search_controller/user_filter_search.dart';

class UserSearchJobsFilterBindingController implements Bindings {
  @override
  void dependencies() {
    Get.put<UserFilterSearchController>(UserFilterSearchController());
  }

  const UserSearchJobsFilterBindingController();
}
