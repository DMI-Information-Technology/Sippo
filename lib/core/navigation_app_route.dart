import 'package:get/get.dart';

import '../JobGlobalclass/global_storage.dart';
import '../JobGlobalclass/routes.dart';
import '../JopController/NotificationController/company_notification_application/company_notification_controller.dart';
import '../JopController/NotificationController/user_notification_application/user_notification_controller.dart';
import '../JopController/dashboards_controller/user_dashboard_controller.dart';
import '../utils/app_use.dart';

class NavigationAppRoute {
  static const selectedNavIndex = 'selected_nav_index';

  static void gotoRoute(String route) {
    switch (route) {
      case SippoRoutes.userDashboard:
        if (Get.isRegistered<UserNotificationController>())
          UserNotificationController.instance.refreshPage();
        if (UserDashBoardController.instance.selectedItemIndex != 2)
          UserDashBoardController.instance.selectedItemIndex = 2;
      case SippoRoutes.sippoCompanyDashboard:
        if (Get.isRegistered<CompanyNotificationController>())
          CompanyNotificationController.instance.refreshPage();
        if (UserDashBoardController.instance.selectedItemIndex != 2)
          UserDashBoardController.instance.selectedItemIndex = 2;
      default:
        _onNotDashboardRoutes();
    }
  }

  static void _onNotDashboardRoutes() {
    switch (GlobalStorageService.appUse) {
      case AppUsingType.user:
        Get.offAllNamed(
          SippoRoutes.userDashboard,
          arguments: {selectedNavIndex: 2},
        );

      case AppUsingType.company:
        Get.offAllNamed(
          SippoRoutes.sippoCompanyDashboard,
          arguments: {selectedNavIndex: 2},
        );
    }
  }
}
