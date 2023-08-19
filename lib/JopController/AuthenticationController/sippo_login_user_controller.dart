import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../sippo_data/model/auth_model/user_model.dart';

class LoginUserController extends GetxController {
  final _phoneNumber = "".obs;
  final _password = "".obs;
  final _isRememberMeChecked = false.obs;

  bool get isRememberMeChecked => _isRememberMeChecked.isTrue;

  String get password => _password.toString();

  String get phoneNumber => _phoneNumber.toString();

  UserModel get userForm =>
      UserModel(phone: phoneNumber, password: password);

  set phoneNumber(String value) {
    _phoneNumber.value = value;
  }

  set password(String value) {
    _password.value = value;
  }

  set isRememberMeChecked(bool value) {
    _isRememberMeChecked.value = value;
  }
}
