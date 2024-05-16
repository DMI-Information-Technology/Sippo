import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  // Existing logic for hiding the next button
  final _hideNextButton = true.obs;

  bool get hideNextButton => _hideNextButton.isTrue;

  Future<void> setHideNextButton(bool value) async {
    _hideNextButton.value = value;
  }

  // New logic for showing/hiding page indicator dots
  final _showDots = true.obs;

  bool get showDots => _showDots.isTrue;

  Future<void> setShowDots(bool value) async {
    _showDots.value = value;
  }
}
