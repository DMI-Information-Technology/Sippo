
import 'package:get/get.dart';

import '../../JopController/user_profile_controller/upload_cv_controller.dart';

class UserUploadCvBindingController implements Bindings {
  @override
  void dependencies() {
    Get.put<UploadCvController>(UploadCvController());
  }

  const UserUploadCvBindingController();
}

