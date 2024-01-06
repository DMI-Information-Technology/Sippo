import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/global_storage.dart';
import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/JobGlobalclass/media_query_sizes.dart';
import 'package:sippo/JobGlobalclass/routes.dart';
import 'package:sippo/JobGlobalclass/sippo_customstyle.dart';
import 'package:sippo/JobGlobalclass/text_font_size.dart';
import 'package:sippo/JobServices/app_local_language_services/app_local_language_service.dart';
import 'package:sippo/custom_app_controller/switch_status_controller.dart';
import 'package:sippo/sippo_controller/AuthenticationController/sippo_auth_controller.dart';
import 'package:sippo/sippo_custom_widget/confirmation_bottom_sheet.dart';
import 'package:sippo/sippo_custom_widget/container_bottom_sheet_widget.dart';
import 'package:sippo/sippo_custom_widget/loading_view_widgets/loading_scaffold.dart';
import 'package:sippo/sippo_custom_widget/rounded_border_radius_card_widget.dart';
import 'package:sippo/sippo_custom_widget/setting_item_widget.dart';
import 'package:sippo/sippo_pages/setting_profile/job_updatepassword.dart';
import 'package:sippo/utils/app_use.dart';
import 'package:sippo/utils/states.dart';

import 'sippo_delete_account_confirmation.dart';

class SippoProfileSetting extends StatefulWidget {
  const SippoProfileSetting({Key? key}) : super(key: key);

  @override
  State<SippoProfileSetting> createState() => _SippoProfileSettingState();
}

class _SippoProfileSettingState extends State<SippoProfileSetting> {
  final AuthController authController = AuthController.instance;
  StreamSubscription<States>? _subscription;
  final loadingOverlay = SwitchStatusController();

  @override
  void initState() {
    super.initState();
    _subscription = authController.addListenerStates((value) {
      if (value.isLoading) {
        loadingOverlay.start();
      } else {
        loadingOverlay.pause();
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    loadingOverlay.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScaffold(
      controller: loadingOverlay,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.fromWidth(CustomStyle.paddingValue),
            vertical: context.fromWidth(CustomStyle.huge),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                'settings'.tr,
                style: dmsbold.copyWith(
                  fontSize: FontSize.title2(context),
                  color: SippoColor.primarycolor,
                ),
              ),
              SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
              SettingItemWidget(
                contentPadding: context.fromHeight(CustomStyle.paddingValue2),
                title: 'personal_information'.tr,
                icon: Icon(Icons.person, color: SippoColor.primarycolor),
                onTap: () {
                  switch (GlobalStorageService.appUse) {
                    case AppUsingType.user:
                      Get.toNamed(SippoRoutes.editUserProfile);
                    case AppUsingType.company:
                      Get.toNamed(SippoRoutes.editCompanyProfile);
                    case AppUsingType.guest:
                  }
                },
              ),
              SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
              SettingItemWidget(
                contentPadding: context.fromHeight(CustomStyle.paddingValue2),
                title: "change_password".tr,
                icon: Icon(
                  Icons.password,
                  color: SippoColor.primarycolor,
                ),
                onTap: () {
                  Get.to(() => const JobUpdatePassword());
                },
              ),
              SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
              SettingItemWidget(
                contentPadding: context.fromHeight(CustomStyle.paddingValue2),
                title: "change_language".tr,
                icon: Icon(
                  Icons.swap_horiz_rounded,
                  color: SippoColor.primarycolor,
                ),
                onTap: () {
                  LocalLanguageService.showChangeLanguageBottomSheet(context);
                },
              ),
              SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
              SettingItemWidget(
                contentPadding: context.fromHeight(CustomStyle.paddingValue2),
                title: "Logout".tr,
                icon: Icon(
                  Icons.logout,
                  color: SippoColor.primarycolor,
                ),
                onTap: () {
                  _showLogoutBottomSheet(context);
                },
              ),
              SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
          height: context.height / 12,
          width: context.width,
          padding: EdgeInsets.all(context.width / 36),
          child: InkWell(
            onTap: () {
              Get.to(() => const SipppoDeleteAccountConfirmation());
            },
            child: RoundedBorderRadiusCardWidget(
              child: Center(
                child: Text(
                  'Delete Account',
                  style: dmsbold.copyWith(color: Colors.white),
                ),
              ),
              color: Colors.redAccent,
            ),
          )),
      backgroundColor: Colors.white,
    );
  }

  void _showLogoutBottomSheet(BuildContext context) {
    Get.bottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      ContainerBottomSheetWidget(
        notchColor: SippoColor.primarycolor,
        children: [
          ConfirmationBottomSheet(
            title: "Logout".tr,
            description: "are_you_sure_leave".tr,
            confirmTitle: "Logout".tr,
            undoTitle: "undo".tr,
            onConfirm: () async {
              Navigator.pop(context);

              authController.logout().then((_) {
                if (authController.states.isError) {
                  Get.snackbar(
                    "logout_field_message".tr,
                    authController.states.message ?? "",
                    backgroundColor: Colors.red,
                  );
                  authController.resetStates();
                } else if (authController.states.isSuccess) {
                  authController.resetStates();
                  final appUse = GlobalStorageService.appUse;
                  authController.logoutDone();
                  switch (appUse) {
                    case AppUsingType.user:
                      Get.offAllNamed(SippoRoutes.userLoginPage);
                    case AppUsingType.company:
                      Get.offAllNamed(SippoRoutes.sippoCompanyLogin);
                    case AppUsingType.guest:
                  }
                }
              });
            },
            onUndo: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }
}
