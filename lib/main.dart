import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jobspot/JobGlobalclass/global_storage.dart';
import 'package:jobspot/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/JobServices/app_local_language_services/app_local_language_service.dart';
import 'package:jobspot/JobServices/fire_base_push_notifications.dart';
import 'package:jobspot/JobStringtranslation/traslationstring.dart';
import 'package:jobspot/sippo_custom_widget/gallery_image_widget_components.dart';
import 'package:jobspot/sippo_themes/theme.dart';
import 'package:jobspot/utils/exception_handler_utils.dart';

import 'JobGlobalclass/routes.dart';
import 'firebase_options.dart';
import 'sippo_controller/AuthenticationController/sippo_auth_controller.dart';
import 'sippo_controller/HttpClientController/http_client_controller.dart';

void main() async {
  await GetStorage.init();
  // await ScreenUtil.ensureScreenSize();
  // WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  GlobalStorageService.initService(
    Get.put<GlobalStorageService>(GlobalStorageService()),
  );
  await GlobalStorageService.lunchApp();
  Get.put<LocalLanguageService>(LocalLanguageService());
  if (!kIsWeb) await FirebasePushNotificationService().init();
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
    ImageProviderType;
    // ScreenUtil.init(context, designSize: Size(360.0, 690.0));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: JobstopMyThemes.lightTheme,
      fallbackLocale: GlobalStorageService.savedLanguage.languageLocale,
      // textDirection: TextDirection.rtl,
      initialBinding: BindingsBuilder(() {
        Get.put<InternetConnectionService>(InternetConnectionService());
        Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
        Get.lazyPut<HttpClientController>(
          () => HttpClientController(),
          fenix: true,
        );
      }),
      translations: AppTranslation(),
      locale: GlobalStorageService.savedLanguage.languageLocale,
      initialRoute:
          kIsWeb ? SippoRoutes.userSignupPage : SippoRoutes.splashScreen,
      // initialRoute: ,
      // home: const SippoUserProfessions(),
      getPages: SippoRoutes.routes,
    );
  }
}
