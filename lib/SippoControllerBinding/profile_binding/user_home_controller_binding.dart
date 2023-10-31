import 'package:get/get.dart';
import 'package:jobspot/sippo_controller/home_controllers/user_home_controllers.dart';

class UserHomeBindingController implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserHomeController>(() => UserHomeController());
  }

  const UserHomeBindingController();
}
