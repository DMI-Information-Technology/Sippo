import 'dart:async';

import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/custom_app_controller/switch_status_controller.dart';
import 'package:jobspot/sippo_controller/AuthenticationController/sippo_auth_controller.dart';
import 'package:jobspot/sippo_controller/AuthenticationController/sippo_signup_company_controller.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/utils/helper.dart' as helper;
import 'package:jobspot/utils/states.dart';

import 'firebase_auth_service_controller.dart';

class IdentityVerificationController extends GetxController {
  static IdentityVerificationController get instance => Get.find();

  LightSubscription<States>? _authSubs;
  LightSubscription<States>? _firebaseSubs;
  final _loController = SwitchStatusController();
  final _firebaseOTP = Get.put(FirebaseAuthServiceController());
  final _authController = AuthController.instance;
  final _netController = InternetConnectionService.instance;
  final _signUpCompanyController = SignUpCompanyController.instance;

  bool get isNetworkConnect => _netController.isConnected;

  // final _signUpCompanyController = Get.put(SignUpCompanyController());

  final _initCounter = 5.obs;
  final _resendCounter = 30.obs;

  SwitchStatusController get loadingController => _loController;

  String get phoneNumber =>
      helper.otpPhoneNumberFormat(_signUpCompanyController.phoneNumber);

  States get authState => _authController.states;

  States get firebaseState => _firebaseOTP.states;

  int get resendTimer => _resendCounter.toInt();

  set resendTimer(int value) => _resendCounter.value = value;

  final _otpCode = RxString("");

  String get otpCode => _otpCode.toString();

  bool get isValidOTP =>
      _otpCode.toString().isNotEmpty && _otpCode.toString().length == 6;

  void set otpCode(String value) {
    _otpCode.value = value;
  }

  bool isAllTimerFinish() =>
      _initCounter.toInt() == 0 && _resendCounter.toInt() == 0;

  bool isResendTimerNotFinish() =>
      _initCounter.toInt() == 0 && _resendCounter.toInt() > 0;

  int get initTimer => _initCounter.toInt();

  void set initTimer(int value) => _initCounter.value = value;
  Timer? timer;

  Future<void> resendOTPClicked() async {
    if (isAllTimerFinish()) {
      await authenticatePhoneNumber();
    }
  }

  Future<void> resendOTPCodeTimer() async {
    _resendCounter.value = 30;
    timer = await helper.startTimer(
      _resendCounter.value,
      (value) => _resendCounter.value = value,
    );
  }

  Future<void> onSubmitSend() async {
    if (!isValidOTP) {
      // messages.invalidOTPSnackbar();
      return;
    }
    await _firebaseOTP.verifyOTP(otpCode.toString());
    if (firebaseState.isError) {
      // messages.failedVerifyOTPSnackbar(firebaseState.message);
      return;
    }
    if (firebaseState.isSuccess) {
      // messages.successVerifyOTPSnackbar();
      await _authController.companyRegister(
        _signUpCompanyController.companyForm,
        // CompanyModel(
        //   password: "@aA123456",
        //   passwordConfirmation: "@aA123456",
        //   name: "hatem",
        //   phone: "0922698540",
        //   city: "tripoli",
        //   latitude: 35,
        //   longitude: -35,
        //   specializations: [1, 2, 3],
        // ),
      );
      if (authState.isSuccess) {
        _authController.resetStates();
        _showSuccessSignupAlert();
      }
    }
  }

  Future<void> authenticatePhoneNumber() async {
    // final phoneNumber = "+218922698540";
    final phoneNumber = this.phoneNumber;
    final bool? isAuthenticated =
        await _firebaseOTP.phoneAuthentication(phoneNumber, secondDuration: 24);
    if (isAuthenticated == true)
      await resendOTPCodeTimer();
    else
      _resendCounter.value = 0;
  }

  void _loadingControllerListener(States states) {
    _loController.status = states.isLoading;
  }

  void _removeAllListener() {
    if (_firebaseSubs != null) _firebaseOTP.closeStateListener(_firebaseSubs!);
    if (_authSubs != null) _authController.closeStateListener(_authSubs!);
  }

  @override
  void onInit() {
    _firebaseSubs = _firebaseOTP.addStateListener(_loadingControllerListener);
    _authSubs = _authController.addStateListener(_loadingControllerListener);
    super.onInit();
  }

  @override
  void onReady() {
    (() async {
      timer = await helper.startTimer(
        _initCounter.value,
        (value) => _initCounter.value = value,
        onTimerDone: () async {
          await authenticatePhoneNumber();
        },
      );
    })();
    super.onReady();
  }

  @override
  void onClose() {
    timer?.cancel();
    _removeAllListener();
    _authController.resetStates();
    _loController.dispose();
    super.onClose();
  }

  void _showSuccessSignupAlert() {
    Get.dialog(
      CustomAlertDialog(
        imageAsset: JobstopPngImg.successful1,
        title: "Success",
        description:
            "the account has been created successfully want continue to dashboard",
        confirmBtnColor: SippoColor.primarycolor,
        confirmBtnTitle: "ok".tr,
        onConfirm: () => Get.offAllNamed(SippoRoutes.sippoCompanyDashboard),
      ),
    ).then((value) => Get.offAllNamed(SippoRoutes.sippoCompanyDashboard));
  }
}
