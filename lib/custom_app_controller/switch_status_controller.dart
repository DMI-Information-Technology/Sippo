import 'package:flutter/material.dart';

class SwitchStatusController with ChangeNotifier {
  SwitchStatusController({bool status = false}) : _status = status;
  bool _status = false;

  bool get status => _status;

  void unFocusTextField(BuildContext context) {
    if (_status) FocusScope.of(context).unfocus();
  }

  void start() {
    status = true;
  }

  void pause() {
    status = false;
  }

  set status(bool value) {
    if (value == _status) return;
    _status = value;
    notifyListeners();
  }

  @override
  void dispose() {
    print("LoadingOverlayController is disposed.");
    super.dispose();
  }
}
