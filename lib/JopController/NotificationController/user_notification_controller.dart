import 'package:get/get.dart';
import 'dart:math' as math;
import '../../JobGlobalclass/jobstopimges.dart';
import '../../sippo_data/model/notification/job_application_model.dart';

class UserNotificationController extends GetxController {
  static UserNotificationController get instance => Get.find();
  static final list = [
    JobstopPngImg.googlelogo,
    JobstopPngImg.dribbblelogo,
    JobstopPngImg.twitterlogo,
    JobstopPngImg.applelogo,
    JobstopPngImg.facebooklogo
  ];
  final _generalNotifications = list
      .map(
        (e) => NotificationModel(
          title: "Application sent",
          imagePath: e,
          description:
              "Applications for Google companies have entered for company review",
          arriveTime: "25 minutes ago",
          applicationStatus: null,
        ),
      )
      .toList()
      .obs;

  List<NotificationModel> get generalNotifications =>
      _generalNotifications.toList();
  final _applicationNotifications = list
      .map(
        (e) => NotificationModel(
          title: "Application sent",
          imagePath: e,
          description:
              "Applications for Google companies have entered for company review",
          arriveTime: "25 minutes ago",
          applicationStatus:
              ApplicationStatusType.values[math.Random().nextInt(3)],
        ),
      )
      .toList()
      .obs;

  List<NotificationModel> get applicationNotifications =>
      _applicationNotifications.toList();
  final _selectedBottomOption = (-1).obs;

  int get selectedBottomOption => _selectedBottomOption.toInt();

  bool isMatchOptionOfIndex(int index) => selectedBottomOption == index;

  void set selectedBottomOption(int value) =>
      _selectedBottomOption.value = value;
  final _selectedNotification = (-1).obs;

  int get selectedNotification => _selectedNotification.toInt();

  void set selectedNotification(int value) =>
      _selectedNotification.value = value;
}
