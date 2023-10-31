import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/global_storage.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/JopController/AuthenticationController/sippo_auth_controller.dart';
import 'package:jobspot/sippo_data/model/auth_model/company_model.dart';
import 'package:jobspot/sippo_data/model/locations_model/location_address_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/cord_location.dart';
import 'package:jobspot/utils/states.dart';

import '../../sippo_data/locations/locationsRepo.dart';

class SignUpCompanyController extends GetxController {
  static SignUpCompanyController get instance => Get.find();
  final GlobalKey<FormState> formKey = GlobalKey();
  final authController = AuthController.instance;
  final _fullname = "".obs;
  final _phoneNumber = "".obs;
  final _password = "".obs;
  final _confirmPassword = "".obs;
  final _companyAddress = LocationAddress().obs;
  final _confirmOnPolicy = false.obs;
  final _cordLocation = CoordLocation().obs;
  final locationState = States().obs;

  CompanyModel get companyForm => CompanyModel(
        name: fullname,
        phone: phoneNumber,
        password: password,
        passwordConfirmation: confirmPassword,
        longitude: double.parse(
          cordLocation.longitude ?? "0",
        ),
        latitude: double.parse(
          cordLocation.latitude ?? "0",
        ),
        specializations: selectedIdSpecializations,
        locationAddress: companyAddress,
        fcmToken: GlobalStorageService.fcmToken,
      );

  CoordLocation get cordLocation => _cordLocation.value;

  void setCordLocation({double? long, double? lat}) {
    _cordLocation.value = CoordLocation(
      longitude: long.toString(),
      latitude: lat.toString(),
    );
  }

  LocationAddress get companyAddress => _companyAddress.value;
  final _locationsAddress = <LocationAddress>[].obs;

  bool get confirmOnPolicy => _confirmOnPolicy.isTrue;

  String get fullname => _fullname.toString();

  String get confirmPassword => _confirmPassword.toString();

  String get password => _password.toString();

  String get phoneNumber => _phoneNumber.toString();

  List<LocationAddress> get locationsAddressList => _locationsAddress.toList();

  List<String> get locationsAddressNameList => locationsAddressList
      .where((e) => e.name != null)
      .map((e) => e.name ?? '')
      .toList();

  set locationsAddressList(List<LocationAddress> value) =>
      _locationsAddress.value = value;
  final _selectedIdSpecializations = <int>[].obs;

  List<int> get selectedIdSpecializations =>
      _selectedIdSpecializations.toList();

  void set selectedIdSpecializations(List<int> value) {
    _selectedIdSpecializations.value = value;
  }

  void toggleConfirmPolicy() {
    _confirmOnPolicy.value = !_confirmOnPolicy.value;
  }

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

  void set confirmOnPolicy(bool value) {
    _confirmOnPolicy.value = value;
  }

  void set companyAddress(LocationAddress value) {
    _companyAddress.value = value;
  }

  Future<void> fetchLocationsAddress() async {
    if (locationState.value.isLoading) return;
    locationState.value = States(isLoading: true);
    final response = await LocationsRepo.fetchLocations();
    locationState.value = States(isLoading: false);
    await response?.checkStatusResponse(
      onSuccess: (data, _) {
        if (data != null) {
          print('hello location address');
          locationsAddressList = data;
          locationState.value = States(isSuccess: true);
        }
      },
      onValidateError: (validateError, _) {
        locationState.value = States(isError: true);
      },
      onError: (message, _) {
        locationState.value = States(isError: true);
      },
    );
  }

  Future<void> onSubmitSignup() async {
    if (formKey.currentState!.validate()) {
      Get.toNamed(SippoRoutes.companySignupSpecializations);
    }
  }
}
