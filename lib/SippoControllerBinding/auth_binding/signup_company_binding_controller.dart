import 'package:get/get.dart';
import 'package:jobspot/sippo_controller/AuthenticationController/sippo_signup_company_controller.dart';


class SignupCompanyBindingController implements Bindings {
  @override
  void dependencies() {
    Get.put<SignUpCompanyController>(SignUpCompanyController());
  }

  const SignupCompanyBindingController();
}
