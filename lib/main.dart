import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jobspot/JobStringtranslation/traslationstring.dart';
import 'package:jobspot/JobThemes/theme.dart';
import 'package:jobspot/JobThemes/themecontroller.dart';
import 'package:jobspot/JobGlobalclass/global_storage.dart';
import 'JobGlobalclass/routes.dart';
import 'JopController/ConnectivityController/internet_connection_controller.dart';
import 'firebase_options.dart';

void main() async {
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await lunchApp();
  await GlobalStorage.checkSavedToken();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

Future<void> lunchApp() async {
  final check = await GlobalStorage.isAppOpenBefore();
  if (check == null) {
    await GlobalStorage.appIsLunched();
  } else {
    GlobalStorage.isAppLunchFirstTime = false;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final themedata = Get.put(JobstopThemecontroler());

  @override
  Widget build(BuildContext context) {
    Get.put(InternetConnectionController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themedata.isdark
          ? JobstopMyThemes.darkTheme
          : JobstopMyThemes.lightTheme,
      fallbackLocale: const Locale('en', 'US'),
      translations: Apptranslation(),
      locale: const Locale('en', 'US'),
      initialRoute: SippoRoutesPages.homepage,
      getPages: SippoRoutesPages.routes,
    );
  }
}
