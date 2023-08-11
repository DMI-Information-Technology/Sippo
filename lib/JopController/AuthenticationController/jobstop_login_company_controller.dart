import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LoginCompanyController extends GetxController {
  final _phoneNumber = "".obs;
  final _password = "".obs;
  final _isRembereMeChecked = false.obs;
  bool get isRembereMeChecked => _isRembereMeChecked.isTrue;

  String get password => _password.toString();

  String get phoneNumber => _phoneNumber.toString();

  set phoneNumber(String value) {
    _phoneNumber.value = value;
  }

  set password(String value) {
    _password.value = value;
  }

  set isRembereMeChecked(bool value) {
    _isRembereMeChecked.value = value;
  }
}
