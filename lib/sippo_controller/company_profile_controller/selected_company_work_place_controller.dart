import 'package:get/get.dart';
import 'package:jobspot/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/custom_app_controller/google_map_view_controller.dart';
import 'package:jobspot/sippo_controller/company_profile_controller/profile_company_controller.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/sippo_data/company_repos/company_locations_repo.dart';
import 'package:jobspot/sippo_data/locations/locationsRepo.dart';
import 'package:jobspot/sippo_data/model/locations_model/location_address_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/work_location_model.dart';
import 'package:jobspot/utils/states.dart';

import '../dashboards_controller/company_dashboard_controller.dart';

class SelectedCompanyWorkPlaceController extends GetxController {
  static SelectedCompanyWorkPlaceController get instance => Get.find();

  WorkLocationModel get workPlace => WorkLocationModel(
        locationAddress: selectedWorkPlaceState.selectedLocationAddress,
        cordLocation: googleMapViewController.markerAsCoordLocation,
        isHQ: selectedWorkPlaceState.isHq,
      );
  final googleMapViewController = GoogleMapViewController();
  final companyProfileController = ProfileCompanyController.instance;
  final _states = States().obs;

  bool get isEditing => companyProfileController.editLocation != null;

  WorkLocationModel? get editLocation => companyProfileController.editLocation;

  States get states => _states.value;

  void changeStates({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    bool? isWarning,
    String? message,
    String? error,
  }) {
    print("is loading:  $isLoading");
    _states.value = states.copyWith(
      isLoading: isLoading,
      isSuccess: isSuccess,
      isError: isError,
      message: message,
      isWarning: isWarning,
      error: error,
    );
  }

  Future<void> fetchLocationsAddress() async {
    final response = await LocationsRepo.fetchLocations();
    await response?.checkStatusResponse(
      onSuccess: (data, _) {
        if (data != null) {
          selectedWorkPlaceState.locationsAddressList = data;
        }
      },
      onValidateError: (validateError, _) {},
      onError: (message, _) {},
    );
  }

  final selectedWorkPlaceState = SelectedCompanyWorkPlaceState();

  Future<void> addNewWorkPlace() async {
    print(workPlace);
    final response = await CompanyLocationsRepo.addNewWorkPlace(workPlace);
    _states.value = States();
    response?.checkStatusResponse(
      onSuccess: (data, _) {
        if (data != null) {
          final company = CompanyDashBoardController.instance.company;
          CompanyDashBoardController.instance.company = company.copyWith(
            locations: company.locations?.toList()?..add(data),
          );
          Get.dialog(
            CustomAlertDialog(
              title: 'label_work_places'.tr,
              description: 'work_place_added_message'.tr,
              confirmBtnTitle: 'ok'.tr,
              onConfirm: () => {if (Get.isOverlaysOpen) Get.back()},
            ),
          ).then((_) => Get.back());
        }
      },
      onValidateError: (validateError, _) {
        _states.value = States(isError: true, message: validateError?.message);
      },
      onError: (message, _) {
        _states.value = States(isError: true, message: message);
      },
    );
    // write the code for add the new the address location work place here;.
  }

  Future<void> updateWorkPlace() async {
    final newWorkPlace = workPlace;
    if (newWorkPlace.isEqualToContentOf(editLocation)) {
      return changeStates(
        isWarning: true,
        message: 'nothing_changed_work_place_message'.tr,
      );
    }
    print(workPlace);
    final response = await CompanyLocationsRepo.updateCompanyWorkPlace(
      workPlace,
      editLocation?.id,
    );
    _states.value = States();
    response?.checkStatusResponse(
      onSuccess: (data, _) {
        CompanyDashBoardController.instance.refreshUserProfileInfo();
        Get.dialog(
          CustomAlertDialog(
            title: 'label_work_places'.tr,
            description: 'work_place_updated_message'.tr,
            confirmBtnTitle: 'ok'.tr,
            onConfirm: () => {if (Get.isOverlaysOpen) Get.back()},
          ),
        ).then((_) => Get.back());
      },
      onValidateError: (validateError, _) {},
      onError: (message, _) {},
    );
    // write the code for add the new the address location work place here;.
  }

  void startFetchingLocationAddress() async {
    if (InternetConnectionService.instance.isNotConnected) return;
    if (states.isLoading) return;
    _states.value = States(isLoading: true);
    await fetchLocationsAddress();
    changeStates(isLoading: false);
  }

  Future deleteLocation() async {
    final response =
        await CompanyLocationsRepo.deleteWorkPlaceById(editLocation?.id);
    await response?.checkStatusResponse(
      onSuccess: (data, _) {
        CompanyDashBoardController.instance.refreshUserProfileInfo();
        Get.dialog(
          CustomAlertDialog(
            title: 'Work Place',
            description: 'Work Place has been deleted successfully',
            confirmBtnTitle: 'ok'.tr,
            onConfirm: () => {if (Get.isOverlaysOpen) Get.back()},
          ),
        ).then((_) => Get.back());
      },
      onValidateError: (validateError, _) {},
      onError: (message, _) {},
    );
  }

  Future onDeleteSubmitted() async {
    if (InternetConnectionService.instance.isNotConnected) return;
    if (states.isLoading) return;
    _states.value = States(isLoading: true);
    await deleteLocation();
    changeStates(isLoading: false);
  }

  void onSaveWorkPlaceSubmitted() async {
    if (InternetConnectionService.instance.isNotConnected) return;
    if (states.isLoading) return;
    if (!googleMapViewController.markerAsCoordLocation.validateCords()) {
      return changeStates(
        isWarning: true,
        message: 'Please place an mark location in the map for '
            'the new location of work place.',
      );
    }
    if (selectedWorkPlaceState.selectedLocationAddress.id == null) {
      return changeStates(
        isWarning: true,
        message: 'Please select the address for'
            ' the new location of work place.',
      );
    }
    _states.value = States(isLoading: true);
    if (isEditing) {
      await updateWorkPlace();
    } else {
      await addNewWorkPlace();
    }
  }

  @override
  void onInit() {
    startFetchingLocationAddress();
    if (isEditing) {
      selectedWorkPlaceState.setLocation(editLocation);
      Future.delayed(const Duration(seconds: 3), () {
        googleMapViewController
            .onMapLocationMarked(editLocation?.cordLocation?.toLatLng);
      });
    } else {
      googleMapViewController.getCurrentLocation();
    }
    super.onInit();
  }

  @override
  void onClose() {
    googleMapViewController.dispose();
    super.onClose();
  }
}

class SelectedCompanyWorkPlaceState {
  void setLocation(WorkLocationModel? value) {
    selectedLocationAddress = value?.locationAddress ?? selectedLocationAddress;
    isHq = value?.isHQ ?? false;
  }

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

  final _isHq = false.obs;

  bool get isHq => _isHq.isTrue;

  set isHq(bool value) {
    _isHq.value = value;
  }
}
