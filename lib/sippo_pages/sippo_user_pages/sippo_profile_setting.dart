import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/JobThemes/themecontroller.dart';
import 'package:jobspot/JopCustomWidget/widgets.dart';
import 'package:jobspot/utils/app_use.dart';
import 'package:jobspot/JobGlobalclass/global_storage.dart';
import '../../JopController/AuthenticationController/sippo_auth_controller.dart';
import '../../JopCustomWidget/setting_item_widget.dart';
import 'job_updatepassword.dart';

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
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width / 26, vertical: height / 96),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Settings",
                style: dmsbold.copyWith(
                  fontSize: FontSize.titleFontSize2(context),
                  color: themedata.isdark
                      ? Jobstopcolor.white
                      : Jobstopcolor.primarycolor,
                ),
              ),
              SizedBox(height: height / 26),
              SettingItemWidget(
                title: 'Personal Information',
                icon: Icon(Icons.person, color: Jobstopcolor.primarycolor),
                onTap: () {},
              ),
              SizedBox(
                height: height / 46,
              ),
              SettingItemWidget(
                title: "Change Password",
                icon: Icon(
                  Icons.logout,
                  color: Jobstopcolor.primarycolor,
                ),
                onTap: () {
                  Get.to(() => const JobUpdatePassword());
                },
              ),
              SizedBox(
                height: height / 46,
              ),
              SettingItemWidget(
                title: "Change layout",
                icon: Icon(
                  Icons.swap_horiz_rounded,
                  color: Jobstopcolor.primarycolor,
                ),
                onTap: () {
                  _showbottomsheet(context);
                },
              ),
              SizedBox(
                height: height / 46,
              ),
              SettingItemWidget(
                title: "Logout",
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
                    child: Text('selectapplicationlayout'.tr,
                        style: dmsbold.copyWith(
                            fontSize: 18, color: Jobstopcolor.grey)),
                  ),
                  Container(
                    height: 0.8,
                    width: MediaQuery.of(context).size.width,
                    color: Jobstopcolor.grey,
                  ),
                  SizedBox(
                    height: height / 16,
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
                    height: height / 16,
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
                    height: height / 16,
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
                                fontSize: 15,
                                color: themedata.isdark
                                    ? Jobstopcolor.white
                                    : Jobstopcolor.black),
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
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    showModalBottomSheet(
      context: context,
      backgroundColor: Jobstopcolor.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Jobstopcolor.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15)),
          ),
          height: height / 3,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width / 26, vertical: height / 66),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: height / 500,
                  width: width / 8,
                  decoration: BoxDecoration(
                    color: Jobstopcolor.primarycolor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                SizedBox(
                  height: height / 26,
                ),
                Text(
                  "Log out",
                  style: dmsbold.copyWith(
                      fontSize: FontSize.titleFontSize4(context),
                      color: Jobstopcolor.primarycolor),
                ),
                SizedBox(
                  height: height / 100,
                ),
                Text(
                  "Are you sure you want to leave?",
                  style: dmsregular.copyWith(
                      fontSize: FontSize.paragraphFontSize3(context),
                      color: Jobstopcolor.darkgrey),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: height / 26,
                ),
                CustomButton(
                  onTappeed: () async {
                    await authController.logout();
                    if (GlobalStorage.appUse == AppUsingType.user)
                      Get.offAllNamed(SippoRoutesPages.loginpage);
                    else
                      Get.offAllNamed(SippoRoutesPages.sippoCompanyLogin);
                  },
                  text: "Confirm",
                ),
                SizedBox(height: height / 56),
                CustomButton(
                  onTappeed: () => Get.back(),
                  backgroundColor: Jobstopcolor.lightprimary,
                  text: "Undo",
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
