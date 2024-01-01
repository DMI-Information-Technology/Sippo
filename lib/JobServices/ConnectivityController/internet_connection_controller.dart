import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sippo/sippo_custom_widget/error_messages_dialog_snackbar/error_messages.dart'
    as errorMessage;

class InternetConnectionService extends GetxService {
  static InternetConnectionService get instance => Get.find();
  late StreamController<bool> _connectionStreamController;

  // StreamController<bool>.broadcast();
  static Future<double> getSignalStrength() async {
    final stopwatch = Stopwatch();
    stopwatch.start();
    try {
      await http.get(Uri.parse('https://www.google.com'));
    } catch (e, s) {
      print(e);
      print(s);
      stopwatch.stop();
      return 0.0;
    }
    stopwatch.stop();
    final time = stopwatch.elapsedMilliseconds;
    final signalStrength = (time / 1000) * 1.0;
    return signalStrength;
  }

  Stream<bool> get isConnectedStream => _connectionStreamController.stream;

  final _isConnected = true.obs;
  var connectionCounter = 0;

  bool get isConnected {
    final connection = _isConnected.isTrue;
    connectionWarning(connection);
    return connection;
  }

  void connectionWarning(bool connection) {
    if (!connection && connectionCounter >= 3) {
      errorMessage.showNoConnectionSnackbar();
      connectionCounter = 0;
    }
    connectionCounter++;
  }

  bool get isConnectedNorm => _isConnected.isTrue;

  bool get isNotConnected => !isConnected;

  void set isConnected(bool value) {
    _isConnected.value = value;
    _connectionStreamController.add(value);
  }

  @override
  void onInit() {
    super.onInit();
    (() async {})();
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
