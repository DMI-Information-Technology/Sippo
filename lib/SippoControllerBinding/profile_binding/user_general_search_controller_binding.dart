import 'package:get/get.dart';

import 'package:jobspot/sippo_controller/sippo_search_controller/general_search_controller.dart';


class UserGeneralSearchBindingController implements Bindings{
  @override
  void dependencies() {
    Get.put<GeneralSearchController>(GeneralSearchController());
  }

  const UserGeneralSearchBindingController();
}

