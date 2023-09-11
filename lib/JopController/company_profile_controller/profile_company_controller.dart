import 'dart:async';

import 'package:get/get.dart';

import '../../sippo_data/model/auth_model/company_response_details.dart';
import '../ConnectivityController/internet_connection_controller.dart';
import '../dashboards_controller/company_dashboard_controller.dart';

class ProfileCompanyController extends GetxController {
  static ProfileCompanyController get instance => Get.find();

  final netController = InternetConnectionController.instance;

  final dashboard = CompanyDashBoardController.instance;

  CompanyResponseDetailsModel get company => dashboard.company;

  // late final StreamSubscription<bool>? _connectionSubscription;

  // final profileState = ProfileCompanyState();

  Future<void> fetchResources() async {
    // final List<Future> futures =
    // await Future.wait(futures);
    await Future.wait([
      // Add more API calls here
    ]);
  }

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
    super.onInit();
  }

  @override
  void onClose() {
    // _connectionSubscription?.cancel();
    super.onClose();
  }
}

// class ProfileCompanyState {}
