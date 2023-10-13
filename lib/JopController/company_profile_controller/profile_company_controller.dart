import 'dart:async';

import 'package:get/get.dart';
import 'package:jobspot/JobServices/ConnectivityController/internet_connection_controller.dart';

import '../../sippo_custom_widget/profile_completion_widget.dart';
import '../../sippo_data/model/auth_model/company_response_details.dart';
import '../../utils/states.dart';
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
}

class ProfileCompanyState {
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
