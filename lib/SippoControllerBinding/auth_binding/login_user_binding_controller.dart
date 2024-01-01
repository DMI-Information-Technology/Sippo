import 'package:get/get.dart';
import 'package:sippo/sippo_controller/AuthenticationController/sippo_user_login_controller.dart';
class LoginUserBindingController implements Bindings {
  @override
  void dependencies() {
    Get.put<UserLoginController>(UserLoginController());
  }
  const LoginUserBindingController();
}
