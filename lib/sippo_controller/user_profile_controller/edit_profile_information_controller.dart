import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/custom_app_controller/switch_status_controller.dart';
import 'package:jobspot/sippo_controller/dashboards_controller/user_dashboard_controller.dart';
import 'package:jobspot/sippo_controller/user_profile_controller/profile_user_controller.dart';
import 'package:jobspot/sippo_custom_widget/gender_picker_widget.dart';
import 'package:jobspot/sippo_data/locations/locationsRepo.dart';
import 'package:jobspot/sippo_data/model/custom_file_model/custom_file_model.dart';
import 'package:jobspot/sippo_data/model/locations_model/location_address_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/profile_edit_model.dart';
import 'package:jobspot/sippo_data/update_image_profile_repo/update_image_profile_repo.dart';
import 'package:jobspot/sippo_data/user_repos/edit_profile_repo.dart';
import 'package:jobspot/utils/getx_text_editing_controller.dart';
import 'package:jobspot/utils/states.dart';

class EditProfileInfoController extends GetxController {
  final _profileImagePath = "".obs;
  final _profileController = ProfileUserController.instance;
  final loadingOverlayController = SwitchStatusController();

  ProfileInfoModel get userDetails => _profileController.user;
  final profileEditState = ProfileEditState();
  final _states = States().obs;

  States get states => _states.value;

  void set states(States value) => _states.value = value;
  final _locationStates = States().obs;

  States get locationStates => _locationStates.value;

  void set locationStates(States value) => _locationStates.value = value;
  final GlobalKey<FormState> formKey = GlobalKey();

  bool get isEmailVerified => userDetails.isEmailVerified == true;

  void successState(bool value, [String? message]) {
    _states.value = states.copyWith(isSuccess: value, message: message);
  }

  void warningState(bool value, [String? message]) {
    _states.value = states.copyWith(isWarning: value, message: message);
  }

  Future<void> updateProfileInfo() async {
    final user = profileEditState.form;
    final loc = profileEditState.selectedLocationAddress;

    print("is user profile true ${user == userDetails}");
    if (user == userDetails) {
      if (loc == userDetails.locationAddress)
        states = states.copyWith(
          isWarning: true,
          message: 'no changes to profile info for user',
        );
      print('no changes to profile info for user ');
      return;
    }
    final response = await ProfileInfoRepo.updateProfile(profileEditState.form);
    await response.checkStatusResponse(
      onSuccess: (data, _) {
        if (data != null) {
          _profileController.dashboard.user = data;
          profileEditState.setAll(userDetails);
        } else {
          UserDashBoardController.instance.userInformationRefresh();
        }
        states = States(isSuccess: true);
      },
      onValidateError: (validateError, _) {
        states = States(isError: true, message: validateError?.message);
      },
      onError: (message, _) {
        states = States(isError: true, message: message);
      },
    );
  }

  Future<void> updateLocationAddress() async {
    final loc = profileEditState.selectedLocationAddress;
    print(
        'is updating location address true ${loc == userDetails.locationAddress}');
    if (loc == userDetails.locationAddress) {
      print('no change in user location');
      return;
    }
    final response = await ProfileInfoRepo.updateProfileLocation({
      'location_id': profileEditState.selectedLocationAddress.id,
      "longitude": 0,
      "latitude": 0,
    });
    await response?.checkStatusResponse(
      onSuccess: (data, _) {
        final locationAddress = data?.locationAddress;
        if (data != null && locationAddress != null) {
          _profileController.dashboard.user = data;
          profileEditState.selectedLocationAddress = locationAddress;
        } else {
          UserDashBoardController.instance.userInformationRefresh();
        }
        locationStates = States(isSuccess: true);
      },
      onValidateError: (validateError, _) {
        locationStates = States(isError: true, message: validateError?.message);
      },
      onError: (message, _) {
        locationStates = States(isError: true, message: message);
      },
    );
  }

  Future<void> fetchLocationsAddress() async {
    profileEditState.states.value = States(isLoading: true);
    final response = await LocationsRepo.fetchLocations();
    profileEditState.states.value = States(isLoading: false);
    await response?.checkStatusResponse(
      onSuccess: (data, _) {
        if (data != null) {
          profileEditState.locationsAddressList = data;
          profileEditState.states.value = States(isSuccess: true);
        }
      },
      onValidateError: (validateError, _) {},
      onError: (message, _) {
        profileEditState.states.value = States(isError: true);
      },
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
        "connection_lost_message_1".tr,
      );
    }
    states = States(isLoading: true);
    locationStates = States(isLoading: true);
    await Future.wait([
      updateProfileInfo(),
      updateLocationAddress(),
    ]);

    states = states.copyWith(isLoading: false);
    locationStates = locationStates.copyWith(isLoading: false);
  }

  Future<void> onImageUpdatedSubmitted() async {
    if (_profileController.netController.isNotConnected) {
      return warningState(
        true,
        "connection_lost_message_1".tr,
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
    fetchLocationsAddress();
    _statesSub = _states.listen(_onStatesListener, cancelOnError: true);
    profileEditState.setAll(userDetails);
    profileEditState.selectedLocationAddress =
        userDetails.locationAddress ?? profileEditState.selectedLocationAddress;
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
  final states = States().obs;

  void resetStates() => states.value = States();

  final _locationsAddress = <LocationAddress>[].obs;

  List<LocationAddress> get locationsAddressList => _locationsAddress.toList();

  List<String> get locationsAddressNameList => locationsAddressList
      .where((e) => e.name != null)
      .map((e) => e.name ?? '')
      .toList();

  set locationsAddressList(List<LocationAddress> value) =>
      _locationsAddress.value = value;
  final _selectedLocationAddressName = LocationAddress().obs;

  LocationAddress get selectedLocationAddress =>
      _selectedLocationAddressName.value;

  void set selectedLocationAddress(LocationAddress value) {
    _selectedLocationAddressName.value = value;
  }

  final name = GetXTextEditingController();
  final email = GetXTextEditingController();
  final phone = GetXTextEditingController();
  final secondaryPhone = GetXTextEditingController();
  final gender = GetXTextEditingController();
  final _genderValue = (Gender.Male).obs;
  final bio = GetXTextEditingController();

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
    bio.text = data?.bio ?? '';
  }

  ProfileInfoModel get form {
    return UserDashBoardController.instance.user.copyWith(
      name: name.text,
      phone: phone.text,
      email: email.text,
      secondaryPhone: secondaryPhone.text,
      gender: gender.text,
      bio: bio.text,
    );
  }

  void disposeTextControllers() {
    name.dispose();
    phone.dispose();
    email.dispose();
    secondaryPhone.dispose();
    gender.dispose();
    bio.dispose();
  }
}
