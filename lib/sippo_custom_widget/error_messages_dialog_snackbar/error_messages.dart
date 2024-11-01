import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/jobstopimges.dart';
import 'package:sippo/sippo_custom_widget/terms_conditions_privacy_policy.dart';
import 'package:sippo/utils/helper.dart';

import '../../JobGlobalclass/jobstopcolor.dart';
import '../../JobGlobalclass/sippo_customstyle.dart';
import '../widgets.dart';

void showNoConnectionSnackbar() {
  Get.snackbar(
    icon: Icon(Icons.signal_wifi_statusbar_connected_no_internet_4_rounded),
    'no_connection_title'.tr,
    'no_connection_message'.tr,
    backgroundColor: SippoColor.backgroudHome,
    boxShadows: [boxShadow],
  );
}
void showNotAcceptedTermsAndConditionsDialog(double paddingValue){
  Get.dialog(
    Dialog(
      insetPadding: EdgeInsets.all(
        paddingValue
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: const TermsConditionsWidget(),
      ),
    ),
  );
}
void showNotSubscriptionAlert(phoneNumber) {
  Get.dialog(
    CustomAlertDialog.verticalButtons(
      imageAsset: JobstopPngImg.noSubs,
      title: 'not_subscribed'.tr,
      description: "subscribe_platform_message".tr,
      confirmBtnTitle: 'contact_whatsApp'.tr,
      onConfirm: () {
        final context = Get.overlayContext;
        if (context != null) {
          Navigator.pop(context);
        } else {
          try {
            Get.back();
          } catch (e, s) {
            print(e);
            print(s);
          }
        }
        openWhatsapp(phoneNumber);
      },
      onCancel: () {
        final context = Get.overlayContext;
        if (context != null) {
          Navigator.pop(context);
        } else {
          try {
            Get.back();
          } catch (e, s) {
            print(e);
            print(s);
          }
        }
      },
    ),
  );
}

void showNoConnectionDialog() {
  Get.dialog(
    CustomAlertDialog(
      imageAsset: JobstopPngImg.noconnection,
      title: 'contact_lost_title'.tr,
      description: 'contact_lost_message'.tr,
      onConfirm: () {
        final context = Get.overlayContext;
        if (context != null) {
          Navigator.pop(context);
        } else {
          try {
            Get.back();
          } catch (e, s) {
            print(e);
            print(s);
          }
        }
      },
    ),
  );
}

void showCustomSnackBar(String title, String description, {Widget? icon}) {
  Get.snackbar(
    icon: icon,
    title,
    description,
    backgroundColor: SippoColor.backgroudHome,
    boxShadows: [boxShadow],
  );
}
