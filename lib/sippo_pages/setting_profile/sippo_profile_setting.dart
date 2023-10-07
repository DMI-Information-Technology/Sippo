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
import 'package:jobspot/utils/app_use.dart';

import '../../JopController/AuthenticationController/sippo_auth_controller.dart';
import '../../sippo_custom_widget/confirmation_bottom_sheet.dart';
import '../../sippo_custom_widget/container_bottom_sheet_widget.dart';
import '../../sippo_custom_widget/setting_item_widget.dart';
import '../../sippo_themes/themecontroller.dart';
import '../sippo_user_pages/job_updatepassword.dart';

class SippoProfileSetting extends StatefulWidget {
  const SippoProfileSetting({Key? key}) : super(key: key);

  @override
  State<SippoProfileSetting> createState() => _SippoProfileSettingState();
}

class _SippoProfileSettingState extends State<SippoProfileSetting> {
  final themedata = Get.put(JobstopThemecontroler());
  final AuthController authController = AuthController.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  color: themedata.isdark
                      ? Jobstopcolor.white
                      : Jobstopcolor.primarycolor,
                ),
              ),
              SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
              SettingItemWidget(
                contentPadding: context.fromHeight(CustomStyle.paddingValue2),
                title: 'personal_information'.tr,
                icon: Icon(Icons.person, color: Jobstopcolor.primarycolor),
                onTap: () {},
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
      backgroundColor:
          themedata.isdark ? Jobstopcolor.black : Jobstopcolor.white,
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
                              color: themedata.isdark
                                  ? Jobstopcolor.white
                                  : Jobstopcolor.black,
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
                                fontSize: 15,
                                color: themedata.isdark
                                    ? Jobstopcolor.white
                                    : Jobstopcolor.black),
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
              await authController.logout();
              if (authController.states.isError) {
                Get.snackbar(
                  "logout is failed",
                  authController.states.message ?? "",
                  backgroundColor: Colors.red,
                );
                authController.resetAllAuthStates();
              } else if (authController.states.isSuccess) {
                authController.resetAllAuthStates();
                if (GlobalStorageService.appUse == AppUsingType.user)
                  Get.offAllNamed(SippoRoutes.userLoginPage);
                else
                  Get.offAllNamed(SippoRoutes.sippoCompanyLogin);
              }
            },
            onUndo: () => Get.back(),
          )
        ],
      ),
    );
  }
}
