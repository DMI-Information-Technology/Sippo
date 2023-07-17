import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobStringtranslation/traslationstring.dart';
import 'package:jobspot/JobThemes/theme.dart';
import 'package:jobspot/JobThemes/themecontroller.dart';

import 'Jobstoppages/Authentication/jobstop_splash.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
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
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themedata.isdark ? JobstopMyThemes.darkTheme : JobstopMyThemes.lightTheme,
        fallbackLocale: const Locale('en', 'US'),
        translations: Apptranslation(),
        locale: const Locale('en', 'US'),
        home: const JobstopSplash()
    );
  }
}
