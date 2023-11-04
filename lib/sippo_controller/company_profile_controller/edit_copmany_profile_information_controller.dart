import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/custom_app_controller/switch_status_controller.dart';
import 'package:jobspot/sippo_controller/company_profile_controller/profile_company_controller.dart';
import 'package:jobspot/sippo_data/company_repos/company_profile_info_repo.dart';
import 'package:jobspot/sippo_data/model/auth_model/company_response_details.dart';
import 'package:jobspot/sippo_data/model/custom_file_model/custom_file_model.dart';
import 'package:jobspot/utils/getx_text_editing_controller.dart';
import 'package:jobspot/utils/states.dart';

class EditCompanyProfileInfoController extends GetxController {
  final profileController = ProfileCompanyController.instance;
  final overlayLoadingController = SwitchStatusController();

  CompanyDetailsModel get companyDetails => profileController.company;
  final profileEditState = ProfileCompanyEditState();
  final _states = States().obs;

  final GlobalKey<FormState> formKey = GlobalKey();

  bool get isEmailVerified => companyDetails.isEmailVerified == true;

  States get states => _states.value;

  void set states(States value) => _states.value = value;

  void successState(bool value, [String? message]) {
    _states.value = states.copyWith(isSuccess: value, message: message);
  }

  void warningState(bool value, [String? message]) {
    _states.value = states.copyWith(isWarning: value, message: message);
  }

  Future<void> updateProfileImage() async {
    final response = await EditCompanyProfileInfoRepo.updateProfileImage(
      profileEditState.pickedImageProfile,
    );
    await response?.checkStatusResponse(
      onSuccess: (data, _) {
        if (data != null) {
          final company = profileController.dashboard.company;
          profileController.dashboard.company = company.copyWith(
            profileImage: data,
          );
          profileEditState.pickedImageProfile = CustomFileModel();
        }
      },
      onValidateError: (validateError, _) {},
      onError: (message, _) {},
    );
  }

  Future<void> updateProfileInfo() async {
    final newProfileInfo = profileEditState.form
      ..id = profileController.company.id;
    print(newProfileInfo);
    print(profileController.company);
    print("is equals ${newProfileInfo == profileController.company}");
    if (newProfileInfo == profileController.company) {
      return warningState(true, "Nothing is Changed in Profile Information.");
    }
    final response = await EditCompanyProfileInfoRepo.updateCompanyProfile(
      newProfileInfo,
    );
    await response.checkStatusResponse(
      onSuccess: (data, _) async {
        if (data != null) {
          await profileController.dashboard.refreshUserProfileInfo();
          profileEditState.setAll(companyDetails);
        }
        successState(true, 'company Profile is updated successfully.');
      },
      onValidateError: (validateError, _) {
        states =
            states.copyWith(isError: true, message: validateError?.message);
      },
      onError: (message, _) {
        states = states.copyWith(isError: true, message: message);
      },
    );
  }

  Future<void> onSaveSubmitted() async {
    if (profileController.netController.isNotConnected) {
      return warningState(
        true,
        "sorry your connection is lost, please check your settings before continuing.",
      );
    }

    _states.value = States(isLoading: true);
    await updateProfileInfo();
    _states.value = states.copyWith(isLoading: false);
  }

  Future<void> onImageUpdatedSubmitted() async {
    if (profileController.netController.isNotConnected) {
      return warningState(
        true,
        "sorry your connection is lost, please check your settings before continuing.",
      );
    }
    _states.value = States(isLoading: true);
    await updateProfileImage();
    _states.value = states.copyWith(isLoading: false);
  }

  StreamSubscription<States>? stateSubs;

  @override
  void onInit() {
    profileEditState.setAll(profileController.company);
    stateSubs = _states.listen((value) {
      if (value.isLoading)
        overlayLoadingController.start();
      else
        overlayLoadingController.pause();
    });
    super.onInit();
  }

  @override
  void onClose() {
    stateSubs?.cancel();
    overlayLoadingController.dispose();
    profileEditState.disposeTextControllers();
    super.onClose();
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
  final establishedDate = GetXTextEditingController();
  final _profileController = ProfileCompanyController.instance;
  final _pickedImageProfile = CustomFileModel().obs;
  final bio = GetXTextEditingController();

  CustomFileModel get pickedImageProfile => _pickedImageProfile.value;

  set pickedImageProfile(CustomFileModel value) {
    _pickedImageProfile.value = value;
  }

  void clearFields() {
    name.text = "";
    email.text = "";
    phone.text = "";
    secondaryPhone.text = "";
    website.text = "";
    city.text = "";
    employeesCount.text = "";
    bio.text = "";
    pickedImageProfile = CustomFileModel();
    establishedDate.text = '';
    // imageProfileResource = ImageResourceModel();
  }

  void setAll(CompanyDetailsModel? data) {
    name.text = data?.name ?? "";
    email.text = data?.email ?? "";
    phone.text = data?.phone ?? "";
    secondaryPhone.text = data?.secondaryPhone ?? "";
    website.text = data?.website ?? "";
    city.text = data?.city ?? "";
    employeesCount.text = data?.employeesCount != null
        ? data?.employeesCount?.toString() ?? ""
        : "";
    bio.text = data?.bio ?? "";
    establishedDate.text = data?.establishmentDate ?? "";
  }

  CompanyDetailsModel get form {
    print(bio.text);
    return _profileController.company.copyWith(
      name: name.text.isBlank == true ? null : name.text,
      phone: phone.text.isBlank == true ? null : phone.text,
      email: email.text.isBlank == true ? null : email.text,
      secondaryPhone:
          secondaryPhone.text.isBlank == true ? null : secondaryPhone.text,
      website: website.text.isBlank == true ? null : website.text,
      city: city.text.isBlank == true ? null : city.text,
      employeesCount: employeesCount.text.isBlank == true
          ? null
          : employeesCount.text.isNumericOnly
              ? int.parse(employeesCount.text)
              : null,
      bio: bio.text.isEmpty ? null : bio.text,
      establishmentDate:
          establishedDate.text.isBlank == true ? null : establishedDate.text,
    );
  }

  void disposeTextControllers() {
    name.dispose();
    phone.dispose();
    email.dispose();
    secondaryPhone.dispose();
    website.dispose();
    city.dispose();
    employeesCount.dispose();
    bio.dispose();
  }
}
