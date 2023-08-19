import 'dart:async';

import 'package:get/get.dart';
import 'package:jobspot/utils/helper.dart' as helper;

class IdentityVerificationController extends GetxController {
  final _initTimer = 5.obs;
  final _resendTimer = 30.obs;

  int get resendTimer => _resendTimer.toInt();

  set resendTimer(int value) => _resendTimer.value = value;

  final _otpCode = RxString("");

  String get otpCode => _otpCode.toString();

  bool get isValidOTP =>
      _otpCode.toString().isNotEmpty && _otpCode.toString().length == 6;

  void set otpCode(String value) {
    _otpCode.value = value;
  }

  bool isAllTimerFinish() =>
      _initTimer.toInt() == 0 && _resendTimer.toInt() == 0;

  bool isResendTimerNotFinish() =>
      _initTimer.toInt() == 0 && _resendTimer.toInt() > 0;

  int get initTimer => _initTimer.toInt();

  void set initTimer(int value) => _initTimer.value = value;
  Timer? timer;

  Future<void> resendOTPCodeTimer() async {
    _resendTimer.value = 30;
    timer = await helper.startTimer(
      _resendTimer.value,
      (value) => _resendTimer.value = value,
    );
  }

  @override
  void onReady() {
    (() async {
      timer = await helper.startTimer(
        _initTimer.value,
        (value) => _initTimer.value = value,
      );
    })();

    super.onReady();
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
