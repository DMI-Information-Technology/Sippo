import 'dart:async';

import 'package:get/get.dart';
import 'package:sippo/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:sippo/custom_app_controller/switch_status_controller.dart';
import 'package:sippo/sippo_controller/dashboards_controller/company_dashboard_controller.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';
import 'package:sippo/sippo_data/company_repos/company_profile_info_repo.dart';
import 'package:sippo/sippo_data/model/auth_model/company_response_details.dart';
import 'package:sippo/sippo_data/model/specializations_model/specializations_model.dart';
import 'package:sippo/sippo_data/specializations/specializations_repo.dart';
import 'package:sippo/utils/helper.dart';
import 'package:sippo/utils/states.dart';

class EditAddSpecializationCompanyController extends GetxController {
  static EditAddSpecializationCompanyController get instance => Get.find();

  CompanyDetailsModel get company =>
      CompanyDashBoardController.instance.company;
  final loadingOverly = SwitchStatusController();

  bool get isModifyStateChanged =>
      modifyStates.isError || modifyStates.isWarning;
  final _fetchStates = States().obs;

  States get fetchStates => _fetchStates.value;

  void set fetchStates(States state) => _fetchStates.value = state;
  final _modifyStates = States().obs;

  States get modifyStates => _modifyStates.value;

  void set modifyStates(States state) => _modifyStates.value = state;

  void resetState() => _modifyStates.value = States();
  final _specializations = <SpecializationModel>[].obs;

  bool get isNetworkConnected => InternetConnectionService.instance.isConnected;

  List<SpecializationModel> get specializations => _specializations.toList();

  int get specializationsLength => _specializations.length;

  set specializations(List<SpecializationModel> value) {
    _specializations.value = value;
  }

  final _selectedSpecialization = <SpecializationModel>[].obs;

  List<SpecializationModel> get selectedSpecialization {
    return _selectedSpecialization.toList();
  }

  void set selectedSpecialization(List<SpecializationModel> value) {
    _selectedSpecialization.value = value;
  }

  bool isSpecialSelected(SpecializationModel value) {
    return _specializations.firstWhereOrNull(
          (e) => e.id == value.id,
        ) !=
        null;
  }

  bool fromSelectedSpecial(SpecializationModel value) {
    return _selectedSpecialization.firstWhereOrNull(
          (e) => e.id == value.id,
        ) !=
        null;
  }

  void toggleSpecialization(SpecializationModel value) {
    if (fromSelectedSpecial(value)) {
      return _selectedSpecialization.removeWhere(
        (e) => e.id == value.id,
      );
    }
    _selectedSpecialization.add(value);
  }

  Future<void> fetchSpecializations() async {
    if (!isNetworkConnected) return;
    fetchStates = States(isLoading: true);
    final response = await SpecializationRepo.fetchSpecializationsResource();
    fetchStates = States(isLoading: false);
    await response?.checkStatusResponse(
      onSuccess: (data, statusType) {
        if (data != null) {
          specializations = data;
          fetchStates = States(isSuccess: true);
        }
      },
      onValidateError: (validateError, statusType) {
        fetchStates = States(isError: true, message: validateError?.message);
      },
      onError: (message, statusType) {
        fetchStates = States(isError: true, message: message);
      },
    );
  }

  Future<void> updateSpecializations() async {
    if (!isNetworkConnected) return;
    if (modifyStates.isLoading) return;
    if (selectedSpecialization.length == 0 ||
        selectedSpecialization.length > 3) {
      _modifyStates(
        States(
          isError: true,
          message: 'pick_specialization_message'.tr,
        ),
      );
      return;
    }
    if (listEquality(selectedSpecialization, company.specializations)) {
      _modifyStates(
        States(
          isWarning: true,
          message: 'nothing_changed_specializations'.tr,
        ),
      );
      return;
    }
    modifyStates = States(isLoading: true);
    final response = await EditCompanyProfileInfoRepo.updateCompanyProfile(
      company.copyWith(
        specializations: selectedSpecialization,
      ),
    );
    modifyStates = States(isLoading: false);

    await response.checkStatusResponse(
      onSuccess: (data, _) async {
        if (data == null ||
            data.specializations == null ||
            data.specializations!.isEmpty) {
          CompanyDashBoardController.instance.refreshUserProfileInfo();
        } else {
          CompanyDashBoardController.instance.company = data;
        }
        Get.dialog(
          CustomAlertDialog(
            title: 'specializations_company_title'.tr,
            description: 'specializations_added'.tr,
            confirmBtnTitle: 'ok'.tr,
            onConfirm: () => {if (Get.isOverlaysOpen) Get.back()},
          ),
        ).then((_) => Get.back());
      },
      onValidateError: (validateError, _) {
        modifyStates = States(isError: true, message: validateError?.message);
      },
      onError: (message, _) {
        modifyStates = States(isError: true, message: message);
      },
    );
  }

  StreamSubscription<States>? fetchStateStubs;
  StreamSubscription<States>? modifyStatesSubs;

  @override
  void onInit() {
    fetchStateStubs = _fetchStates.listen((value) {
      if (value.isLoading) {
        loadingOverly.start();
      } else {
        loadingOverly.pause();
      }
    });
    modifyStatesSubs = _modifyStates.listen((value) {
      if (value.isLoading) {
        loadingOverly.start();
      } else {
        loadingOverly.pause();
      }
    });
    selectedSpecialization =
        company.specializations?.toList() ?? selectedSpecialization;
    fetchSpecializations();
    super.onInit();
  }

  @override
  void onClose() {
    fetchStateStubs?.cancel();
    modifyStatesSubs?.cancel();
    super.onClose();
  }
}
