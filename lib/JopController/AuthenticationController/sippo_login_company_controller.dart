import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:jobspot/sippo_data/model/auth_model/company_model.dart';

class LoginCompanyController extends GetxController {
  final _phoneNumber = "".obs;
  final _password = "".obs;
  final _isRememberMeChecked = false.obs;
  CompanyModel get companyForm =>
      CompanyModel(phone: phoneNumber, password: password);

  bool get isRememberMeChecked => _isRememberMeChecked.isTrue;

  String get password => _password.toString();

  String get phoneNumber => _phoneNumber.toString();

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
