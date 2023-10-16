import 'package:get/get.dart';

import 'package:jobspot/JopController/AuthenticationController/sippo_signup_user_controller.dart';
class SignupUserBindingController implements Bindings {
  @override
  void dependencies() {
    Get.put<SignUpUserController>(SignUpUserController());
  }
  const SignupUserBindingController();
}
