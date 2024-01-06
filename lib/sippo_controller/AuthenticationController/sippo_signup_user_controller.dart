import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/global_storage.dart';
import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/jobstopimges.dart';
import 'package:sippo/JobGlobalclass/routes.dart';
import 'package:sippo/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:sippo/sippo_controller/AuthenticationController/sippo_auth_controller.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';
import 'package:sippo/sippo_data/locations/locationsRepo.dart';
import 'package:sippo/sippo_data/model/auth_model/user_model.dart';
import 'package:sippo/sippo_pages/sippo_user_pages/sippo_user_dashboard.dart';
import 'package:sippo/utils/states.dart';

import '../../sippo_data/model/locations_model/location_address_model.dart';

class SignUpUserController extends GetxController {
  static SignUpUserController get instance => Get.find();
  final AuthController authController = AuthController.instance;
  final GlobalKey<FormState> formKey = GlobalKey();
  final _acceptTerms = false.obs;

  bool get acceptTerms => _acceptTerms.isTrue;

  set acceptTerms(bool value) => _acceptTerms.value = value;

  bool get isConnectionLostWithDialog =>
      InternetConnectionService.instance.isConnectionLostWithDialog();

  States get authState => authController.states;
  final _fullname = "".obs;
  final _phoneNumber = "".obs;
  final _password = "".obs;
  final _confirmPassword = "".obs;
  final locationAddressState = SignUpAddressLocationStates();

  String get fullname => _fullname.toString();

  String get confirmPassword => _confirmPassword.toString();

  String get password => _password.toString();

  String get phoneNumber => _phoneNumber.toString();

  UserModel get userForm => UserModel(
        name: fullname,
        phone: phoneNumber,
        password: password,
        passwordConfirmation: confirmPassword,
        fcmToken: GlobalStorageService.fcmToken,
        locationId: locationAddressState.selectedLocationAddress.id,
      );

  void set fullname(String value) {
    _fullname.value = value;
  }

  void set phoneNumber(String value) {
    _phoneNumber.value = value;
  }

  void set password(String value) {
    _password.value = value;
  }

  void set confirmPassword(String value) {
    _confirmPassword.value = value;
  }

  Future<void> onSubmittedSignup() async {
    if (!acceptTerms) {
      _showBadConfirmDialog();
      return;
    }
    if (formKey.currentState!.validate()) {
      await authController.userRegister(userForm);
    }
    if (authState.isSuccess) {
      authController.resetStates();
      _showRegisterSuccessAlert();
    }
    if (authState.isError) {
      _showRegisterErrorAlert(authState.message);
      authController.resetStates();
    }
  }

  void _showBadConfirmDialog() {
    Get.dialog(
      CustomAlertDialog(
        imageAsset: JobstopPngImg.policyaccepted,
        title: "accept_terms_msg".tr,
        description: "accept_terms_desc".tr,
        confirmBtnTitle: "ok".tr,
        onConfirm: () {
          Get.back();
        },
      ),
    );
  }

  void _showRegisterSuccessAlert() {
    Get.dialog(
      CustomAlertDialog(
        imageAsset: JobstopPngImg.successful1,
        isLottie: true,
        title: "Success".tr,
        description: "account_created_successfully".tr,
        confirmBtnColor: SippoColor.primarycolor,
        confirmBtnTitle: "ok".tr,
        onConfirm: () {
          Get.offAllNamed(
            SippoRoutes.userDashboard,
            arguments: {SippoUserDashboard.userProfession: true},
          );
        },
      ),
    ).then((value) {
      Get.offAllNamed(
        SippoRoutes.userDashboard,
        arguments: {SippoUserDashboard.userProfession: true},
      );
    });
  }

  void _showRegisterErrorAlert(String? message) {
    Get.dialog(
      CustomAlertDialog(
        imageAsset: JobstopPngImg.error,
        title: "error".tr,
        description: message ?? '',
        confirmBtnColor: SippoColor.primarycolor,
        confirmBtnTitle: "ok".tr,
        onConfirm: () {
          if (Get.isOverlaysOpen) Get.back();
        },
      ),
    );
  }

  Future<void> fetchLocationsAddress() async {
    locationAddressState.states.value = States(isLoading: true);
    final response = await LocationsRepo.fetchLocations();
    locationAddressState.states.value = States(isLoading: false);
    await response?.checkStatusResponse(
      onSuccess: (data, _) {
        if (data != null) {
          locationAddressState.locationsAddressList = data;
          locationAddressState.states.value = States(isSuccess: true);
        }
      },
      onValidateError: (validateError, _) {},
      onError: (message, _) {
        locationAddressState.states.value = States(isError: true);
      },
    );
  }

  @override
  void onInit() {
    fetchLocationsAddress();
    super.onInit();
  }
}

class SignUpAddressLocationStates {
  final _locationsAddress = <LocationAddress>[].obs;
  final states = States().obs;
  final _selectedLocationAddressName = LocationAddress().obs;

  bool get isLocationAddressLoading => states.value.isLoading;

  bool get isLocationAddressSuccessLoaded =>
      states.value.isSuccess && locationsAddressList.isNotEmpty;

  bool get isLocationAddressSuccessEmpty =>
      states.value.isSuccess && locationsAddressList.isEmpty;

  bool get isLocationAddressError => states.value.isError;

  LocationAddress get selectedLocationAddress =>
      _selectedLocationAddressName.value;

  void set selectedLocationAddress(LocationAddress value) {
    _selectedLocationAddressName.value = value;
  }

  void resetStates() => states.value = States();

  List<LocationAddress> get locationsAddressList => _locationsAddress.toList();

  List<String> get locationsAddressNameList => locationsAddressList
      .where((e) => e.name != null)
      .map((e) => e.name ?? '')
      .toList();

  set locationsAddressList(List<LocationAddress> value) =>
      _locationsAddress.value = value;
}
