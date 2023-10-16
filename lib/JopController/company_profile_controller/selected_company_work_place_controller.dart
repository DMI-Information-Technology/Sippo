import 'package:get/get.dart';
import 'package:jobspot/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/custom_app_controller/google_map_view_controller.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/work_location_model.dart';
import 'package:jobspot/utils/states.dart';

import 'package:jobspot/sippo_data/company_repos/company_locations_repo.dart';
import '../dashboards_controller/company_dashboard_controller.dart';

class SelectedCompanyWorkPlaceController extends GetxController {
  static SelectedCompanyWorkPlaceController get instance => Get.find();

  WorkLocationModel get workPlace => WorkLocationModel(
        address: selectedWorkPlaceState.selectedLocationAddressName,
        location: googleMapViewController.markerAsCoordLocation,
        isHQ: selectedWorkPlaceState.isHq,
      );
  final googleMapViewController = GoogleMapViewController();

  final _states = States().obs;

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
      isSuccess: isLoading == true ? false : isSuccess,
      isError: isLoading == true ? false : isError,
      message: isLoading == true ? '' : message,
      isWarning: isLoading == true ? false : isWarning,
      error: error,
    );
  }

  final selectedWorkPlaceState = SelectedCompanyWorkPlaceState();

  Future<void> fetchAddressLocationNames() async {
    // write the code for fetching the address location names here;.
  }

  Future<void> addNewWorkPlace() async {
    print(workPlace);
    final response = await CompanyLocationsRepo.addNewWorkPlace(workPlace);
    response?.checkStatusResponse(
      onSuccess: (data, _) {
        if (data != null) {
          final company = CompanyDashBoardController.instance.company;
          CompanyDashBoardController.instance.company = company.copyWith(
            locations: company.locations?.toList()?..add(data),
          );
          changeStates(
            isSuccess: true,
            message: 'The Work Place has been added successfully.',
          );
        }
      },
      onValidateError: (validateError, _) {},
      onError: (message, _) {},
    );
    // write the code for add the new the address location work place here;.
  }

  void startFetching() async {
    if (InternetConnectionService.instance.isNotConnected) return;
    if (states.isLoading) return;
    changeStates(isLoading: true);
    await fetchAddressLocationNames();
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
    if (selectedWorkPlaceState.selectedLocationAddressName.isEmpty) {
      return changeStates(
        isWarning: true,
        message: 'Please select the address for'
            ' the new location of work place.',
      );
    }
    changeStates(isLoading: true);
    await addNewWorkPlace();
    changeStates(isLoading: false);
  }

  @override
  void onInit() {
    // startFetching();
    googleMapViewController.getCurrentLocation();
    super.onInit();
  }

  @override
  void onClose() {
    googleMapViewController.dispose();
    super.onClose();
  }
}

class SelectedCompanyWorkPlaceState {
  final _selectedLocationAddressName = "".obs;

  String get selectedLocationAddressName => _selectedLocationAddressName.trim();

  void set selectedLocationAddressName(String value) {
    _selectedLocationAddressName.value = value;
  }

  final _locationsAddress = <String>[].obs;

  List<String> get locationsAddress => _locationsAddress.toList();

  void set locationsAddress(List<String> value) {
    _locationsAddress.value = value;
  }

  final _isHq = false.obs;

  bool get isHq => _isHq.isTrue;

  set isHq(bool value) {
    _isHq.value = value;
  }
}
