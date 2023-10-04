import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/sippo_data/model/auth_model/company_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/cord_location.dart';

import '../../JobGlobalclass/routes.dart';

class SignUpCompanyController extends GetxController {
  static SignUpCompanyController get instance => Get.find();
  final GlobalKey<FormState> formKey = GlobalKey();

  final _fullname = "".obs;
  final _phoneNumber = "".obs;
  final _password = "".obs;
  final _confirmPassword = "".obs;
  final _companyAddress = "".obs;
  final _confirmOnPolicy = false.obs;
  final _cordLocation = CordLocation().obs;

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
        city: companyAddress,
      );

  CordLocation get cordLocation => _cordLocation.value;

  void setCordLocation({double? long, double? lat}) {
    _cordLocation.value = CordLocation(
      longitude: long.toString(),
      latitude: lat.toString(),
    );
  }

  String get companyAddress => _companyAddress.toString();

  bool get confirmOnPolicy => _confirmOnPolicy.isTrue;

  String get fullname => _fullname.toString();

  String get confirmPassword => _confirmPassword.toString();

  String get password => _password.toString();

  String get phoneNumber => _phoneNumber.toString();

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

  void set companyAddress(String value) {
    _companyAddress.value = value;
  }

  Future<void> onSubmitSignup() async {
    if (formKey.currentState!.validate()) {
      Get.toNamed(SippoRoutes.companySignupSpecializations);
    }
  }
}
