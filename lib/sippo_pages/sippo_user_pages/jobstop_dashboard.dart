import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import '../../JopController/UserDashboardController/user_dashboard_controller.dart';

class SippoUserDashboard extends StatefulWidget {
  const SippoUserDashboard({Key? key}) : super(key: key);

  @override
  State<SippoUserDashboard> createState() => _SippoUserDashboardState();
}

class _SippoUserDashboardState extends State<SippoUserDashboard> {
  final controller = Get.put(UserDashBoardController());

  Widget _bottomTabBar(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(
      () => BottomNavigationBar(
        currentIndex: controller.selectedItemIndex,
        onTap: (value) => controller.selectedItemIndex = value,
        backgroundColor: Jobstopcolor.transparent,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        fixedColor: Jobstopcolor.grey,
        elevation: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              JobstopPngImg.home,
              height: context.fromHeight(CustomStyle.l),
            ),
            activeIcon: Image.asset(
              JobstopPngImg.home,
              height: context.fromHeight(CustomStyle.l),
              color: Jobstopcolor.primarycolor,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              JobstopPngImg.posting,
              height: context.fromHeight(CustomStyle.l),
            ),
            activeIcon: Image.asset(
              JobstopPngImg.posting,
              height: context.fromHeight(CustomStyle.l),
              color: Jobstopcolor.primarycolor,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              JobstopPngImg.notifiBell,
              height: context.fromHeight(CustomStyle.l),
              color: Jobstopcolor.grey,
              colorBlendMode: BlendMode.srcIn,
            ),
            activeIcon: Image.asset(
              JobstopPngImg.notifiBell,
              height: context.fromHeight(CustomStyle.l),
              color: Jobstopcolor.primarycolor,
              colorBlendMode: BlendMode.srcIn,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              JobstopPngImg.order,
              height: context.fromHeight(CustomStyle.l),
            ),
            activeIcon: Image.asset(
              JobstopPngImg.order,
              height: context.fromHeight(CustomStyle.l),
              color: Jobstopcolor.primarycolor,
            ),
            label: '',
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomTabBar(context),
      body: Obx(() => controller.pages[controller.selectedItemIndex]),
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
