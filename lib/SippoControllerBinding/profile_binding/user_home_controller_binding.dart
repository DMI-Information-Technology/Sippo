import 'package:get/get.dart';
import 'package:sippo/sippo_controller/home_controllers/user_home_controllers.dart';
import 'package:sippo/sippo_custom_widget/find_yor_jop_dashboard_cards.dart';

class UserHomeBindingController implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserHomeController>(() => UserHomeController());
    Get.lazyPut<JobStatisticBoardController>(
      () => JobStatisticBoardController(),
    );
  }

  const UserHomeBindingController();
}
