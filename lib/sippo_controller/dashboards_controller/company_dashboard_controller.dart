import 'dart:async';

import 'package:get/get.dart';
import 'package:sippo/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:sippo/sippo_data/company_repos/company_profile_info_repo.dart';
import 'package:sippo/sippo_data/model/auth_model/company_response_details.dart';

class CompanyDashBoardController extends GetxController {
  // final _httpClientController = Get.put(HttpClientController());

  final dashboardState = CompanyDashBoardState();

  static CompanyDashBoardController get instance => Get.find();

  final _company = CompanyDetailsModel().obs;
  StreamSubscription<bool>? _connectionSubscription;

  CompanyDetailsModel get company => _company.value;

  StreamSubscription<CompanyDetailsModel> startCompanyProfileListener(
    void Function(CompanyDetailsModel) onData,
  ) {
    return _company.listen(onData);
  }

  void set company(CompanyDetailsModel profile) => _company.value = profile;
  final _selectedItemIndex = 0.obs;

  int get selectedItemIndex => _selectedItemIndex.toInt();

  void set selectedItemIndex(int value) {
    if (selectedItemIndex == value) return;
    _selectedItemIndex.value = value;
  }

  Future<void> getCompanyProfile() async {
    final response = await EditCompanyProfileInfoRepo.getCompanyProfile();
    response?.checkStatusResponse(
      onSuccess: (data, _) {
        if (data == null) return;
        if (data == _company.value) return;
        _company.value = data;
      },
      onValidateError: (error, _) {},
      onError: (message, statusType) {},
    );
  }

  void _connected(bool isConn) async {
    if (!company.isProfileBlank) {
      _connectionSubscription?.cancel();
      _connectionSubscription = null;
      return;
    }
    if (isConn) {
      await getCompanyProfile();
    }
  }

  void _startListeningToConnection() async {
    _connectionSubscription =
        InternetConnectionService.instance.isConnectedStream.listen(_connected);
    print(_connectionSubscription != null);
    await getCompanyProfile();
  }

  Future<void> refreshUserProfileInfo() async {
    await getCompanyProfile();
  }

  @override
  void onInit() {
    _startListeningToConnection();
    // _user.value = ProfileInfoModel.fromJson(GlobalStorage.userJson);
    print("CompanyDashBoardController onInit: ${_company.value}");
    super.onInit();
  }

  @override
  void onClose() {
    if (_connectionSubscription != null) _connectionSubscription?.cancel();
    super.onClose();
  }
}

class CompanyDashBoardState {
  var profileViewId = -1;
  final _editId = (-1).obs;

  int get editId => _editId.toInt();

  void set editId(int value) {
    print(Get.currentRoute);
    _editId.value = value;
  }
}
