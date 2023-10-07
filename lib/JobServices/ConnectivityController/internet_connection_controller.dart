import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';

import '../../sippo_custom_widget/error_messages_dialog_snackbar/error_messages.dart'
    as errorMessage;

class InternetConnectionService extends GetxService {
  static InternetConnectionService get instance => Get.find();
  late StreamController<bool> _connectionStreamController;

  // StreamController<bool>.broadcast();

  Stream<bool> get isConnectedStream => _connectionStreamController.stream;

  final _isConnected = true.obs;
  var connectionCounter = 0;

  bool get isConnected {
    print(connectionCounter);
    final connection = _isConnected.isTrue;
    if (!connection && connectionCounter >= 3) {
      Get.snackbar(
        icon: Icon(Icons.signal_wifi_statusbar_connected_no_internet_4_rounded),
        'No Connection',
        'Your connection is lost, please check your connection and try again',
        backgroundColor: Jobstopcolor.backgroudHome,
        boxShadows: [boxShadow],
      );
      connectionCounter = 0;
    }
    connectionCounter++;
    return connection;
  }

  bool get isNotConnected => !isConnected;

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
