import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../sippo_data/model/auth_model/user_model.dart';

class SignUpUserController extends GetxController {
  final _fullname = "".obs;
  final _phoneNumber = "".obs;
  final _password = "".obs;
  final _confirmPassword = "".obs;

  String get fullname => _fullname.toString();

  String get confirmPassword => _confirmPassword.toString();

  String get password => _password.toString();

  String get phoneNumber => _phoneNumber.toString();

  UserModel get userForm => UserModel(
        name: fullname,
        phone: phoneNumber,
        password: password,
        passwordConfirmation: confirmPassword,
      );

  void set fullname(String value) {
    _fullname.value = value;
  }

  void set phoneNumber(String value) {
    _phoneNumber.value = value;
  }

  void set password(String value) {
    _password.value = value;
  }

  void set confirmPassword(String value) {
    _confirmPassword.value = value;
  }
}
