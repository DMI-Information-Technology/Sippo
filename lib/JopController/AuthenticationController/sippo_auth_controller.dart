import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jobspot/sippo_data/model/auth_model/company_property_error_model.dart';
import 'package:jobspot/sippo_data/model/auth_model/company_response_model.dart';
import 'package:jobspot/JobGlobalclass/global_storage.dart';
import 'package:jobspot/sippo_data/model/auth_model/user_model.dart';
import 'package:jobspot/utils/app_use.dart';
import '../../sippo_data/auth/auth_repo.dart';
import '../../sippo_data/model/auth_model/auth_response.dart';
import '../../sippo_data/model/auth_model/company_model.dart';
import '../../sippo_data/model/auth_model/company_response_login_user_model.dart';
import '../../sippo_data/model/auth_model/user_response_model.dart';
import '../../sippo_data/model/auth_model/user_propery_error_model.dart';
import '../../sippo_data/model/auth_model/user_register_type_response.dart';
import '../../utils/states.dart';
import '../ConnectivityController/internet_connection_controller.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();
  final _netController = InternetConnectionController.instance;
  final _states = States().obs;

  final _isLogged = false.obs;
  final Rx<String?> _tokenLogged = "".obs;
  final box = GetStorage();

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
    await GlobalStorage.removeSavedToken();
  }

  void set loadingState(bool value) {
    _states.value = states.copyWith(isLoading: value);
  }

  void set successState(bool value) {
    _states.value = states.copyWith(isSuccess: value);
  }

  void resetAllAuthStates() => _states.value = States();

  States get states => _states.value;

  /////////////////////////
  Future<void> userRegister(UserModel user) async {
    if (_netController.isConnectionLostWithDialog()) return;
    loadingState = true;
    AuthResponse<UserResponseModel, UserPropError>? response =
        await AuthRepo.userRegister(user);
    loadingState = false;
    await checkAuthResponseState(response, AppUsingType.user);
  }

  Future<void> userLogin(UserModel user) async {
    if (_netController.isConnectionLostWithDialog()) return;
    loadingState = true;
    AuthResponse<UserResponseModel, UserPropError>? response =
        await AuthRepo.userLogin(user);
    loadingState = false;
    await checkAuthResponseState(response, AppUsingType.user);
  }

  /////////////////////////
  Future<void> companyRegister(CompanyModel company) async {
    if (_netController.isConnectionLostWithDialog()) return;
    loadingState = true;
    AuthResponse<CompanyResponseModel, CompanyPropError>? response =
        await AuthRepo.companyRegister(company);
    loadingState = false;
    await checkAuthResponseState(response, AppUsingType.company);
  }

  Future<void> companyLogin(CompanyModel company) async {
    if (_netController.isConnectionLostWithDialog()) return;
    loadingState = true;
    AuthResponse<UserCompanyResponseModel, CompanyPropError>? response =
        await AuthRepo.companyLogin(company);
    loadingState = false;
    await checkAuthResponseState(response, AppUsingType.company);
  }

  /////////////////////////
  Future<void> checkAuthResponseState<T, E>(
    AuthResponse<T, E>? response,
    AppUsingType appUse,
  ) async {
    switch (response?.type) {
      case RegisterTypeResponse.success:
        await GlobalStorage.savedToken(
          response?.data?.token,
          appUse.index,
        );
        print(
          "from checkAuthResponseState on success: ${response?.data?.token}",
        );
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
}
