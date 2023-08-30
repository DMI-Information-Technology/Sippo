import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../sippo_custom_widget/error_messages_dialog_snackbar/error_messages.dart'
    as errorMessage;

class InternetConnectionController extends GetxController {
  static InternetConnectionController get instance => Get.find();
 late StreamController<bool> _connectionStreamController ;
      // StreamController<bool>.broadcast();

  Stream<bool> get isConnectedStream => _connectionStreamController.stream;

  final _isConnected = true.obs;

  bool get isConnected => _isConnected.isTrue;

  void set isConnected(bool value) {
    // print("from is connected: $value");
    _isConnected.value = value;
    _connectionStreamController.add(value);
  }

  @override
  void onInit() {
    super.onInit();
    _connectionStreamController = StreamController<bool>.broadcast();
    checkInternetConnection();
    Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> checkInternetConnection() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    isConnected = connectivityResult != ConnectivityResult.none;
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    isConnected = result != ConnectivityResult.none;
  }

  bool isConnectionLostWithDialog() {
    if (!_isConnected.isTrue) {
      errorMessage.showNoConnectionDialog();
      return true;
    }
    return false;
  }

  @override
  void onClose() {
    _connectionStreamController.close();
    super.onClose();
  }
}
