import 'package:get/get.dart';

import '../../JobGlobalclass/jobstopimges.dart';
import '../../JobGlobalclass/routes.dart';
import '../../sippo_custom_widget/widgets.dart';

class AppUsingController extends GetxController {
  final _findEmployee = false.obs;

  bool get findEmployee => _findEmployee.isTrue;
  final _findJop = false.obs;

  bool get findJop => _findJop.isTrue;



  Future<void> findOnJop() async {
    if (_findJop.value) return;
    _findJop.value = true;
    _findEmployee.value = !_findJop.value;
  }

  Future<void> findOnEmployee() async {
    if (_findEmployee.value) return;
    _findEmployee.value = true;
    _findJop.value = !_findEmployee.value;
  }

  void onConfirmButtonClicked() {
    if (!findEmployee && !findJop) {
      Get.dialog(
        CustomAlertDialog(
          imageAsset: JobstopPngImg.appuse,
          title: "Chooce how you would to use the app",
          confirmBtnTitle: "ok".tr,
          onConfirm: () {
            Get.back();
          },
        ),
      );
      return;
    }
    if (findJop)
      Get.toNamed(SippoRoutes.signuppage);
    else
      Get.toNamed(SippoRoutes.companysignup);
  }
}
