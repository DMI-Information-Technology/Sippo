import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JopController/user_profile_controller/profile_user_controller.dart';
import 'package:jobspot/sippo_custom_widget/gender_picker_widget.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/profile_edit_model.dart';
import 'package:jobspot/sippo_data/update_image_profile_repo/update_image_profile_repo.dart';
import 'package:jobspot/sippo_data/user_repos/edit_profile_repo.dart';
import 'package:jobspot/utils/states.dart';

import 'package:jobspot/custom_app_controller/switch_status_controller.dart';
import 'package:jobspot/sippo_data/model/custom_file_model/custom_file_model.dart';
import 'package:jobspot/utils/getx_text_editing_controller.dart';

class EditProfileInfoController extends GetxController {
  final _profileImagePath = "".obs;
  final _profileController = ProfileUserController.instance;
  final loadingOverlayController = SwitchStatusController();

  ProfileInfoModel get userDetails => _profileController.user;
  final profileEditState = ProfileEditState();
  final _states = States().obs;

  States get states => _states.value;
  final GlobalKey<FormState> formKey = GlobalKey();

  void successState(bool value, [String? message]) {
    _states.value = states.copyWith(isSuccess: value, message: message);
  }

  void warningState(bool value, [String? message]) {
    _states.value = states.copyWith(isWarning: value, message: message);
  }

  Future<void> updateProfileInfo() async {
    final response = await ProfileInfoRepo.updateProfile(profileEditState.form);
    await response.checkStatusResponse(
      onSuccess: (data, _) {
        if (data != null) _profileController.dashboard.user = data;
        successState(true, 'Profile is updated successfully.');
      },
      onValidateError: (validateError, _) {},
      onError: (message, _) {},
    );
  }

  Future<void> updateProfileImage() async {
    final response = await ImageProfileRepo.updateProfileImage(
      profileEditState.pickedImageProfile,
    );
    response?.checkStatusResponse(
      onSuccess: (data, _) {
        if (data != null) {
          _profileController.dashboard.user = userDetails.copyWith(
            profileImage: data,
          );
          profileEditState.pickedImageProfile = CustomFileModel();
        }
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

  Future<void> onImageUpdatedSubmitted() async {
    if (_profileController.netController.isNotConnected) {
      return warningState(
        true,
        "sorry your connection is lost, please check your settings before continuing.",
      );
    }
    _states.value = States(isLoading: true);
    await updateProfileImage();
    _states.value = states.copyWith(isLoading: false);
  }

  void _onStatesListener(States value) {
    try {
      loadingOverlayController.status = value.isLoading;
    } catch (e, s) {
      print(s);
      print(e);
    }
  }

  StreamSubscription<States>? _statesSub;

  @override
  void onInit() {
    _statesSub = _states.listen(_onStatesListener, cancelOnError: true);
    profileEditState.setAll(_profileController.user);
    super.onInit();
  }

  @override
  void onClose() {
    profileEditState.disposeTextControllers();
    _statesSub?.cancel();
    loadingOverlayController.dispose();
    super.onClose();
  }

  void set profileImagePath(String? value) {
    _profileImagePath.value = value ?? "";
  }
}

class ProfileEditState {
  final name = GetXTextEditingController();
  final email = GetXTextEditingController();
  final phone = GetXTextEditingController();
  final secondaryPhone = GetXTextEditingController();
  final gender = GetXTextEditingController();
  final _genderValue = (Gender.Male).obs;

  Gender get genderValue => _genderValue.value;

  void set genderValue(Gender value) {
    gender.text = value.name;
    _genderValue.value = value;
  }

  final _pickedImageProfile = CustomFileModel().obs;

  CustomFileModel get pickedImageProfile => _pickedImageProfile.value;

  set pickedImageProfile(CustomFileModel value) {
    _pickedImageProfile.value = value;
  }

  void clearFields() {
    name.text = "";
    email.text = "";
    phone.text = "";
    gender.text = "";
    secondaryPhone.text = "";
    pickedImageProfile = CustomFileModel();
  }

  void setAll(ProfileInfoModel? data) {
    name.text = data?.name ?? "";
    email.text = data?.email ?? "";
    phone.text = data?.phone ?? "";
    secondaryPhone.text = data?.secondaryPhone ?? "";
    gender.text = data?.gender ?? "";
  }

  ProfileInfoModel get form => ProfileInfoModel(
        name: name.text,
        phone: phone.text,
        email: email.text,
        secondaryPhone: secondaryPhone.text,
        gender: gender.text,
      );

  void disposeTextControllers() {
    name.dispose();
    phone.dispose();
    email.dispose();
    secondaryPhone.dispose();
    gender.dispose();
  }
}
