import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../JopCustomWidget/error_messages_dialog_snackbar/error_messages.dart'
    as errorMessage;

class InternetConnectionController extends GetxController {
  static InternetConnectionController get instance => Get.find();

  final _isConnected = true.obs;

  bool get isConnected => _isConnected.isTrue;

  void set isConnected(bool value) => _isConnected.value = value;

  @override
  void onInit() {
    super.onInit();
    checkInternetConnection();
    Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> checkInternetConnection() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    _isConnected.value = connectivityResult != ConnectivityResult.none;
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    _isConnected.value = result != ConnectivityResult.none;
  }

  bool isConnectionLostWithDialog() {
    if (!_isConnected.isTrue) {
      errorMessage.showNoConnectionDialog();
      return true;
    }
    return false;
  }
}
