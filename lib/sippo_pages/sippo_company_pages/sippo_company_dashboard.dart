import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/core/navigation_app_route.dart';
import 'package:jobspot/sippo_controller/NotificationController/company_notification_application/company_notification_controller.dart';
import 'package:jobspot/sippo_controller/dashboards_controller/company_dashboard_controller.dart';
import 'package:jobspot/sippo_custom_widget/confirmation_bottom_sheet.dart';
import 'package:jobspot/sippo_custom_widget/container_bottom_sheet_widget.dart';
import 'package:jobspot/sippo_pages/sippo_company_pages/company_notification_application/sippo_company_notifications_applications.dart';
import 'package:jobspot/sippo_pages/sippo_company_pages/sippo_company_home.dart';
import 'package:jobspot/sippo_pages/sippo_company_pages/sippo_jobs_posts_company_wrapper.dart';

class SippoCompanyDashboard extends StatefulWidget {
  const SippoCompanyDashboard({Key? key}) : super(key: key);

  @override
  State<SippoCompanyDashboard> createState() => _SippoCompanyDashboardState();
}

class _SippoCompanyDashboardState extends State<SippoCompanyDashboard> {
  final _controller = CompanyDashBoardController.instance;
  final _pages = const [
    SippoCompanyHomePage(),
    SippoJobsPostsCompanyWrapper(),
    SippoCompanyNotificationApplication(),
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
      if (Get.isRegistered<CompanyNotificationController>())
        CompanyNotificationController.instance.refreshPage();
      _controller.selectedItemIndex = selectedItemIndex ?? 0;
    }
  }

  Widget _bottomTabBar(BuildContext context) {
    return Obx(() => BottomNavigationBar(
          currentIndex: _controller.selectedItemIndex,
          onTap: _onTap,
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
                height: context.height / 36,
                color: Colors.grey,
              ),
              activeIcon: Image.asset(
                JobstopPngImg.home,
                height: context.height / 36,
                color: Jobstopcolor.primarycolor,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                JobstopPngImg.posting,
                height: context.height / 36,
                color: Colors.grey,
              ),
              activeIcon: Image.asset(
                JobstopPngImg.posting,
                height: context.height / 36,
                color: Jobstopcolor.primarycolor,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                JobstopPngImg.notifiBell,
                height: context.height / 36,
                color: Colors.grey,
              ),
              activeIcon: Image.asset(JobstopPngImg.message,
                  height: context.height / 36,
                  color: Jobstopcolor.primarycolor),
              label: "",
            ),
          ],
        ));
  }

  _onTap(int index) {
    if (index < _pages.length) _controller.selectedItemIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomTabBar(context),
      body: Obx(() => _pages[_controller.selectedItemIndex]),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: _chooseAddNewBottomSheet,
        backgroundColor: Jobstopcolor.primarycolor,
        child: const Icon(
          Icons.add,
          size: 20,
          color: Jobstopcolor.white,
        ),
      ),
    );
  }

  void _chooseAddNewBottomSheet() {
    Get.bottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      ContainerBottomSheetWidget(
        notchColor: Jobstopcolor.primarycolor,
        children: [
          ConfirmationBottomSheet(
            title: "ask_type_company_post".tr,
            description:
                "desc_ask_type_company_post".tr,
            confirmTitle: "post".tr,
            onConfirm: () async {
              Get.back();
              Get.toNamed(SippoRoutes.companyAddPost);
            },
            undoTitle: "title_job".tr,
            onUndo: () async {
              Get.back();
              Get.toNamed(SippoRoutes.companyAddJobs);
            },
          )
        ],
      ),
    );
  }
}
