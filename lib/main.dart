import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jobspot/JobGlobalclass/global_storage.dart';
import 'package:jobspot/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/JobServices/fire_base_push_notifications.dart';
import 'package:jobspot/JobStringtranslation/traslationstring.dart';
import 'package:jobspot/sippo_themes/theme.dart';
import 'package:jobspot/utils/exception_handler_utils.dart';

import 'JobGlobalclass/routes.dart';
import 'JopController/AuthenticationController/sippo_auth_controller.dart';
import 'JopController/HttpClientController/http_client_controller.dart';
import 'firebase_options.dart';

void main() async {
  await GetStorage.init();
  // await ScreenUtil.ensureScreenSize();
  // WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put<GlobalStorageService>(GlobalStorageService());
  await GlobalStorageService.lunchApp();

  await FirebasePushNotificationService().init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  FlutterError.onError = ExceptionHandlerUtils.onError;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init(context, designSize: Size(360.0, 690.0));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: JobstopMyThemes.lightTheme,
      fallbackLocale: const Locale('en', 'US'),
      initialBinding: BindingsBuilder(() {
        Get.put<InternetConnectionService>(InternetConnectionService());
        Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
        Get.lazyPut<HttpClientController>(
          () => HttpClientController(),
          fenix: true,
        );
      }),
      translations: Apptranslation(),
      locale: const Locale('en', 'US'),
      initialRoute: SippoRoutes.splashScreen,
      // initialRoute: SippoRoutes.identityverification,
      // home: const JobNotification(),
      getPages: SippoRoutes.routes,
    );
  }
}
