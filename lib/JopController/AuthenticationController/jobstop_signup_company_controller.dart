import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SignUpCompanyController extends GetxController {
  final _fullname = "".obs;

  final _phoneNumber = "".obs;
  final _password = "".obs;
  final _confirmPssword = "".obs;
  final _companyAddress = "".obs;
  final _confirmOnPolicy = false.obs;

  final List<String> _companySpecializations = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 6',
    'Item 7',
    'Item 8',
    'Item 9',
    'Item 10',
    'Item 11',
    'Item 12',
    'Item 14',
    'Item 15',
    'Item 16',
    'Item 17',
    'Item 18',
  ];

  final List<int> _selectedSpecialIndices = <int>[].obs;

  String get companyAddress => _companyAddress.toString();

  bool get confirmOnPolicy => _confirmOnPolicy.isTrue;

  String get fullname => _fullname.toString();

  String get confirmPssword => _confirmPssword.toString();

  String get password => _password.toString();

  String get phoneNumber => _phoneNumber.toString();

  List<String> get companySpecializations => _companySpecializations;

  List<int> get selectedIndices => _selectedSpecialIndices;

  void toggleSpecial(int index) {
    if (_selectedSpecialIndices.contains(index)) {
      _selectedSpecialIndices.remove(index);
    } else {
      _selectedSpecialIndices.add(index);
    }
  }

  void toggleConfirmPolicy() {
    _confirmOnPolicy.value = !_confirmOnPolicy.value;
  }

  bool isSpecialSelected(int index) {
    return _selectedSpecialIndices.contains(index);
  }

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
