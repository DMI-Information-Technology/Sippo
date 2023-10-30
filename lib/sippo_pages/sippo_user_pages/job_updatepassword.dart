import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/sippo_custom_widget/ConditionalWidget.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/success_message_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/sippo_data/auth/auth_repo.dart';
import 'package:jobspot/utils/states.dart';
import 'package:jobspot/utils/validating_input.dart';

import '../../JobGlobalclass/jobstopimges.dart';

class ChangePasswordModel {
  final String? currentPassword;
  final String? newPassword;
  final String? confirmPassword;

  const ChangePasswordModel({
    this.currentPassword,
    this.newPassword,
    this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      "current_password": this.currentPassword,
      "password": this.newPassword,
      "password_confirmation": this.confirmPassword,
    };
  }

  @override
  String toString() {
    return 'ChangePasswordModel{currentPassword: $currentPassword, newPassword: $newPassword, confirmPassword: $confirmPassword}';
  }
}

class ValidatePropChangePasswordModel {
  final List<String>? currentPassword;
  final List<String>? newPassword;
  final List<String>? confirmPassword;

  const ValidatePropChangePasswordModel({
    this.currentPassword,
    this.newPassword,
    this.confirmPassword,
  });

  factory ValidatePropChangePasswordModel.fromJson(Map<String, dynamic> json) {
    return ValidatePropChangePasswordModel(
      currentPassword: json["current_password"] != null
          ? List.of(json["current_password"]).map((i) => i.toString()).toList()
          : null,
      newPassword: json["password"] != null
          ? List.of(json["password"]).map((i) => i.toString()).toList()
          : null,
      confirmPassword: json["password_confirmation"] != null
          ? List.of(json["password_confirmation"])
              .map((i) => i.toString())
              .toList()
          : null,
    );
  }

  @override
  String toString() {
    return 'ValidatePropChangePasswordModel{currentPassword: $currentPassword, newPassword: $newPassword, confirmPassword: $confirmPassword}';
  }
//
}

class ChangePasswordController extends GetxController {
  final currentPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final states = States().obs;

  Future<void> changePassword() async {
    final response = await AuthRepo.changePassword(ChangePasswordModel(
      currentPassword: currentPassword.text.trim(),
      newPassword: newPassword.text.trim(),
      confirmPassword: confirmPassword.text.trim(),
    ));
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

class JobUpdatePassword extends StatefulWidget {
  const JobUpdatePassword({Key? key}) : super(key: key);

  @override
  State<JobUpdatePassword> createState() => _JobUpdatePasswordState();
}

class _JobUpdatePasswordState extends State<JobUpdatePassword> {
  final _controller = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.sizeOf(context);
    // double height = size.height;
    // double width = size.width;
    return Scaffold(
      appBar: AppBar(),
      body: BodyWidget(
        isScrollable: true,
        paddingContent: EdgeInsets.symmetric(
          horizontal: context.fromWidth(CustomStyle.paddingValue),
          // vertical: context.fromHeight(CustomStyle.paddingValue),
        ),
        child: Form(
          key: _controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AutoSizeText(
                'Change Password',
                style: dmsbold.copyWith(fontSize: FontSize.title3(context)),
              ),
              Obx(() => ConditionalWidget(
                    _controller.states.value.isLoading,
                    data: _controller.states.value,
                    isLoading: _controller.states.value.isLoading,
                    onLoadingProgress: (context, progress) => Column(
                      children: [
                        SizedBox(height: context.fromHeight(CustomStyle.xxl)),
                        progress
                      ],
                    ),
                  )),
              Obx(() => ConditionalWidget(
                    _controller.states.value.isError,
                    data: _controller.states.value,
                    onLoadingProgress: (context, progress) => Column(
                      children: [
                        SizedBox(height: context.fromHeight(CustomStyle.xxl)),
                        progress
                      ],
                    ),
                    guaranteedBuilder: (context, data) => Column(
                      children: [
                        SizedBox(height: context.fromHeight(CustomStyle.xxl)),
                        CardNotifyMessage.error(
                          state: data,
                          onCancelTap: () {
                            _controller.states.value = _controller.states.value
                                .copyWith(isError: false, message: '');
                          },
                          bottomSpaceValue: 0.0,
                        ),
                      ],
                    ),
                  )),
              SizedBox(height: context.fromHeight(CustomStyle.xxl)),
              SizedBox(
                height: context.fromHeight(CustomStyle.xxxl),
              ),
              AutoSizeText(
                'Current password',
                style: dmsbold.copyWith(fontSize: FontSize.label(context)),
              ),
              PasswordInputBorderedField(
                hintText: 'enter your current password here...',
                validator: (value) => ValidatingInput.validateEmptyField(
                  value,
                  message: 'The current password is required.',
                ),
                controller: _controller.currentPassword,
              ),
              SizedBox(
                height: context.fromHeight(CustomStyle.xxxl),
              ),
              AutoSizeText(
                'New password',
                style: dmsbold.copyWith(fontSize: FontSize.label(context)),
              ),
              PasswordInputBorderedField(
                hintText: 'enter your new password here...',
                validator: ValidatingInput.validatePassword,
                controller: _controller.newPassword,
              ),
              SizedBox(
                height: context.fromHeight(CustomStyle.xxxl),
              ),
              AutoSizeText(
                'Confirm password',
                style: dmsbold.copyWith(fontSize: FontSize.label(context)),
              ),
              PasswordInputBorderedField(
                hintText: 'confirm your confirmation password...',
                validator: ValidatingInput.validatePassword,
                controller: _controller.confirmPassword,
              ),
            ],
          ),
        ),
        paddingBottom: EdgeInsets.all(
          context.fromWidth(CustomStyle.paddingValue),
        ),
        bottomScreen: CustomButton(onTapped: onSaveTapped, text: 'Save'),
      ),
    );
  }

  void onSaveTapped() {
    if (_controller.formKey.currentState?.validate() == true) {
      _controller.onSaveSubmitted().then((_) {
        if (_controller.states.value.isSuccess) {
          Get.dialog(
            CustomAlertDialog(
              imageAsset: JobstopPngImg.successchangepassword,
              title: 'Password changed',
              description: 'Your password has been changed successfully.',
              onConfirm: () {
                if (Get.isOverlaysOpen) Get.back();
              },
            ),
          ).then((_) => Get.back());
        }
      });
    }
  }
}
