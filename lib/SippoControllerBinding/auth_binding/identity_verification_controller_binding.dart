import 'package:get/get.dart';

import '../../JopController/AuthenticationController/sippo_identity_verification_controller.dart';

class IdentityVerificationBindingController implements Bindings {
  @override
  void dependencies() {
    Get.put<IdentityVerificationController>(IdentityVerificationController());
  }

  const IdentityVerificationBindingController();
}
