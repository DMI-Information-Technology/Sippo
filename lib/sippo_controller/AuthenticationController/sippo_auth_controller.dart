import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jobspot/JobGlobalclass/global_storage.dart';
import 'package:jobspot/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/sippo_data/auth/auth_repo.dart';
import 'package:jobspot/sippo_data/model/auth_model/auth_response.dart';
import 'package:jobspot/sippo_data/model/auth_model/company_model.dart';
import 'package:jobspot/sippo_data/model/auth_model/entity_model.dart';
import 'package:jobspot/sippo_data/model/auth_model/user_model.dart';
import 'package:jobspot/sippo_data/model/auth_model/user_register_type_response.dart';
import 'package:jobspot/utils/app_use.dart';
import 'package:jobspot/utils/getx_text_editing_controller.dart';
import 'package:jobspot/utils/states.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();
  final _netController = InternetConnectionService.instance;
  final _seconds = 60.obs;

  int get seconds => _seconds.toInt();

  void set seconds(int value) => _seconds.value = value;
  final _states = States().obs;
  final resetEmail = GetXTextEditingController();
  final _otpCode = "".obs;

  String get otpCode => _otpCode.trim();

  void set otpCode(String value) => _otpCode.value = value;
  final _isLogged = false.obs;
  final Rx<String?> _tokenLogged = "".obs;
  final box = GetStorage();

  StreamSubscription<States> addListenerStates(
    void Function(States value) handler,
  ) {
    return _states.listen(handler);
  }

  LightSubscription<States> addStateListener(
    void Function(States states) listener,
  ) {
    return _states.subject.listen(listener, cancelOnError: true);
  }

  void closeStateListener(LightSubscription<States> subs) {
    _states.subject.removeSubscription(subs);
  }

  String get tokenLogged => _tokenLogged.toString();

  bool get isLogged => _isLogged.isTrue;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> logout() async {
    if (await userLogout())
      await GlobalStorageService.removeSavedToken(GetStorage());
  }

  void set loadingState(bool value) {
    _states.value = states.copyWith(isLoading: value);
  }

  void set successState(bool value) {
    _states.value = states.copyWith(isSuccess: value);
  }

  void resetStates() => _states.value = States();

  States get states => _states.value;

  void changeStates({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    bool? isWarning,
    String? message,
    String? error,
  }) {
    _states.value = states.copyWith(
      isLoading: isLoading,
      isSuccess: isLoading == true ? false : isSuccess,
      isError: isLoading == true ? false : isError,
      message: message,
      isWarning: isLoading == true ? false : isWarning,
      error: error,
    );
  }

  /////////////////////////
  Future<void> userRegister(UserModel user) async {
    if (_netController.isConnectionLostWithDialog()) return;
    loadingState = true;
    final response = await AuthRepo.userRegister(user);
    loadingState = false;
    await checkAuthResponseState(response, AppUsingType.user);
    // await GlobalStorage.saveLoggedUser(response?.data?.model?.toJson());
  }

  Future<void> userLogin(UserModel user) async {
    if (_netController.isConnectionLostWithDialog()) return;
    loadingState = true;
    final response = await AuthRepo.userLogin(user);
    loadingState = false;
    await checkAuthResponseState(response, AppUsingType.user);

    // await GlobalStorage.saveLoggedUser(response?.data?.model?.toJson());
  }

  Future<bool> userLogout() async {
    if (_netController.isConnectionLostWithDialog()) return false;
    _states.value = States(isLoading: true);
    final response = await AuthRepo.userLogout();
    _states.value = States(isLoading: false);
    print(response);
    if (response?["error"] != null) {
      print(response?["error"]);
      _states.value = states.copyWith(
        isSuccess: false,
        isError: true,
        message: "something_wrong_happened_logout".tr,
      );
      return false;
    }
    print("AuthController.userLogout success: $response");
    _states.value = states.copyWith(
      isSuccess: true,
    );
    return true;
    // await GlobalStorage.saveLoggedUser(response?.data?.model?.toJson());
  }

  /////////////////////////
  Future<void> companyRegister(CompanyModel company) async {
    if (_netController.isConnectionLostWithDialog()) return;
    loadingState = true;
    final response = await AuthRepo.companyRegister(company);
    loadingState = false;
    await checkAuthResponseState(response, AppUsingType.company);
  }

  Future<void> companyLogin(CompanyModel company) async {
    if (_netController.isConnectionLostWithDialog()) return;
    loadingState = true;
    final response = await AuthRepo.companyLogin(company);
    loadingState = false;
    await checkAuthResponseState(response, AppUsingType.company);
  }

  /////////////////////////
  Future<void> checkAuthResponseState<T extends EntityModel, E>(
    AuthResponse<T, E>? response,
    AppUsingType appUse,
  ) async {
    switch (response?.type) {
      case RegisterTypeResponse.success:
        await GlobalStorageService.saveToken(
          GetStorage(),
          response?.data?.token,
          appUse.index,
        );
        print(
          "from checkAuthResponseState on success: ${response?.data?.token}",
        );
        print(
          "from checkAuthResponseState data on success: ${response?.data?.token}",
        );
        // await GlobalStorage.saveLoggedUser(response?.data?.model?.toJson());
        successState = true;
        break;
      case RegisterTypeResponse.auth_error:
        print(
          "from checkAuthResponseState on auth error: ${response?.authMessageError}",
        );
        print(response?.validateError?.errors);
        _states.value = states.copyWith(
          isError: true,
          message: response?.authMessageError,
          error: response?.error,
        );
        break;
      case RegisterTypeResponse.validate_error:
        print(
          "from checkAuthResponseState on error: ${response?.validateError?.message}",
        );
        print(
          "from checkAuthResponseState on error: ${response?.validateError?.errors}",
        );
        _states.value = states.copyWith(
          isError: true,
          message: response?.validateError?.message,
        );
        break;
      default:
        print("null response");
        break;
    }
  }

  Future<void> forgetPassword() async {
    loadingState = true;
    final response = await AuthRepo.forgetPassword(resetEmail.text);
    loadingState = false;
    await response?.checkStatusResponse(
      onSuccess: (data, _) {
        if (data?.status == 'success') {
          _states.value = States(
            isSuccess: true,
            message: data?.message,
          );
        }
      },
      onValidateError: (validateError, _) {
        _states.value = States(
          isError: true,
          message: validateError?.message,
        );
      },
      onError: (message, _) {
        _states.value = States(
          isError: true,
          message: message,
        );
      },
    );
  }

  Future<void> confirmOtpCode() async {
    loadingState = true;
    final response = await AuthRepo.confirmOtpCode({
      'email': resetEmail.text,
      'otp': otpCode,
    });
    loadingState = false;
    await response?.checkStatusResponse(
      onSuccess: (data, _) {
        if (!(data?.containsKey('is_valid') == true)) return;
        final isValid = data?['is_valid'] as bool?;
        if (isValid == true) {
          _states.value = States(
            isSuccess: true,
            message: 'otp_email_valid_message'.tr,
          );
        } else if (isValid == false) {
          _states.value = States(
            isError: true,
            message: 'otp_email_not_valid_message'.tr,
          );
        }
      },
      onValidateError: (validateError, _) {
        _states.value = States(
          isError: true,
          message: validateError?.message,
        );
      },
      onError: (message, _) {
        _states.value = States(
          isError: true,
          message: message,
        );
      },
    );
  }

  Future<void> resetNewPassword(Map<String, String> password) async {
    loadingState = true;
    final response = await AuthRepo.resetNewPassword({
      'email': resetEmail.text,
      'code': otpCode,
      ...password,
    });
    loadingState = false;
    await response?.checkStatusResponse(
      onSuccess: (data, _) {
        _states.value = States(
          isSuccess: true,
          message: data?['message'],
        );
      },
      onValidateError: (validateError, _) {
        _states.value = States(
          isError: true,
          message: validateError?.message,
        );
      },
      onError: (message, _) {
        _states.value = States(
          isError: true,
          message: message,
        );
      },
    );
  }

  @override
  void onClose() {
    resetEmail.dispose();
    super.onClose();
  }
}
