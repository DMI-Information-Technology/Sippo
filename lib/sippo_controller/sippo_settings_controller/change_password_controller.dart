import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/sippo_data/auth/auth_repo.dart';
import 'package:jobspot/sippo_data/model/settings_model/change_password_model.dart';
import 'package:jobspot/utils/states.dart';

class ChangePasswordController extends GetxController {
  final currentPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final states = States().obs;

  ChangePasswordModel get form => ChangePasswordModel(
    currentPassword: currentPassword.text.trim(),
    newPassword: newPassword.text.trim(),
    confirmPassword: confirmPassword.text.trim(),
  );

  Future<void> changePassword() async {
    final response = await AuthRepo.changePassword(form);
    await response?.checkStatusResponse(
      onSuccess: (data, _) {
        states.value = States(isSuccess: true);
      },
      onValidateError: (validateError, _) {
        states.value = States(isError: true, message: validateError?.message);
      },
      onError: (message, _) {
        states.value = States(isError: true, message: message);
      },
    );
  }

  Future<void> onSaveSubmitted() async {
    if (InternetConnectionService.instance.isNotConnected) return;
    if (states.value.isLoading) return;
    states.value = States(isLoading: true);
    await changePassword();
    states.value = states.value.copyWith(isLoading: false);
  }
}
