import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/JopController/NotificationController/company_notification_application/company_application_controller.dart';
import 'package:jobspot/JopController/dashboards_controller/company_dashboard_controller.dart';
import 'package:jobspot/sippo_custom_widget/company_post_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/sippo_data/model/notification/job_application_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/application_job_company_model.dart';

import '../../../JobGlobalclass/sippo_customstyle.dart';
import '../../../sippo_custom_widget/container_bottom_sheet_widget.dart';
import '../../../sippo_custom_widget/setting_item_widget.dart';

class SippoCompanyApplication extends StatefulWidget {
  const SippoCompanyApplication({super.key});

  @override
  State<SippoCompanyApplication> createState() =>
      _SippoCompanyApplicationState();
}

class _SippoCompanyApplicationState extends State<SippoCompanyApplication> {
  final _controller = Get.put(CompanyApplicationController());

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => _controller.refreshPage(),
      child: PagedListView<int, ApplicationCompanyModel>.separated(
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
            return PostApplicationModel(
              onProfileImageTap: () async {
                CompanyDashBoardController.instance.dashboardState
                    .profileViewId = item.customer?.id ?? -1;
                await Get.toNamed(SippoRoutes.sippoCompanyUserProfileView);
                CompanyDashBoardController
                    .instance.dashboardState.profileViewId = -1;
              },
              company: _controller.notificationApplicationController.company,
              application: item,
              timeAgo: item.createdAt,
              onActionButtonPresses: () {
                _openBottomJobSheetOption(
                  context,
                  item.id,
                  item.status == "Pending",
                );
              },
              onShowCvTap: (cvUrl) {
                _controller.openFile(cvUrl);
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

  void _openBottomJobSheetOption(
    BuildContext context,
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
              title: 'Application Status',
              icon: Icon(Icons.confirmation_number_outlined),
              onTap: () async {
                Get.back();
                if (isPending == true) {
                  _showConfirmDeleteDialog(context, applicationId);
                } else if (isPending == false) {
                  Get.snackbar(
                    'Application Status',
                    "The application status is checked out.",
                    backgroundColor: Jobstopcolor.backgroudHome,
                    boxShadows: [boxShadow],
                  );
                }
              },
              isHavingTrailingIcon: false,
              isBordered: false,
              contentPadding: context.fromWidth(CustomStyle.xs),
              isSelected: false,
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmDeleteDialog(BuildContext context, int? ApplicationId) {
    Get.dialog(
      CustomAlertDialog(
        title: 'Application Status',
        description: 'Rejected Application or Accepted Application',
        confirmBtnTitle: 'Accepted',
        onConfirm: () async {
          Get.back();
          await _controller.onUpdateStatusApplicationSubmitted(
            ApplicationStatusType.Accepted,
            ApplicationId,
          );
        },
        cancelBtnTitle: 'Rejected',
        onCancel: () async {
          Get.back();
          await _controller.onUpdateStatusApplicationSubmitted(
            ApplicationStatusType.Rejected,
            ApplicationId,
          );
        },
      ),
    );
  }
}
