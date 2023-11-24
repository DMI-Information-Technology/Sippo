import 'package:get/get.dart';
import 'package:jobspot/sippo_controller/home_controllers/user_home_controllers.dart';
import 'package:jobspot/sippo_custom_widget/find_yor_jop_dashboard_cards.dart';

class GuestHomeBindingController implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GuestHomeController>(() => GuestHomeController());
    Get.lazyPut<JobStatisticBoardController>(
          () => JobStatisticBoardController(),
    );
  }

  const GuestHomeBindingController();
}
