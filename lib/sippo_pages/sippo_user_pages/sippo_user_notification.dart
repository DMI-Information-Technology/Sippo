import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/sippo_pages/sippo_message_pages/no_resource_screen.dart';

import '../../JopController/NotificationController/user_notification_controller.dart';
import '../../sippo_custom_widget/container_bottom_sheet_widget.dart';
import '../../sippo_custom_widget/notification_widget.dart';
import '../../sippo_custom_widget/setting_item_widget.dart';
import '../../sippo_data/model/notification/job_application_model.dart';
import 'job_application.dart';

class SippoUserJobNotification extends StatefulWidget {
  const SippoUserJobNotification({Key? key}) : super(key: key);

  @override
  State<SippoUserJobNotification> createState() =>
      _SippoUserJobNotificationState();
}

class _SippoUserJobNotificationState extends State<SippoUserJobNotification>
    with SingleTickerProviderStateMixin, RestorationMixin {
  final UserNotificationController _notifiController =
      Get.put(UserNotificationController());
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    _tabController.addListener(() {
      // When the tab controller's value is updated, make sure to update the
      // tab index value, which is state restorable.
      print("fdffdfdfdfffdfd");
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
            children: [
              Obx(
                () => _notifiController.generalNotifications.isNotEmpty
                    ? NotificationListView(
                        notifiList: _notifiController.generalNotifications,
                        isGeneral: true,
                      )
                    : nonResource,
              ),
              Obx(
                () => _notifiController.applicationNotifications.isNotEmpty
                    ? NotificationListView(
                        notifiList: _notifiController.applicationNotifications,
                        isGeneral: false,
                      )
                    : nonResource,
              ),
            ],
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
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.fromWidth(CustomStyle.xs),
            vertical: kToolbarHeight / CustomStyle.overBy3,
          ),
          child: InkWell(
              splashColor: Jobstopcolor.transparent,
              highlightColor: Jobstopcolor.transparent,
              // onTap: () => Get.to(() => const AllNotification()),
              child: Text(
                'read_all'.tr,
                style: dmsregular.copyWith(
                  fontSize: FontSize.label(context),
                  color: Jobstopcolor.secondary,
                ),
              )),
        )
      ],
    );
  }

// this method will be sent into
// NotificationListView -> NotificationApplicationWidget
// and called by each call back function in NotificationApplicationWidget item
// to showing an bottom sheet options for notification option
}

class NotificationListView extends StatelessWidget {
  const NotificationListView({
    super.key,
    required this.notifiList,
    this.isGeneral = false,
  });

  final List<NotificationModel> notifiList;
  final bool isGeneral;

  @override
  Widget build(BuildContext context) {
    final controller = UserNotificationController.instance;
    Size size = MediaQuery.of(context).size;
    // double height = size.height;
    double width = size.width;
    return ListView.separated(
      padding: EdgeInsets.only(
        top: context.fromHeight(CustomStyle.m),
        bottom: context.fromHeight(CustomStyle.xs),
      ),
      itemCount: notifiList.length,
      itemBuilder: (context, index) {
        return SizedBox(
          width: width,
          child: Obx(
            () => NotificationApplicationWidget(
              onDeletePressed: () => null,
              onTap: () {
                if (controller.selectedNotification != index) {
                  controller.selectedNotification = index;
                }
                if (isGeneral) {
                  _openBottomSheetOption(context, isGeneral, index);
                }
              },
              onPopupNotificationButtonTapped: !isGeneral
                  ? () => _openBottomSheetOption(context, isGeneral, index)
                  : null,
              // notification: notifiList[index],
              isSelected: controller.selectedNotification == index,
            ),
          ),
        );
      },
      separatorBuilder: (context, _) => SizedBox(
        height: context.fromWidth(CustomStyle.m),
      ),
    );
  }

  void _openBottomSheetOption(
    BuildContext context,
    bool isGeneral,
    int notificationID,
  ) {
    final controller = UserNotificationController.instance;
    Get.bottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      ContainerBottomSheetWidget(
        children: [
          Obx(
            () => SettingItemWidget(
              title: "Delete",
              icon: Icon(
                Icons.delete_forever_outlined,
                color: controller.isMatchOptionOfIndex(0) ? Colors.white : null,
              ),
              onTap: () {
                controller.selectedBottomOption = 0;
                print("delete notification with id: $notificationID");
              },
              isHavingTrailingIcon: false,
              isBordered: false,
              contentPadding: context.fromWidth(CustomStyle.xs),
              isSelected: controller.isMatchOptionOfIndex(0),
            ),
          ),
          Obx(
            () => SettingItemWidget(
              title: isGeneral ? 'turn_off_notifi'.tr : "check_details".tr,
              icon: Icon(
                isGeneral
                    ? Icons.notifications_off_outlined
                    : Icons.business_center_rounded,
                color: controller.isMatchOptionOfIndex(1) ? Colors.white : null,
              ),
              onTap: () {
                controller.selectedBottomOption = 1;
                if (!isGeneral) {
                  Get.back();
                  Get.to(() => const JobApplication());
                } else
                  print("turn on/off the notification");
              },
              isHavingTrailingIcon: false,
              isBordered: false,
              contentPadding: context.fromWidth(CustomStyle.xs),
              isSelected: controller.isMatchOptionOfIndex(1),
            ),
          ),
          Obx(
            () => SettingItemWidget(
              title: 'setting'.tr,
              icon: Icon(
                Icons.settings_rounded,
                color: controller.isMatchOptionOfIndex(2) ? Colors.white : null,
              ),
              onTap: () {
                controller.selectedBottomOption = 2;
                print("open setting notification");
              },
              isHavingTrailingIcon: false,
              isBordered: false,
              contentPadding: context.fromWidth(CustomStyle.xs),
              isSelected: controller.isMatchOptionOfIndex(2),
            ),
          ),
        ],
      ),
    ).then((value) => controller.selectedBottomOption = -1);
  }
}
