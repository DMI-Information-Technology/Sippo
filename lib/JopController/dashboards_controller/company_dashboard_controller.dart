import 'dart:async';

import 'package:get/get.dart';

import '../../sippo_data/company_repos/company_profile_info_repo.dart';
import '../../sippo_data/model/auth_model/company_response_details.dart';
import '../ConnectivityController/internet_connection_controller.dart';

class CompanyDashBoardController extends GetxController {
  // final _httpClientController = Get.put(HttpClientController());

  final dashboardState = CompanyDashBoardState();

  static CompanyDashBoardController get instance => Get.find();

  final _company = CompanyDetailsResponseModel().obs;
  StreamSubscription<bool>? _connectionSubscription;

  CompanyDetailsResponseModel get company => _company.value;

  void set company(CompanyDetailsResponseModel profile) =>
      _company.value = profile;
  final _selectedItemIndex = 0.obs;

  int get selectedItemIndex => _selectedItemIndex.toInt();

  void set selectedItemIndex(int value) {
    _selectedItemIndex.value = value;
  }

  Future<void> getCompanyProfile() async {
    final response = await EditCompanyProfileInfoRepo.getCompanyProfile();
    response?.checkStatusResponse(
      onSuccess: (data, _) {
        if (data == null) return;
        print(
            "getCompanyProfile: is equal to user ? = ${data == _company.value}");
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
    _connectionSubscription = InternetConnectionController
        .instance.isConnectedStream
        .listen(_connected);
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
    _editId.value = value;
  }
}
