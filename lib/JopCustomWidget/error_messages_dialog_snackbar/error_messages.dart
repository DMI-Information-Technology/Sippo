import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../JobGlobalclass/jobstopimges.dart';
import '../widgets.dart';

void showNoConnectionDialog(){
  Get.dialog(
    CustomAlertDialog(
      imageAsset: JobstopPngImg.noconnection,
      title: 'Connection lost',
      description:
      'connection lost, please check your network settings and try again',
      onConfirm: () {
        Get.back();
      },
    ),
  );
}