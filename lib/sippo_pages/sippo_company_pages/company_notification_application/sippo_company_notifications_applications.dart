import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/sippo_controller/NotificationController/company_notification_application/company_notification_application_controller.dart';
import 'package:jobspot/sippo_custom_widget/loading_view_widgets/loading_scaffold.dart';
import 'package:jobspot/sippo_pages/sippo_company_pages/company_notification_application/sippo_company_application.dart';
import 'package:jobspot/sippo_pages/sippo_company_pages/company_notification_application/sippo_company_notification.dart';
import 'package:jobspot/sippo_pages/sippo_message_pages/no_resource_screen.dart';

class SippoCompanyNotificationApplication extends StatefulWidget {
  const SippoCompanyNotificationApplication({Key? key}) : super(key: key);

  @override
  State<SippoCompanyNotificationApplication> createState() =>
      _SippoCompanyNotificationApplicationState();
}

class _SippoCompanyNotificationApplicationState
    extends State<SippoCompanyNotificationApplication>
    with SingleTickerProviderStateMixin, RestorationMixin {
  final _controller = Get.put(CompanyNotificationApplicationController());
  TabController? _tabController;
  final RestorableInt tabIndex = RestorableInt(0);
  final nonResource = NoResourceScreen(
    title: 'empty_notification_title'.tr,
    description: 'empty_notification_desc'.tr,
    image: JobstopPngImg.notificationimg,
  );
  final _taps = const [
    SippoCompanyNotification(),
    SippoCompanyApplication(),
  ];

  @override
  String? get restorationId => "tab_non_scrollable_demo";

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController?.index = tabIndex.value;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    _tabController?.addListener(() {
      // When the tab controller's value is updated, make sure to update the
      // tab index value, which is state restorable.
      _controller.resetStates();
      _controller.notifiState.selectedTapIndex = _tabController?.index ?? 0;
      tabIndex.value = _tabController?.index ?? 0;
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScaffold(
      controller: _controller.loadingOverlayController,
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
            children: _taps,
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
        Obx(() => Visibility(
            visible: _controller.notifiState.selectedTapIndex == 0,
            maintainState: true,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.fromWidth(CustomStyle.xs),
                vertical: kToolbarHeight / CustomStyle.overBy3,
              ),
              child: InkWell(
                  splashColor: Jobstopcolor.transparent,
                  highlightColor: Jobstopcolor.transparent,
                  onTap: () {
                    _controller.markAllNotificationsAsRead();
                  },
                  child: Text(
                    'read_all'.tr,
                    style: dmsregular.copyWith(
                      fontSize: FontSize.label(context),
                      color: Jobstopcolor.secondary,
                    ),
                  )),
            ),
          ))
      ],
    );
  }

// this method will be sent into
// NotificationListView -> NotificationApplicationWidget
// and called by each call back function in NotificationApplicationWidget item
// to showing an bottom sheet options for notification option
}
