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
                  color: Jobstopcolor.primarycolor,
                ),
              ),
              SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
              SettingItemWidget(
                contentPadding: context.fromHeight(CustomStyle.paddingValue2),
                title: 'personal_information'.tr,
                icon: Icon(Icons.person, color: Jobstopcolor.primarycolor),
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
                  color: Jobstopcolor.primarycolor,
                ),
                onTap: () {
                  Get.to(() => const JobUpdatePassword());
                },
              ),
              SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
              SettingItemWidget(
                contentPadding: context.fromHeight(CustomStyle.paddingValue2),
                title: "change_layout".tr,
                icon: Icon(
                  Icons.swap_horiz_rounded,
                  color: Jobstopcolor.primarycolor,
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
                  color: Jobstopcolor.primarycolor,
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
      backgroundColor: Jobstopcolor.white,
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
                      'selectapplicationlayout'.tr,
                      style: dmsbold.copyWith(
                        fontSize: 18,
                        color: Jobstopcolor.grey,
                      ),
                    ),
                  ),
                  Container(
                    height: 0.8,
                    width: MediaQuery.of(context).size.width,
                    color: Jobstopcolor.grey,
                  ),
                  SizedBox(
                    height: context.fromHeight(CustomStyle.xs),
                    child: InkWell(
                      highlightColor: Jobstopcolor.transparent,
                      splashColor: Jobstopcolor.transparent,
                      onTap: () async {
                        final navigator = Navigator.of(context);
                        await Get.updateLocale(const Locale('en', 'US'));
                        navigator.pop();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ltr'.tr,
                            style: dmsregular.copyWith(
                              fontSize: 15,
                              color: Jobstopcolor.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 0.8,
                    width: MediaQuery.of(context).size.width,
                    color: Jobstopcolor.grey,
                  ),
                  SizedBox(
                    height: context.fromHeight(CustomStyle.xs),
                    child: InkWell(
                      highlightColor: Jobstopcolor.transparent,
                      splashColor: Jobstopcolor.transparent,
                      onTap: () async {
                        final navigator = Navigator.of(context);
                        await Get.updateLocale(const Locale('ar', 'ab'));
                        navigator.pop();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'rtl'.tr,
                            style: dmsregular.copyWith(
                                fontSize: 15, color: Jobstopcolor.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 0.8,
                    width: MediaQuery.of(context).size.width,
                    color: Jobstopcolor.grey,
                  ),
                  SizedBox(
                    height: context.fromHeight(CustomStyle.xs),
                    child: InkWell(
                      highlightColor: Jobstopcolor.transparent,
                      splashColor: Jobstopcolor.transparent,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'cancel'.tr,
                            style: dmsregular.copyWith(
                              fontSize: FontSize.title5(context),
                              color: Jobstopcolor.black,
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
        notchColor: Jobstopcolor.primarycolor,
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
                    "logout is failed",
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
