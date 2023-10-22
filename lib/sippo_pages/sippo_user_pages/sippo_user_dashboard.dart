import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JopController/dashboards_controller/user_dashboard_controller.dart';

import '../../JopController/NotificationController/user_notification_application/user_notification_controller.dart';
import '../../core/navigation_app_route.dart';

class SippoUserDashboard extends StatefulWidget {
  const SippoUserDashboard({Key? key}) : super(key: key);

  @override
  State<SippoUserDashboard> createState() => _SippoUserDashboardState();
}

class _SippoUserDashboardState extends State<SippoUserDashboard> {
  final _controller = UserDashBoardController.instance;
  static const assets = [
    JobstopPngImg.home,
    JobstopPngImg.posting,
    JobstopPngImg.notifiBell,
    JobstopPngImg.order,
  ];

  @override
  void initState() {
    // TODO: implement initState
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

  Widget _bottomTabBar(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        currentIndex: _controller.selectedItemIndex,
        onTap: (value) => _controller.selectedItemIndex = value,
        backgroundColor: Jobstopcolor.transparent,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        fixedColor: Jobstopcolor.grey,
        elevation: 0,
        items: assets
            .map((asset) => BottomNavigationBarItem(
                  icon: Image.asset(
                    asset,
                    height: context.fromHeight(CustomStyle.l),
                    color: Colors.grey,
                  ),
                  activeIcon: Image.asset(
                    asset,
                    height: context.fromHeight(CustomStyle.l),
                    color: Jobstopcolor.primarycolor,
                  ),
                  label: '',
                ))
            .toList(growable: false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomTabBar(context),
      body: Obx(() => _controller.pages[_controller.selectedItemIndex]),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {},
        backgroundColor: Jobstopcolor.primarycolor,
        child: const Icon(
          Icons.add,
          size: 20,
          color: Jobstopcolor.white,
        ),
      ),
    );
  }
}
