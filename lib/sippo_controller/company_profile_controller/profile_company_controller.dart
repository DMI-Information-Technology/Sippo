import 'dart:async';

import 'package:get/get.dart';
import 'package:jobspot/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/sippo_custom_widget/profile_completion_widget.dart';
import 'package:jobspot/sippo_data/company_repos/company_gallery_images_repo.dart';
import 'package:jobspot/sippo_data/model/auth_model/company_response_details.dart';
import 'package:jobspot/sippo_data/model/custom_file_model/custom_file_model.dart';
import 'package:jobspot/sippo_data/model/image_resource_model/image_resource_model.dart';
import 'package:jobspot/utils/states.dart';

import '../dashboards_controller/company_dashboard_controller.dart';

class ProfileCompanyController extends GetxController {
  static ProfileCompanyController get instance => Get.find();
  final profileCompletionController = ProfileCompletionController(0.0);

  final _states = States().obs;

  States get states => _states.value;

  void set states(States value) => _states.value = value;

  final netController = InternetConnectionService.instance;

  final dashboard = CompanyDashBoardController.instance;

  CompanyDetailsModel get company => dashboard.company;

  // late final StreamSubscription<bool>? _connectionSubscription;

  final profileState = ProfileCompanyState();

  // Future<void> fetchResources() async {
  //   // final List<Future> futures =
  //   // await Future.wait(futures);
  //   await Future.wait([
  //     // Add more API calls here
  //   ]);
  // }

  // void _connected(bool isConn) async => isConn ? await fetchResources() : null;

  // void _startListeningToConnection() {
  //   _connectionSubscription = netController.isConnectedStream.listen(
  //     _connected,
  //   );
  //   fetchResources();
  // }

  @override
  void onInit() {
    // _startListeningToConnection();
    profileCompletionController.updateCompletionLength(
      company.blankProfileMessagesLength,
    );
    profileState.companyProfileSubscription =
        dashboard.startCompanyProfileListener((value) {
      profileCompletionController.updateCompletionLength(
        company.blankProfileMessagesLength,
      );
    });
    super.onInit();
  }

  @override
  void onClose() {
    // _connectionSubscription?.cancel();
    profileState.close();
    super.onClose();
  }

  Future<bool> uploadCompanyImages(List<CustomFileModel> images) async {
    if (InternetConnectionService.instance.isNotConnected) return false;
    if (states.isLoading) return false;
    states = States(isLoading: true);
    final response = await CompanyGalleryImagesRepo.uploadCompanyImages(images);
    final result = await response.checkStatusResponseAndGetData(
      onValidateError: (validateError, _) {},
      onError: (message, _) {},
    );
    states = states.copyWith(isLoading: false);
    if (result != null && result.isNotEmpty) {
      CompanyDashBoardController.instance.company = company.copyWith(
        images: (() {
          final temp = <ImageResourceModel>[];
          for (final image in result) if (image != null) temp.add(image);
          return temp;
        })(),
      );
      return true;
    }
    return false;
  }

  Future<bool> removeImageCompany(int? id, int index) async {
    if (InternetConnectionService.instance.isNotConnected) return false;
    if (states.isLoading) return false;
    states = States(isLoading: true);
    final response = await CompanyGalleryImagesRepo.removeImageCompany(id);
    final result = await response.checkStatusResponseAndGetData(
      onValidateError: (validateError, statusType) {},
      onError: (message, statusType) {},
    );
    states = states.copyWith(isLoading: false);
    if (result != null) {
      CompanyDashBoardController.instance.company =
          company.copyWith(images: company.images?..removeAt(index));
      return true;
    }
    return false;
  }
}

class ProfileCompanyState {
  final _isHeightOverAppBar = false.obs;

  bool get isHeightOverAppBar => _isHeightOverAppBar.isTrue;

  set isHeightOverAppBar(bool value) => _isHeightOverAppBar.value = value;
  StreamSubscription? companyProfileSubscription;

  void close() {
    companyProfileSubscription?.cancel();
  }

  final _showAllLocations = false.obs;

  bool get showAllLocations => _showAllLocations.isTrue;

  void set showAllLocations(bool value) {
    _showAllLocations.value = value;
  }

  void switchShowAllLocations() {
    _showAllLocations.toggle();
  }

  final _showAllSpecializations = false.obs;

  bool get showAllSpecializations => _showAllSpecializations.isTrue;

  void set showAllSpecializations(bool value) {
    _showAllLocations.value = value;
  }

  void switchShowAllSpecializations() {
    _showAllSpecializations.toggle();
  }
}
