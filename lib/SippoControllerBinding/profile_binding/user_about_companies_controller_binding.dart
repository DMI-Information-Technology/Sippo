import 'package:get/get.dart';

import '../../JopController/user_community_controller/user_about_companies_controllers.dart';

class UserAboutCompaniesBindingController implements Bindings {
  @override
  void dependencies() {
    Get.put<UserAboutCompaniesController>(UserAboutCompaniesController());
  }

  const UserAboutCompaniesBindingController();
}
