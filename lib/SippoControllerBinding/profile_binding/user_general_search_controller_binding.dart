import 'package:get/get.dart';

import '../../JopController/user_core_functions/general_search_controller.dart';


class UserGeneralSearchBindingController implements Bindings{
  @override
  void dependencies() {
    Get.put<UserGeneralSearchController>(UserGeneralSearchController());
  }

  const UserGeneralSearchBindingController();
}

