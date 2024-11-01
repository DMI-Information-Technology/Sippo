import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/JobGlobalclass/routes.dart';
import 'package:sippo/core/navigation_app_route.dart';
import 'package:sippo/sippo_controller/NotificationController/user_notification_application/user_notification_controller.dart';
import 'package:sippo/sippo_controller/dashboards_controller/user_dashboard_controller.dart';

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
    return PopScope(
      canPop: _controller.selectedItemIndex == 0,
      onPopInvoked: (pop) async {
        if (_controller.selectedItemIndex != 0) {
          _controller.selectedItemIndex = 0;
        }
      },
      child: Scaffold(
        body: Obx(() => _controller.pages[_controller.selectedItemIndex]),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.offAndToNamed(SippoRoutes.userLoginPage);
          },
          backgroundColor: SippoColor.primarycolor,
          label: Text('Login'.tr,style: dmsmedium,),
          icon: const Icon(
            Icons.login,
            size: 20,
            color: SippoColor.white,
          ),
        ),
      ),
    );
  }
}
