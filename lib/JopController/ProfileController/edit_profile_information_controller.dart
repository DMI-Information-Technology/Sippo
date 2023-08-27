

import 'package:get/get.dart';

class EditProfileInformationController extends GetxController {
  final _profileImagePath = "".obs;


  String get profileImagePath => _profileImagePath.toString().trim();

  void set profileImagePath(String? value) {
    _profileImagePath.value = value ?? "";
  }
}
