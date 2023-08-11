import 'package:get/get.dart';

class EditAddSkillsController extends GetxController {
  final _isChangeSkills = false.obs;

  bool get isChangeSkills => _isChangeSkills.isTrue;

  set isChangeSkills(bool value) {
    _isChangeSkills.value = value;
  }
}
