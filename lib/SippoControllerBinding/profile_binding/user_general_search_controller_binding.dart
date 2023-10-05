import 'package:get/get.dart';

import 'package:jobspot/JopController/sippo_search_controller/general_search_controller.dart';


class UserGeneralSearchBindingController implements Bindings{
  @override
  void dependencies() {
    Get.put<UserGeneralSearchController>(UserGeneralSearchController());
  }

  const UserGeneralSearchBindingController();
}

