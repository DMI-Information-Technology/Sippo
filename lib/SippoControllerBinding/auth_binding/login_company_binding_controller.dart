import 'package:get/get.dart';
import 'package:jobspot/JopController/AuthenticationController/sippo_company_login_controller.dart';

class LoginCompanyBindingController implements Bindings {
  @override
  void dependencies() {
    Get.put<CompanyLoginController>(CompanyLoginController());
  }
  const LoginCompanyBindingController();
}