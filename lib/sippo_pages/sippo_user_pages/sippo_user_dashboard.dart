import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';

import 'package:jobspot/core/navigation_app_route.dart';
import 'package:jobspot/sippo_controller/NotificationController/user_notification_application/user_notification_controller.dart';
import 'package:jobspot/sippo_controller/dashboards_controller/user_dashboard_controller.dart';

import '../../sippo_custom_widget/widgets.dart';

class SippoUserDashboard extends StatefulWidget {
  const SippoUserDashboard({Key? key}) : super(key: key);

  static const userProfession = 'PROFESSIONS';

  @override
  State<SippoUserDashboard> createState() => _SippoUserDashboardState();
}

class _SippoUserDashboardState extends State<SippoUserDashboard> {
  final _controller = UserDashBoardController.instance;
  GlobalKey _widgetKey = GlobalKey();

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
              child:  IconButton(
                key: _widgetKey,
                onPressed: (){
                  _scaleDialog();
                },
                icon: Icon(Icons.view_headline_sharp, color: Colors.white,),
                color: SippoColor.primarycolor,
              )
            ),
          ),
        ),
      );
  Widget _dialog(BuildContext context) {
    return AlertDialog(
      title: const Text("SIPPO"),
      actions: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDialogRow( iconData: FontAwesomeIcons.whatsapp, text: 'Call us', url: 'tel:+218919639191',),
            CustomDialogRow( iconData: FontAwesomeIcons.facebook, text: 'Add us on Facebook', url: 'https://www.facebook.com/profile.php?id=61554101903737&mibextid=LQQJ4d',),
            CustomDialogRow( iconData: FontAwesomeIcons.tiktok, text: 'Follow us on Tik Tok', url: 'https://www.tiktok.com/@sippoiplunl?_t=8iX5s8tPWSL&_r=1',),
            CustomDialogRow( iconData: FontAwesomeIcons.instagram, text: 'Follow us on Instagram', url: 'https://www.instagram.com/sippo.job?igsh=a3c1eHRmaTl0dWZy',),
            CustomDialogRow( iconData: FontAwesomeIcons.xTwitter, text: 'Follow us on Twitter', url: 'https://x.com/SIPPO2024?t=bmPoBHyKStG5dbmdJctZTA&s=09',),

          ],
        ),

      ],
    );
  }

  void _scaleDialog() {
    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        RenderBox? boxs =
        _widgetKey.currentContext!.findRenderObject() as RenderBox?;
        Offset posit = boxs!.localToGlobal(Offset.zero);

        return Transform.scale(
            scale: curve,
            child: _dialog(ctx),
            origin: posit,
            alignment: AlignmentGeometry.lerp(null, null, 2));
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }
}

