import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class OnBoardingController extends GetxController {
  final _hideNextButton = true.obs;

  bool get hideNextButton => _hideNextButton.isTrue;

  Future<void> setHideNextButton(bool value) async {
    _hideNextButton.value = value;
  }


}
