import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/core/navigation_app_route.dart';
import 'package:jobspot/sippo_controller/NotificationController/user_notification_application/user_notification_controller.dart';
import 'package:jobspot/sippo_controller/dashboards_controller/user_dashboard_controller.dart';

class SippoUserDashboard extends StatefulWidget {
  const SippoUserDashboard({Key? key}) : super(key: key);
  static const userProfession = 'PROFESSIONS';

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
    super.initState();
    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      selectedNavIndex(args);
      checkProfessions(args);
    }
  }

  void selectedNavIndex(Map<String, dynamic> args) {
    if (args.containsKey(NavigationAppRoute.selectedNavIndex)) {
      final selectedItemIndex =
          Get.arguments[NavigationAppRoute.selectedNavIndex] as int?;
      if (Get.isRegistered<UserNotificationController>())
        UserNotificationController.instance.refreshPage();
      _controller.selectedItemIndex = selectedItemIndex ?? 0;
    }
  }

  void checkProfessions(Map<String, dynamic> args) {
    final nav = Navigator.of(context);
    if (args.containsKey(SippoUserDashboard.userProfession)) {
      final professions = args[SippoUserDashboard.userProfession] as bool?;
      if (professions == true) {
        Future.delayed(
          Duration(seconds: 1),
          () => nav.pushNamed(SippoRoutes.sippoProfessions),
        );
      }
    }
  }

  Widget _bottomTabBar(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        currentIndex: _controller.selectedItemIndex,
        onTap: (value) => _controller.selectedItemIndex = value,
        backgroundColor: SippoColor.transparent,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        fixedColor: SippoColor.grey,
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
                    color: SippoColor.primarycolor,
                  ),
                  label: '',
                ))
            .toList(growable: false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Obx(
        () => PopScope(
          canPop: _controller.selectedItemIndex == 0,
          onPopInvoked: (pop) {
            print('Pop Invoked: ${_controller.selectedItemIndex}');
            if (_controller.selectedItemIndex != 0) {
              _controller.selectedItemIndex = 0;
            }
          },
          child: Scaffold(
            bottomNavigationBar: _bottomTabBar(context),
            body: Obx(() => _controller.pages[_controller.selectedItemIndex]),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterDocked,
            floatingActionButton: FloatingActionButton(
              mini: true,
              onPressed: () {},
              backgroundColor: SippoColor.primarycolor,
              child: const Icon(
                Icons.facebook,
                size: 20,
                color: SippoColor.white,
              ),
            ),
          ),
        ),
      );
}
