import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/JopController/NotificationController/user_notification_application/user_notification_controller.dart';
import 'package:jobspot/sippo_custom_widget/rounded_border_radius_card_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/sippo_data/model/notification/notification_model.dart';

import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/sippo_custom_widget/container_bottom_sheet_widget.dart';
import 'package:jobspot/sippo_custom_widget/setting_item_widget.dart';

class SippoUserNotification extends StatefulWidget {
  const SippoUserNotification({super.key});

  @override
  State<SippoUserNotification> createState() => _SippoUserNotificationState();
}

class _SippoUserNotificationState extends State<SippoUserNotification> {
  final _controller = Get.put(UserNotificationController());

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => _controller.refreshPage(),
      child: PagedListView<int, BaseNotificationModel?>.separated(
        padding: EdgeInsets.symmetric(
          vertical: context.fromHeight(CustomStyle.paddingValue),
          horizontal: context.fromWidth(CustomStyle.paddingValue),
        ),
        pagingController: _controller.pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          firstPageErrorIndicatorBuilder: (context) =>
              _buildErrorFirstLoad(context),
          newPageErrorIndicatorBuilder: (context) =>
              _buildErrorNewLoad(context),
          itemBuilder: (context, item, index) {
            return _buildNotificationCard(context, item);
          },
        ),
        separatorBuilder: (_, __) => SizedBox(
          height: context.fromHeight(CustomStyle.huge),
        ),
      ),
    );
  }

  RoundedBorderRadiusCardWidget _buildNotificationCard(
    BuildContext context,
    BaseNotificationModel? item,
  ) {
    return RoundedBorderRadiusCardWidget(
      color: item?.isRead != true ? Jobstopcolor.lightprimary4 : null,
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.top,
        horizontalTitleGap: 0.0,
        contentPadding: EdgeInsets.zero,
        minVerticalPadding: 0.0,
        title: Text(
          item?.title ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item?.body ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: context.fromHeight(CustomStyle.huge)),
            Text(
              item?.date ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: dmsregular.copyWith(
                fontSize: FontSize.label(context),
              ),
            ),
          ],
        ),
        leading: CircleAvatar(
          radius: context.fromHeight(21),
        ),
        trailing: InkWell(
          onTap: () => _openBottomNotificationSheetOption(context, item?.id),
          child: Icon(
            Icons.more_vert_rounded,
            color: Colors.black87,
          ),
        ),
        onTap: () {},
      ),
    );
  }

  Widget _buildErrorNewLoad(BuildContext context) {
    final notificationApplicationController =
        _controller.notificationApplicationController;
    return InkWell(
      onTap: () {
        notificationApplicationController.changeStates(
            isError: false, message: '');
        _controller.retryLastFieldRequest();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${_controller.states.message}',
            textAlign: TextAlign.center,
            style: dmsregular.copyWith(
              fontSize: FontSize.paragraph3(context),
              color: Jobstopcolor.primarycolor,
            ),
          ),
          Icon(
            Icons.refresh,
            color: Jobstopcolor.primarycolor,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorFirstLoad(BuildContext context) {
    final notificationApplicationController =
        _controller.notificationApplicationController;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Error",
          style: dmsbold.copyWith(
            color: Jobstopcolor.primarycolor,
            fontSize: FontSize.title2(context),
          ),
        ),
        SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
        Text(
          _controller.states.message ?? 'something wrong is happened.',
          style: dmsregular.copyWith(
            fontSize: FontSize.paragraph3(context),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
        SizedBox(
          width: context.fromWidth(CustomStyle.overBy3),
          height: context.fromHeight(12),
          child: CustomButton(
            onTapped: () {
              _controller.refreshPage();
              notificationApplicationController.changeStates(
                  isError: false, message: '');
            },
            text: 'Try again',
          ),
        )
      ],
    );
  }

  void _openBottomNotificationSheetOption(
    BuildContext context,
    String? notificationId,
  ) {
    Get.bottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      ContainerBottomSheetWidget.statefulBuilder(
        builder: (context, setState) => Column(
          children: [
            SettingItemWidget(
              title: "Remove this notification",
              icon: Icon(
                Icons.delete_forever_outlined,
                // color:
                // _controller.isMatchOptionOfIndex(0) ? Colors.white : null,
              ),
              onTap: () {
                // _controller.selectedBottomOption = 0;
                print("delete notification with id: $notificationId");
              },
              isHavingTrailingIcon: false,
              isBordered: false,
              contentPadding: context.fromWidth(CustomStyle.xs),
              // isSelected: _controller.isMatchOptionOfIndex(0),
            ),
            SettingItemWidget(
              title: 'Turn off Notification',
              icon: Icon(
                Icons.notifications_off_outlined,
                // color: _controller.isMatchOptionOfIndex(1) ? Colors.white : null,
              ),
              onTap: () {
                // _controller.selectedBottomOption = 1;
                Get.back();
              },
              isHavingTrailingIcon: false,
              isBordered: false,
              contentPadding: context.fromWidth(CustomStyle.xs),
              // isSelected: _controller.isMatchOptionOfIndex(1),
            ),
            SettingItemWidget(
              title: 'setting'.tr,
              icon: Icon(
                Icons.settings_rounded,
                // color: _controller.isMatchOptionOfIndex(2) ? Colors.white : null,
              ),
              onTap: () {
                // _controller.selectedBottomOption = 2;
                print("open setting notification");
              },
              isHavingTrailingIcon: false,
              isBordered: false,
              contentPadding: context.fromWidth(CustomStyle.xs),
              // isSelected: _controller.isMatchOptionOfIndex(2),
            ),
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween))
          ],
        ),
      ),
    );
  }
}
