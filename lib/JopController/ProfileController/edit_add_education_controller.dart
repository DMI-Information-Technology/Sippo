import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jobspot/JopController/ProfileController/profile_user_controller.dart';

import '../../utils/states.dart';

class EditAddEducationController extends GetxController {
  static EditAddEducationController get instance => Get.find();
  final levelEduCon = TextEditingController();
  final institutionCon = TextEditingController();
  final fieldStudyCon = TextEditingController();
  final startDateCon = TextEditingController();
  final endDateCon = TextEditingController();
  final description = TextEditingController();
  final _isMyLastDegree = false.obs;

  final _states = States().obs;

  States get states => _states.value;

  final _profileUserController = ProfileUserController.instance;

  // <> get educationForm => <>(  );

  // final Rx<?> _education = ().obs;

  bool get isEditing => _profileUserController.editingId != -1;

  bool get isMyLastDegree => _isMyLastDegree.isTrue;

  void set isMyLastDegree(bool value) {
    _isMyLastDegree.value = value;
  }

  @override
  void onClose() {
    levelEduCon.dispose();
    institutionCon.dispose();
    fieldStudyCon.dispose();
    startDateCon.dispose();
    endDateCon.dispose();
    description.dispose();
    _profileUserController.editingId = -1;
    super.onClose();
  }
}
