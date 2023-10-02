import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  final _hideNextButton = true.obs;

  bool get hideNextButton => _hideNextButton.isTrue;

  Future<void> setHideNextButton(bool value) async {
    _hideNextButton.value = value;
  }


}
