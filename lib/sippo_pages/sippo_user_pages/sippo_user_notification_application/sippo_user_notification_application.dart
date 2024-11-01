import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/JobGlobalclass/jobstopimges.dart';
import 'package:sippo/JobGlobalclass/media_query_sizes.dart';
import 'package:sippo/JobGlobalclass/sippo_customstyle.dart';
import 'package:sippo/JobGlobalclass/text_font_size.dart';
import 'package:sippo/sippo_controller/NotificationController/user_notification_application/user_notification_application_controller.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';
import 'package:sippo/sippo_pages/sippo_message_pages/no_resource_screen.dart';

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

  final nonResource = NoResourceScreen(
    title: 'title_no_notification_found'.tr,
    description: 'description_no_notification_found'.tr,
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
        unselectedLabelColor: SippoColor.grey,
        labelColor: SippoColor.secondary,
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
          listenable: _notifiController.showNotificationReadAllButton,
          builder: (context, outerChild) {
            return _notifiController.hasNotificationsToRead
                ? outerChild!
                : const SizedBox.shrink();
          },
          child: ListenableBuilder(
            listenable: _tabController,
            builder: (context, innerChild) => _tabController.index == 0
                ? innerChild!
                : const SizedBox.shrink(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.fromWidth(CustomStyle.xs),
                vertical: kToolbarHeight / CustomStyle.overBy3,
              ),
              child: InkWell(
                splashColor: SippoColor.transparent,
                highlightColor: SippoColor.transparent,
                onTap: () => _onReadAllNotificationsConfirmation(context),
                child: Text(
                  'read_all'.tr,
                  style: dmsregular.copyWith(
                    fontSize: FontSize.label(context),
                    color: SippoColor.secondary,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onReadAllNotificationsConfirmation(BuildContext context) {
    Get.dialog(CustomAlertDialog(
      title: 'title_confirm_read_all_notification'.tr,
      description: 'ask_read_all_notification'.tr,
      onConfirm: () {
        Get.back();
        _notifiController.markAllNotificationsAsRead();
      },
      confirmBtnTitle: 'yes'.tr,
      onCancel: () {
        Get.back();
      },
      cancelBtnTitle: 'cancel'.tr,
    ));
  }
}
