import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/global_storage.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/JopController/AuthenticationController/sippo_auth_controller.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/sippo_data/locations/locationsRepo.dart';
import 'package:jobspot/sippo_data/model/auth_model/user_model.dart';
import 'package:jobspot/utils/states.dart';

import '../../sippo_data/model/locations_model/location_address_model.dart';

class SignUpUserController extends GetxController {
  static SignUpUserController get instance => Get.find();
  final AuthController authController = AuthController.instance;
  final GlobalKey<FormState> formKey = GlobalKey();

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

  void _showRegisterSuccessAlert() {
    Get.dialog(
      CustomAlertDialog(
        imageAsset: JobstopPngImg.successful1,
        title: "success".tr,
        description: "account_created_successfully".tr,
        confirmBtnColor: Jobstopcolor.primarycolor,
        confirmBtnTitle: "ok".tr,
        onConfirm: () {
          Get.offAllNamed(SippoRoutes.userDashboard);
        },
      ),
    ).then((value) => Get.offAllNamed(SippoRoutes.userDashboard));
  }

  void _showRegisterErrorAlert(String? message) {
    Get.dialog(
      CustomAlertDialog(
        imageAsset: JobstopPngImg.error,
        title: "error".tr,
        description: message ?? '',
        confirmBtnColor: Jobstopcolor.primarycolor,
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
