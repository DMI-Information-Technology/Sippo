import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:sippo/JobGlobalclass/global_storage.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/JobGlobalclass/jobstopimges.dart';
import 'package:sippo/JobGlobalclass/media_query_sizes.dart';
import 'package:sippo/JobGlobalclass/routes.dart';
import 'package:sippo/JobGlobalclass/sippo_customstyle.dart';
import 'package:sippo/JobGlobalclass/text_font_size.dart';
import 'package:sippo/core/api_endpoints.dart';
import 'package:sippo/sippo_custom_widget/success_message_widget.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';
import 'package:sippo/sippo_data/delete_profile_repo/delete_profile_repo.dart';
import 'package:sippo/utils/states.dart';

class DeleteAccountConfirmationController extends GetxController {
  final password = TextEditingController();

  String get passwordValue => password.text.trim();
  final _states = States().obs;

  set states(States value) => _states.value = value;

  States get states => _states.value;

  Future<void> deleteProfile(String endpoint, String passwordValue) async {
    print('endpoint: $endpoint, password: $passwordValue');
    final response = await DeleteProfileRepo.deleteProfile(
      endpoint: endpoint,
      password: passwordValue,
    );
    await response.checkStatusResponse(
      onSuccess: (data, statusType) {
        _states.value = states.copyWith(isSuccess: true, message: '');
      },
      onError: (message, statusType) {
        _states.value = states.copyWith(isError: true, message: message);
      },
      onValidateError: (validateError, statusType) {
        _states.value = states.copyWith(
          isError: true,
          message: validateError?.message,
        );
      },
    );
  }

  Future<void> onDeleteProfile() async {
    var endpoint = '';
    if (GlobalStorageService.isUser)
      endpoint = editProfileEndpoint;
    else
      endpoint = companyInfoProfileEndpoint;
    _states.value = States(isLoading: true);
    await deleteProfile(endpoint, passwordValue);
    _states.value = states.copyWith(isLoading: false);
  }
}

class SipppoDeleteAccountConfirmation extends StatefulWidget {
  const SipppoDeleteAccountConfirmation({super.key});

  @override
  State<SipppoDeleteAccountConfirmation> createState() =>
      _SipppoDeleteAccountConfirmationState();
}

class _SipppoDeleteAccountConfirmationState
    extends State<SipppoDeleteAccountConfirmation> {
  final controller = Get.put(DeleteAccountConfirmationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Deletion'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: context.fromHeight(CustomStyle.paddingValue),
          horizontal: context.fromWidth(CustomStyle.paddingValue),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please enter your password to confirm the account deletion.',
              style: dmsmedium.copyWith(
                fontSize: FontSize.paragraph2(context),
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 2,
            ),
            SizedBox(height: context.fromHeight(64)),
            PasswordInputBorderedField(
              hintText: 'Enter Your Password Here...',
              controller: controller.password,
            ),
            SizedBox(height: context.fromHeight(64)),
            Obx(() => CardNotifyMessage.error(
                  state: controller.states,
                  onCancelTap: () => controller.states = States(),
                  bottomSpaceValue: 0.0,
                )),
            Obx(() => Center(
                  child: Visibility(
                    visible: controller.states.isLoading,
                    child: Lottie.asset(
                      JobstopPngImg.loadingProgress,
                      height: context.height / 9,
                    ),
                  ),
                )),
            SizedBox(height: context.fromHeight(64)),
            Text(
              'After confirming the deletion of your account,'
              ' you will lose all your data, and retrieval will not be possible.',
              style: dmsmedium.copyWith(
                fontSize: FontSize.paragraph(context),
                color: Colors.redAccent,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.all(context.fromWidth(CustomStyle.paddingValue)),
          child: CustomButton(
            text: 'continue'.tr,
            onTapped: () {
              Get.dialog(CustomAlertDialog(
                titleColor: Colors.redAccent,
                title: 'Account Deletion',
                confirmBtnColor: Colors.redAccent,
                description: 'Are you sure you want continue the deletion',
                confirmBtnTitle: 'yes'.tr,
                onConfirm: () async {
                  if (Get.isOverlaysOpen) Navigator.pop(context);
                  await controller.onDeleteProfile();
                  if (controller.states.isSuccess) {
                    await GlobalStorageService.removeSavedToken(GetStorage());
                    Get.offAllNamed(SippoRoutes.userLoginPage);
                  }
                },
                onCancel: () {
                  if (Get.isOverlaysOpen) Get.back();
                },
              ));
            },
          )),
    );
  }
}
