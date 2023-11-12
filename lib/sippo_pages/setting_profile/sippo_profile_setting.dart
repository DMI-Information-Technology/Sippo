import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/global_storage.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/JobServices/app_local_language_services/app_local_language_service.dart';
import 'package:jobspot/custom_app_controller/switch_status_controller.dart';
import 'package:jobspot/sippo_controller/AuthenticationController/sippo_auth_controller.dart';
import 'package:jobspot/sippo_custom_widget/confirmation_bottom_sheet.dart';
import 'package:jobspot/sippo_custom_widget/container_bottom_sheet_widget.dart';
import 'package:jobspot/sippo_custom_widget/loading_view_widgets/loading_scaffold.dart';
import 'package:jobspot/sippo_custom_widget/setting_item_widget.dart';
import 'package:jobspot/sippo_pages/setting_profile/job_updatepassword.dart';
import 'package:jobspot/utils/app_use.dart';
import 'package:jobspot/utils/states.dart';

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
                  _showbottomsheet(context);
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
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  void _showbottomsheet(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    showModalBottomSheet(
      backgroundColor: SippoColor.white,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              decoration: BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
              height: height / 4,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: height / 96,
                      bottom: height / 76,
                    ),
                    child: Text(
                      'select_view_language'.tr,
                      style: dmsbold.copyWith(
                        fontSize: 18,
                        color: SippoColor.grey,
                      ),
                    ),
                  ),
                  Container(
                    height: 0.8,
                    width: MediaQuery.of(context).size.width,
                    color: SippoColor.grey,
                  ),
                  SizedBox(
                    height: context.fromHeight(CustomStyle.xs),
                    child: InkWell(
                      highlightColor: SippoColor.transparent,
                      splashColor: SippoColor.transparent,
                      onTap: () async {
                        Navigator.pop(context);

                        await LocalLanguageService.changeLocale(
                          LocaleLanguageType.english,
                        );
                        await GlobalStorageService.changeLanguage(
                            LocaleLanguageType.english);
                      },
                      child: Center(
                        child: Text(
                          'english_lang'.tr,
                          style: dmsregular.copyWith(
                            fontSize: 15,
                            color: SippoColor.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ColoredBox(
                    color: Colors.grey,
                    child: SizedBox(
                      height: 0.8,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  SizedBox(
                    height: context.fromHeight(CustomStyle.xs),
                    child: InkWell(
                      highlightColor: SippoColor.transparent,
                      splashColor: SippoColor.transparent,
                      onTap: () async {
                        Navigator.pop(context);
                        await LocalLanguageService.changeLocale(
                          LocaleLanguageType.arabic,
                        );
                        await GlobalStorageService.changeLanguage(
                          LocaleLanguageType.arabic,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'arabic_lang'.tr,
                            style: dmsregular.copyWith(
                                fontSize: 15, color: SippoColor.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ColoredBox(
                    color: SippoColor.grey,
                    child: SizedBox(
                      height: 0.8,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  SizedBox(
                    height: context.fromHeight(CustomStyle.xs),
                    child: InkWell(
                      highlightColor: SippoColor.transparent,
                      splashColor: SippoColor.transparent,
                      onTap: () => Navigator.pop(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'cancel'.tr,
                            style: dmsregular.copyWith(
                              fontSize: FontSize.title5(context),
                              color: SippoColor.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
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
                  switch (GlobalStorageService.appUse) {
                    case AppUsingType.user:
                      Get.offAllNamed(SippoRoutes.userLoginPage);
                    case AppUsingType.company:
                      Get.offAllNamed(SippoRoutes.sippoCompanyLogin);
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
