import 'package:get/get.dart';

import 'package:sippo/sippo_controller/AuthenticationController/sippo_signup_user_controller.dart';
class SignupUserBindingController implements Bindings {
  @override
  void dependencies() {
    Get.put<SignUpUserController>(SignUpUserController());
  }
  const SignupUserBindingController();
}
