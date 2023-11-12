import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/JobServices/shared_global_data_service.dart';
import 'package:jobspot/sippo_controller/NotificationController/user_notification_application/user_notification_controller.dart';
import 'package:jobspot/sippo_custom_widget/container_bottom_sheet_widget.dart';
import 'package:jobspot/sippo_custom_widget/network_bordered_circular_image_widget.dart';
import 'package:jobspot/sippo_custom_widget/rounded_border_radius_card_widget.dart';
import 'package:jobspot/sippo_custom_widget/setting_item_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/sippo_data/model/notification/notification_model.dart';
import 'package:jobspot/sippo_data/model/notification/notifications_types.dart';
import 'package:jobspot/sippo_pages/sippo_message_pages/no_items_found_message.dart';
import 'package:lottie/lottie.dart';

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
          noItemsFoundIndicatorBuilder: (context) =>
              NoItemsFoundMessageWidget.notification(),
          firstPageProgressIndicatorBuilder: (context) => Center(
            child: Lottie.asset(
              JobstopPngImg.loadingProgress,
              height: context.height / 6,
            ),
          ),
          itemBuilder: (context, item, index) {
            return NotificationCardWidget(
              notification: item,
              onTap: () => _onNotificationTapped(index, item),
              onActionTap: () =>
                  _openBottomSheetOption(context, index, item?.id),
            );
          },
        ),
        separatorBuilder: (_, __) => SizedBox(
          height: context.fromHeight(CustomStyle.huge),
        ),
      ),
    );
  }

  Widget _buildErrorNewLoad(BuildContext context) {
    final notificationApplicationController =
        _controller.notificationApplicationController;
    return InkWell(
      onTap: () {
        notificationApplicationController.changeStates(
          isError: false,
          message: '',
        );
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
              color: SippoColor.primarycolor,
            ),
          ),
          Icon(
            Icons.refresh,
            color: SippoColor.primarycolor,
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
          "error".tr,
          style: dmsbold.copyWith(
            color: SippoColor.primarycolor,
            fontSize: FontSize.title2(context),
          ),
        ),
        SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
        Text(
          _controller.states.message ?? 'something_wrong_happened'.tr,
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
            text: 'try_again'.tr,
          ),
        )
      ],
    );
  }

  void _openBottomSheetOption(
    BuildContext context,
    int index,
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
              title: "option_delete_notification".tr,
              icon: Icon(
                Icons.delete_forever_outlined,
                // color:
                // _controller.isMatchOptionOfIndex(0) ? Colors.white : null,
              ),
              onTap: () {
                Get.back();
                _onDeleteConfirmation(context, index, notificationId);
              },
              isHavingTrailingIcon: false,
              isBordered: false,
              contentPadding: context.fromWidth(CustomStyle.xs),
              // isSelected: _controller.isMatchOptionOfIndex(0),
            ),
            SettingItemWidget(
              title: 'option_turn_off_notification'.tr,
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

  void _onDeleteConfirmation(
      BuildContext context, int index, String? notificationId) async {
    Get.dialog(CustomAlertDialog(
      title: 'title_confirm_delete_notification'.tr,
      description: 'ask_delete_notification'.tr,
      onConfirm: () {
        Get.back();
        _controller.removedNotification(index, notificationId);
      },
      confirmBtnTitle: 'Yes',
      onCancel: () {
        Get.back();
      },
      cancelBtnTitle: 'Cancel',
    ));
  }

  void _onNotificationTapped(int index, BaseNotificationModel? item) async {
    if (item?.isRead == false)
      _controller.markedNotificationAsRead(index, item?.id);
    switch (item?.notificationType) {
      case NotificationTypes.newPost:
        SharedGlobalDataService.onCompanyTap(
          item?.asNotificationPost().data?.company,
          args: {
            SharedGlobalDataService.SELECTED_TAP_INDEX: 1,
          },
        );
      case NotificationTypes.newJob:
        SharedGlobalDataService.onJobTap(
          item?.asNotificationJob().data?.item,
        );
      case NotificationTypes.applicationStatus:
        final data = item?.asNotificationApplication().data;
        if (data?.item?.id case int id)
          SharedGlobalDataService.onJobTapWithID(id);
        else
          SharedGlobalDataService.onCompanyTap(data?.company);
      case NotificationTypes.newApplicationReceived:
      case NotificationTypes.newFollower:
      case NotificationTypes.subscriptionWillEnd:
      case NotificationTypes.subscriptionEnded:
      case null:
    }
  }
}

class NotificationCardWidget extends StatelessWidget {
  const NotificationCardWidget({
    super.key,
    required this.onTap,
    this.notification,
    required this.onActionTap,
  });

  final void Function() onTap;
  final BaseNotificationModel? notification;
  final void Function() onActionTap;

  @override
  Widget build(BuildContext context) {
    return RoundedBorderRadiusCardWidget(
      color: notification?.isRead != true ? SippoColor.lightprimary4 : null,
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.top,
        horizontalTitleGap: 0.0,
        contentPadding: EdgeInsets.zero,
        minVerticalPadding: 0.0,
        title: Text(
          notification?.title ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification?.body ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: context.fromHeight(CustomStyle.huge)),
            Text(
              notification?.date ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: dmsregular.copyWith(
                fontSize: FontSize.label(context),
              ),
            ),
          ],
        ),
        leading: NetworkBorderedCircularImage(
          imageUrl: notification?.image?.url ?? '',
          size: context.fromHeight(18),
          outerBorderColor: Colors.transparent,
          outerBorderWidth: context.fromWidth(CustomStyle.huge),
          errorWidget: (_, __, ___) => const CircleAvatar(),
        ),
        trailing: InkWell(
          onTap: onActionTap,
          child: Icon(
            Icons.more_vert_rounded,
            color: Colors.black87,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
