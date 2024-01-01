import 'package:get/get.dart';

import 'package:sippo/JobGlobalclass/jobstopimges.dart';
import 'package:sippo/JobGlobalclass/routes.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';

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
          title: "select_find_dialog".tr,
          confirmBtnTitle: "ok".tr,
          onConfirm: () {
            Get.back();
          },
        ),
      );
      return;
    }
    if (findJop)
      Get.toNamed(SippoRoutes.userSignupPage);
    else
      Get.toNamed(SippoRoutes.companysignup);
  }
}
