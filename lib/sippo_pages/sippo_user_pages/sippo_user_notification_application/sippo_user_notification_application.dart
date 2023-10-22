import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/JopController/NotificationController/user_notification_application/user_notification_application_controller.dart';
import 'package:jobspot/sippo_pages/sippo_message_pages/no_resource_screen.dart';

import '../../../sippo_custom_widget/widgets.dart';
import 'sippo_user_application.dart';
import 'sippo_user_notification.dart';

class SippoUserNotificationApplication extends StatefulWidget {
  const SippoUserNotificationApplication({Key? key}) : super(key: key);

  @override
  State<SippoUserNotificationApplication> createState() =>
      _SippoUserNotificationApplicationState();
}

class _SippoUserNotificationApplicationState
    extends State<SippoUserNotificationApplication>
    with SingleTickerProviderStateMixin, RestorationMixin {
  final _notifiController = Get.put(UserNotificationApplicationController());
  late final TabController _tabController;
  final RestorableInt tabIndex = RestorableInt(0);

  final nonResource = const NoResourceScreen(
    title: 'No notifications',
    description: 'You have no notifications at this time\nthank you',
    image: JobstopPngImg.notificationimg,
  );

  @override
  String? get restorationId => "tab_non_scrollable_view";

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }

  final _tabs = const [SippoUserNotification(), SippoUserApplication()];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    _tabController.addListener(() {
      // When the tab controller's value is updated, make sure to update the
      // tab index value, which is state restorable.
      print("fdffdfdfdfffdfd");
      _notifiController.resetStates();
      _notifiController.selectedNotification = -1;
      tabIndex.value = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBodyPage(context),
    );
  }

  Widget _buildBodyPage(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: _tabs,
          ),
        ),
      ],
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      bottom: TabBar(
        padding: EdgeInsets.symmetric(
          horizontal: context.fromWidth(CustomStyle.paddingValue),
        ),
        unselectedLabelColor: Jobstopcolor.grey,
        labelColor: Jobstopcolor.secondary,
        controller: _tabController,
        labelStyle: dmsmedium.copyWith(
          fontSize: FontSize.title5(context),
        ),
        indicatorWeight: 5,
        isScrollable: false,
        tabs: [
          Tab(text: 'general'.tr),
          Tab(text: 'applications'.tr),
        ],
      ),
      centerTitle: true,
      title: Text(
        'notifications'.tr,
        style: dmsbold.copyWith(fontSize: FontSize.title3(context)),
      ),
      actions: [
        ListenableBuilder(
          listenable: _tabController,
          builder: (context, _) => _tabController.index == 0
              ? Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.fromWidth(CustomStyle.xs),
                    vertical: kToolbarHeight / CustomStyle.overBy3,
                  ),
                  child: InkWell(
                      splashColor: Jobstopcolor.transparent,
                      highlightColor: Jobstopcolor.transparent,
                      // onTap: () => Get.to(() => const AllNotification()),
                      onTap: () {
                        _onReadAllNotificationsConfirmation(context);
                      },
                      child: Text(
                        'read_all'.tr,
                        style: dmsregular.copyWith(
                          fontSize: FontSize.label(context),
                          color: Jobstopcolor.secondary,
                        ),
                      )),
                )
              : const SizedBox.shrink(),
        )
      ],
    );
  }

  void _onReadAllNotificationsConfirmation(BuildContext context) {
    Get.dialog(CustomAlertDialog(
      title: 'Delete Notification',
      description: 'Are you sure you want to delete this notification?',
      onConfirm: () {
        Get.back();
        _notifiController.markAllNotificationsAsRead();
      },
      confirmBtnTitle: 'Yes',
      onCancel: () {
        Get.back();
      },
      cancelBtnTitle: 'Cancel',
    ));
  }
}
