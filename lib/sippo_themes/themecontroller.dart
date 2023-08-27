import 'package:get/get.dart';
import 'package:jobspot/sippo_themes/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../JobGlobalclass/jobstopprefname.dart';

class JobstopThemecontroler extends GetxController {
  @override
  void onInit() {
    SharedPreferences.getInstance().then((value) {
      isdark = value.getBool(isDarkMode) ?? false;
    });
    update();
    super.onInit();
  }

  bool isdark = false;

  Future<void> changeThem(state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isdark = prefs.getBool(isDarkMode) ?? true;
    isdark = !isdark;

    if (state == true) {
      Get.changeTheme(JobstopMyThemes.darkTheme);
      isdark = true;
    } else {
      Get.changeTheme(JobstopMyThemes.lightTheme);
      isdark = false;
    }
    update();
  }
}
