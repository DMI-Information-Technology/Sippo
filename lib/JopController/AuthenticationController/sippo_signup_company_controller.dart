import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:jobspot/sippo_data/model/auth_model/company_model.dart';
import 'package:jobspot/sippo_data/model/auth_model/cord_location.dart';

import '../../sippo_data/model/specializations_model/specializations_model.dart';

class SignUpCompanyController extends GetxController {
  static SignUpCompanyController get instance => Get.find();
  final _fullname = "".obs;
  final _phoneNumber = "".obs;
  final _password = "".obs;
  final _confirmPassword = "".obs;
  final _companyAddress = "".obs;
  final _confirmOnPolicy = false.obs;

  final _cordLocation = CordLocation().obs;

  CompanyModel get companyForm => CompanyModel(
        name: fullname,
        phone: phoneNumber,
        password: password,
        passwordConfirmation: confirmPassword,
        longitude: double.parse(
          cordLocation.longitude ?? "0",
        ),
        latitude: double.parse(
          cordLocation.latitude ?? "0",
        ),
        specializations: selectedIdSpecializations,
        city: companyAddress,
      );

  CordLocation get cordLocation => _cordLocation.value;

  void setCordLocation({double? long, double? lat}) {
    _cordLocation.value = _cordLocation.value.copyWith(
      longitude: long.toString(),
      latitude: lat.toString(),
    );
  }

  String get companyAddress => _companyAddress.toString();

  bool get confirmOnPolicy => _confirmOnPolicy.isTrue;

  String get fullname => _fullname.toString();

  String get confirmPassword => _confirmPassword.toString();

  String get password => _password.toString();

  String get phoneNumber => _phoneNumber.toString();

  final _companySpecializations = [
    SpecializationModel(id: 12, name: 'Item 2'),
    SpecializationModel(id: 15, name: 'Item 3'),
    SpecializationModel(id: 13, name: 'Item 4'),
    SpecializationModel(id: 14, name: 'Item 5'),
  ].obs;

  void set companySpecializations(List<SpecializationModel> value) {
    _companySpecializations.assignAll(value);
  }

  final _selectedSpecialIndices = <int>[].obs;

  List<String> get companySpecializationsName =>
      _companySpecializations.isNotEmpty
          ? _companySpecializations.toList().map((e) => e.name).toList()
          : [];

  List<int> get selectedIdSpecializations => _companySpecializations.isNotEmpty
      ? selectedIndices.map((e) => _companySpecializations[e].id).toList()
      : [];

  List<int> get selectedIndices => _selectedSpecialIndices.toList();

  void toggleSpecial(int index) {
    if (_selectedSpecialIndices.contains(index))
      _selectedSpecialIndices.remove(index);
    else
      _selectedSpecialIndices.add(index);
  }

  bool isSpecialSelected(int index) {
    return _selectedSpecialIndices.contains(index);
  }

  void toggleConfirmPolicy() {
    _confirmOnPolicy.value = !_confirmOnPolicy.value;
  }

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

  void set confirmOnPolicy(bool value) {
    _confirmOnPolicy.value = value;
  }

  void set companyAddress(String value) {
    _companyAddress.value = value;
  }
}
