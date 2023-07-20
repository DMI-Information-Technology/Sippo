import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SignUpUserController extends GetxController {
  final _fullname = "".obs;

  final _phoneNumber = "".obs;
  final _password = "".obs;
  final _confirmPssword = "".obs;

  String get fullname => _fullname.toString();

  String get confirmPssword => _confirmPssword.toString();

  String get password => _password.toString();

  String get phoneNumber => _phoneNumber.toString();

  set fullname(String value) {
    _fullname.value = value;
  }

  set phoneNumber(String value) {
    _phoneNumber.value = value;
  }

  set password(String value) {
    _password.value = value;
  }

  set confirmPssword(String value) {
    _confirmPssword.value = value;
  }
}
