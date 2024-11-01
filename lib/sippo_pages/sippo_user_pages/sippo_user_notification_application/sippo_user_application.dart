import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/JobGlobalclass/jobstopimges.dart';
import 'package:sippo/JobGlobalclass/media_query_sizes.dart';
import 'package:sippo/JobGlobalclass/sippo_customstyle.dart';
import 'package:sippo/JobGlobalclass/text_font_size.dart';
import 'package:sippo/sippo_controller/NotificationController/user_notification_application/user_application_controller.dart';
import 'package:sippo/sippo_custom_widget/container_bottom_sheet_widget.dart';
import 'package:sippo/sippo_custom_widget/notification_widget.dart';
import 'package:sippo/sippo_custom_widget/setting_item_widget.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';
import 'package:sippo/sippo_data/model/application_model/application_job_company_model.dart';
import 'package:sippo/sippo_pages/sippo_message_pages/no_items_found_message.dart';
import 'package:lottie/lottie.dart';

import 'job_application.dart';

class SippoUserApplication extends StatefulWidget {
  const SippoUserApplication({super.key});

  @override
  State<SippoUserApplication> createState() => _SippoUserApplicationState();
}

class _SippoUserApplicationState extends State<SippoUserApplication> {
  final _controller = Get.put(UserApplicationController());

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => _controller.refreshPage(),
      child: PagedListView<int, ApplicationUserModel>.separated(
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
              NoItemsFoundMessageWidget.application(),
          firstPageProgressIndicatorBuilder: (context) => Center(
            child: Lottie.asset(
              JobstopPngImg.loadingProgress,
              height: context.height / 6,
            ),
          ),
          itemBuilder: (context, item, index) {
            return UserApplicationWidget(
              company: item.company,
              application: item,
              onTap: () {},
              onPopupNotificationButtonTapped: () {
                _openBottomApplicationSheetOption(
                  context,
                  item,
                  item.id,
                  item.status == "Pending",
                );
              },
            );
          },
        ),
        separatorBuilder: (_, __) => SizedBox(
          height: context.fromHeight(CustomStyle.spaceBetween),
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
            isError: false, message: '');
        _controller.retryLastFieldRequest();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${_controller.notStates.message}',
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
          _controller.notStates.message ?? 'something_wrong_happened'.tr,
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

  void _openBottomApplicationSheetOption(
    BuildContext context,
    ApplicationUserModel application,
    int? applicationId, [
    bool? isPending,
  ]) {
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
              title: "delete".tr,
              icon: Icon(
                Icons.delete_forever_outlined,
              ),
              onTap: () {
                Get.back();
                _controller.removeApplication(applicationId);
                // _controller.selectedBottomOption = 0;
                print("delete notification with id: $applicationId");
              },
              isHavingTrailingIcon: false,
              isBordered: false,
              contentPadding: context.fromWidth(CustomStyle.xs),
              // isSelected: _controller.isMatchOptionOfIndex(0),
            ),
            SettingItemWidget(
              title: "check_details".tr,
              icon: Icon(
                Icons.business_center_rounded,
                // color: _controller.isMatchOptionOfIndex(1) ? Colors.white : null,
              ),
              onTap: () {
                // _controller.selectedBottomOption = 1;
                Get.back();
                if (application.job == null) return;

                _controller.userApplicationState.application = application;
                Get.to(() => const JobApplication())?.then((_) {
                  _controller.userApplicationState.application =
                      ApplicationUserModel();
                });
              },
              isHavingTrailingIcon: false,
              isBordered: false,
              contentPadding: context.fromWidth(CustomStyle.xs),
              // isSelected: _controller.isMatchOptionOfIndex(1),
            ),
            // SettingItemWidget(
            //   title: 'settings'.tr,
            //   icon: Icon(
            //     Icons.settings_rounded,
            //     // color: _controller.isMatchOptionOfIndex(2) ? Colors.white : null,
            //   ),
            //   onTap: () {
            //     // _controller.selectedBottomOption = 2;
            //     print("open setting notification");
            //   },
            //   isHavingTrailingIcon: false,
            //   isBordered: false,
            //   contentPadding: context.fromWidth(CustomStyle.xs),
            //   // isSelected: _controller.isMatchOptionOfIndex(2),
            // ),
          ],
        ),
      ),
    );
  }
}
