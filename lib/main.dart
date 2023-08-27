import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jobspot/JobGlobalclass/global_storage.dart';
import 'package:jobspot/JobStringtranslation/traslationstring.dart';
import 'package:jobspot/sippo_themes/theme.dart';

import 'JobGlobalclass/routes.dart';
import 'JopController/AuthenticationController/sippo_auth_controller.dart';
import 'JopController/ConnectivityController/internet_connection_controller.dart';
import 'JopController/HttpClientController/http_client_controller.dart';
import 'firebase_options.dart';

void main() async {
  await GetStorage.init();
  await ScreenUtil.ensureScreenSize();
  // WidgetsFlutterBinding.ensureInitialized();
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
  if (!check) {
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(360.0, 690.0));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: JobstopMyThemes.lightTheme,
      fallbackLocale: const Locale('en', 'US'),
      initialBinding: BindingsBuilder(() {
        Get.lazyPut<InternetConnectionController>(
            () => InternetConnectionController(),
            fenix: true);
        Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
        Get.lazyPut<HttpClientController>(() => HttpClientController(),
            fenix: true);
      }),
      translations: Apptranslation(),
      locale: const Locale('en', 'US'),
      initialRoute: SippoRoutes.homepage,
      // initialRoute: SippoRoutes.identityverification,
      // home: const JobNotification(),
      getPages: SippoRoutes.routes,
    );
  }
}
