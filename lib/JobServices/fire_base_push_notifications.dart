import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:jobspot/core/navigation_app_route.dart';
import 'package:permission_handler/permission_handler.dart';

import '../JobGlobalclass/global_storage.dart';

@pragma('vm:entry-point')
Future<void> _onHandleBackgroundMessageNotification(
    RemoteMessage? message) async {
  if (message == null) return;
  try {
    NavigationAppRoute.gotoRoute(Get.currentRoute);
  } catch (e, s) {
    print(e);
    print(s);
  }
  print("from on background message notification.");
  print(message.notification?.title);
  print(message.notification?.body);
  print(message.data);
}

Future<void> _onHandleMessageNotification(RemoteMessage? message) async {
  print("the current route: ${Get.currentRoute}");

  try {
    NavigationAppRoute.gotoRoute(Get.currentRoute);
  } catch (e, s) {
    print(e);
    print(s);
  }
}

Future<void> _onDidReceiveBackgroundNotificationResponse(
  NotificationResponse details,
) async {
  final message = RemoteMessage.fromMap(
    jsonDecode(details.payload ?? "{}"),
  );
  print("0#0#0# from on did receive background notification #0#0#0");
  _onHandleMessageNotification(message);
}

const notificationChannel = const AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.',
  // description
  importance: Importance.max,
);

class FirebasePushNotificationService {
  final _firebasePushNotification = FirebaseMessaging.instance;
  final _localNotification = FlutterLocalNotificationsPlugin();

  Future<void> _initPushNotification() async {
    await _firebasePushNotification
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // _firebasePushNotification
    //     .getInitialMessage()
    //     .then(_handleMessageNotification);
    FirebaseMessaging.onMessageOpenedApp.listen(_onHandleMessageNotification);
    FirebaseMessaging.onBackgroundMessage(
        _onHandleBackgroundMessageNotification);
    FirebaseMessaging.onMessage.listen((message) {
      print("#####message notification is received.#######");
      final notification = message.notification;
      if (notification == null) return;
      _localNotification.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            notificationChannel.id,
            notificationChannel.name,
            channelDescription: notificationChannel.description,
            icon: "@drawable/ic_launcher",
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }

  Future<void> _initLocalNotification() async {
    const iosNot = const DarwinInitializationSettings();
    const androidNot =
        const AndroidInitializationSettings("@drawable/ic_launcher");
    const settingNot = InitializationSettings(android: androidNot, iOS: iosNot);
    await _localNotification.initialize(
      settingNot,
      onDidReceiveNotificationResponse: (details) {
        final message = RemoteMessage.fromMap(
          jsonDecode(details.payload ?? "{}"),
        );
        print("#%#%#%#%#from InitializationSettings notification#%#%#%#%#");
        _onHandleMessageNotification(message);
      },
      onDidReceiveBackgroundNotificationResponse:
          _onDidReceiveBackgroundNotificationResponse,
    );
    final platform = _localNotification.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(notificationChannel);
  }

  Future<void> init() async {
    final result = await _firebasePushNotification.requestPermission();
    print(result.authorizationStatus);
    GlobalStorageService.fcmToken = switch (result.authorizationStatus) {
          AuthorizationStatus.authorized =>
            await _firebasePushNotification.getToken(),
          AuthorizationStatus.denied => await _requestedNotification(),
          AuthorizationStatus.notDetermined => await _requestedNotification(),
          AuthorizationStatus.provisional => await _requestedNotification()
        } ??
        "";
    print("fcm token: ${GlobalStorageService.fcmToken}");
    await _initPushNotification();
    await _initLocalNotification();
  }

  Future<String?> _requestedNotification() async {
    final perResult = await Permission.notification.request();
    if (perResult == PermissionStatus.granted)
      return await _firebasePushNotification.getToken();
    else
      return null;
  }
}
