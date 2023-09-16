import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JopController/company_profile_controller/profile_company_controller.dart';
import 'package:jobspot/sippo_data/model/auth_model/company_response_details.dart';

import '../../sippo_data/company_repos/company_profile_info_repo.dart';
import '../../utils/getx_text_editing_controller.dart';
import '../../utils/states.dart';

class EditCompanyProfileInfoController extends GetxController {
  final _profileImagePath = "".obs;
  final _profileController = ProfileCompanyController.instance;

  final profileEditState = ProfileCompanyEditState();
  final _states = States().obs;

  final GlobalKey<FormState> formKey = GlobalKey();

  States get states => _states.value;

  void successState(bool value, [String? message]) {
    _states.value = states.copyWith(isSuccess: value, message: message);
  }

  void warningState(bool value, [String? message]) {
    _states.value = states.copyWith(isWarning: value, message: message);
  }

  Future<void> updateProfileInfo() async {
    final newProfileInfo = profileEditState.form
      ..id = _profileController.company.id;
    if (newProfileInfo == _profileController.company) {
      return warningState(true, "Nothing is Changed in Profile Information.");
    }
    final response = await EditCompanyProfileInfoRepo.updateCompanyProfile(
      newProfileInfo,
    );
    await response.checkStatusResponse(
      onSuccess: (data, _) {
        if (data != null) {
          _profileController.dashboard.company = data;
          profileEditState.setAll(_profileController.dashboard.company);
        }
        successState(true, 'company Profile is updated successfully.');
      },
      onValidateError: (validateError, _) {},
      onError: (message, _) {},
    );
  }

  String get profileImagePath => _profileImagePath.toString().trim();

  Future<void> onSaveSubmitted() async {
    if (!_profileController.netController.isConnected) {
      return warningState(
        true,
        "sorry your connection is lost, please check your settings before continuing.",
      );
    }
    _states.value = States(isLoading: true);
    await updateProfileInfo();
    _states.value = states.copyWith(isLoading: false);
  }

  @override
  void onInit() {
    profileEditState.setAll(_profileController.company);
    super.onInit();
  }

  @override
  void onClose() {
    profileEditState.disposeTextControllers();
    super.onClose();
  }

  void set profileImagePath(String? value) {
    _profileImagePath.value = value ?? "";
  }
}

class ProfileCompanyEditState {
  final name = GetXTextEditingController();
  final email = GetXTextEditingController();
  final phone = GetXTextEditingController();
  final secondaryPhone = GetXTextEditingController();
  final website = GetXTextEditingController();
  final city = GetXTextEditingController();
  final employeesCount = GetXTextEditingController();
  final _profileController = ProfileCompanyController.instance;

  void clearFields() {
    name.text = "";
    email.text = "";
    phone.text = "";
    secondaryPhone.text = "";
    website.text = "";
    city.text = "";
    employeesCount.text = "";
  }

  void setAll(CompanyResponseDetailsModel? data) {
    name.text = data?.name ?? "";
    email.text = data?.email ?? "";
    phone.text = data?.phone ?? "";
    secondaryPhone.text = data?.secondaryPhone ?? "";
    website.text = data?.website ?? "";
    city.text = data?.city ?? "";
    employeesCount.text = data?.employeesCount.toString() ?? "";
  }

  CompanyResponseDetailsModel get form => _profileController.company.copyWith(
        name: name.text,
        phone: phone.text,
        email: email.text,
        secondaryPhone: secondaryPhone.text,
        website: website.text,
        city: city.text,
        employeesCount: int.parse(employeesCount.text),
      );

  void disposeTextControllers() {
    name.dispose();
    phone.dispose();
    email.dispose();
    secondaryPhone.dispose();
    website.dispose();
    city.dispose();
    employeesCount.dispose();
  }
}
