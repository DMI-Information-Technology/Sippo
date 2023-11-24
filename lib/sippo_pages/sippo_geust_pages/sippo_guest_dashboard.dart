import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/core/navigation_app_route.dart';
import 'package:jobspot/sippo_controller/NotificationController/user_notification_application/user_notification_controller.dart';
import 'package:jobspot/sippo_controller/dashboards_controller/user_dashboard_controller.dart';

class SippoGuestDashboard extends StatefulWidget {
  const SippoGuestDashboard({Key? key}) : super(key: key);

  @override
  State<SippoGuestDashboard> createState() => _SippoGuestDashboardState();
}

class _SippoGuestDashboardState extends State<SippoGuestDashboard> {
  final _controller = GuestDashBoardController.instance;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args is Map<String, dynamic> &&
        args.containsKey(NavigationAppRoute.selectedNavIndex)) {
      final selectedItemIndex =
          Get.arguments[NavigationAppRoute.selectedNavIndex] as int?;
      if (Get.isRegistered<UserNotificationController>())
        UserNotificationController.instance.refreshPage();
      _controller.selectedItemIndex = selectedItemIndex ?? 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_controller.selectedItemIndex != 0) {
          _controller.selectedItemIndex = 0;
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: Obx(() => _controller.pages[_controller.selectedItemIndex]),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.offAndToNamed(SippoRoutes.userLoginPage);

          },
          backgroundColor: SippoColor.primarycolor,
          child: const Icon(
            Icons.login,
            size: 20,
            color: SippoColor.white,
          ),
        ),
      ),
    );
  }
}
