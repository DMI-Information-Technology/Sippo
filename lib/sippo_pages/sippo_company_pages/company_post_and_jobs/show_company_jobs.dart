import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';

import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/JopController/company_display_posts_job_controller/company_show_job_controller.dart';
import 'package:jobspot/sippo_custom_widget/container_bottom_sheet_widget.dart';
import 'package:jobspot/sippo_custom_widget/save_job_card_widget.dart';
import 'package:jobspot/sippo_custom_widget/setting_item_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/utils/helper.dart';

class ShowCompanyJobsList extends StatefulWidget {
  const ShowCompanyJobsList({super.key});

  @override
  State<ShowCompanyJobsList> createState() => _ShowCompanyJobsListState();
}

class _ShowCompanyJobsListState extends State<ShowCompanyJobsList> {
  // final _controller = <  >
  final _controller = Get.put(CompanyShowJobController());

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => _controller.refreshPage(),
      child: PagedListView<int, CompanyJobModel>.separated(
        pagingController: _controller.pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          firstPageErrorIndicatorBuilder: (context) =>
              _buildErrorFirstLoad(context),
          newPageErrorIndicatorBuilder: (context) =>
              _buildErrorNewLoad(context),
          itemBuilder: (context, item, index) {
            return JobPostingCard(
              jobDetails: item,
              isActive: item.isActive,
              imagePath: [
                'https://www.designbust.com/download/1060/png/microsoft_logo_transparent512.png',
                'https://logodownload.org/wp-content/uploads/2014/09/facebook-logo-1-2.png',
              ][index % 2 == 0 ? 0 : 1],
              timeAgo: '21 min ago',
              isEditable: true,
              onActionTap: () {
                _openBottomJobSheetOption(context, item.id, item.isActive);
              },
              onAddressTextTap: (location) async {
                await lunchMapWithLocation(
                  location?.dLatitude,
                  location?.dLongitude,
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
    final showWrapperController = _controller.showWrapperController;
    return InkWell(
      onTap: () {
        showWrapperController.changeStates(isError: false, message: '');
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
    final showWrapperController = _controller.showWrapperController;

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
              showWrapperController.changeStates(isError: false, message: '');
            },
            text: 'Try again',
          ),
        )
      ],
    );
  }

  void _openBottomJobSheetOption(BuildContext context, int? postId,
      [bool? isActive]) {
    final showWrapperController = _controller.showWrapperController;

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
              title: isActive == true ? "InActive" : "Active",
              icon: Icon(Icons.delete_forever_outlined),
              onTap: () async {
                Get.back();
                _showConfirmDeleteDialog(context, postId, isActive);
              },
              isHavingTrailingIcon: false,
              isBordered: false,
              contentPadding: context.fromWidth(CustomStyle.xs),
              isSelected: false,
            ),
            SettingItemWidget(
              title: "Edit",
              icon: Icon(Icons.edit_note_rounded),
              onTap: () async {
                Get.back();
                if (postId == null) return;
                showWrapperController.editPostId = postId;
                Get.toNamed(SippoRoutes.companyAddJobs)?.then(
                  (result) {
                    _controller.refreshJobsAfterEdit(result);
                    showWrapperController.editPostId = -1;
                  },
                );
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

  void _showConfirmDeleteDialog(BuildContext context, int? postId,
      [bool? isActive]) {
    Get.dialog(
      CustomAlertDialog(
        title: 'Job Status',
        description: 'Are you sure you want'
            ' ${isActive == true ? 'InActive' : 'Active'} '
            'this Job.',
        onConfirm: () async {
          Get.back();
          await _controller.onUpdateStatusJobSubmitted(postId);
        },
        onCancel: () {
          Get.back();
        },
      ),
    );
  }
}
