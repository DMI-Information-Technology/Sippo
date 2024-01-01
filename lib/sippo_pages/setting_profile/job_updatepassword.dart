import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/JobGlobalclass/jobstopimges.dart';
import 'package:sippo/JobGlobalclass/media_query_sizes.dart';
import 'package:sippo/JobGlobalclass/sippo_customstyle.dart';
import 'package:sippo/JobGlobalclass/text_font_size.dart';
import 'package:sippo/sippo_controller/sippo_settings_controller/change_password_controller.dart';
import 'package:sippo/sippo_custom_widget/ConditionalWidget.dart';
import 'package:sippo/sippo_custom_widget/body_widget.dart';
import 'package:sippo/sippo_custom_widget/success_message_widget.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';
import 'package:sippo/utils/validating_input.dart';

class JobUpdatePassword extends StatefulWidget {
  const JobUpdatePassword({Key? key}) : super(key: key);

  @override
  State<JobUpdatePassword> createState() => _JobUpdatePasswordState();
}

class _JobUpdatePasswordState extends State<JobUpdatePassword> {
  final _controller = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
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
                'change_password'.tr,
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
                'current_password'.tr,
                style: dmsbold.copyWith(fontSize: FontSize.label(context)),
              ),
              PasswordInputBorderedField(
                hintText: 'hint_text_current_password'.tr,
                validator: (value) => ValidatingInput.validateEmptyField(
                  value,
                  message: 'current_password_is_req'.tr,
                ),
                controller: _controller.currentPassword,
              ),
              SizedBox(
                height: context.fromHeight(CustomStyle.xxxl),
              ),
              AutoSizeText(
                'new_password'.tr,
                style: dmsbold.copyWith(fontSize: FontSize.label(context)),
              ),
              PasswordInputBorderedField(
                hintText: 'hint_text_new_password'.tr,
                validator: ValidatingInput.validatePassword,
                controller: _controller.newPassword,
              ),
              SizedBox(
                height: context.fromHeight(CustomStyle.xxxl),
              ),
              AutoSizeText(
                'confirm_password'.tr,
                style: dmsbold.copyWith(fontSize: FontSize.label(context)),
              ),
              PasswordInputBorderedField(
                hintText: 'hint_text_confirm_password'.tr,
                validator: ValidatingInput.validatePassword,
                controller: _controller.confirmPassword,
              ),
            ],
          ),
        ),
        paddingBottom: EdgeInsets.all(
          context.fromWidth(CustomStyle.paddingValue),
        ),
        bottomScreen: CustomButton(onTapped: onSaveTapped, text: 'save'.tr),
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
              title: 'password_changed'.tr,
              description: 'message_password_changed'.tr,
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
