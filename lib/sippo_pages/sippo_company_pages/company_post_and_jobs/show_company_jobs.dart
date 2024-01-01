import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/JobGlobalclass/jobstopimges.dart';
import 'package:sippo/JobGlobalclass/media_query_sizes.dart';
import 'package:sippo/JobGlobalclass/routes.dart';
import 'package:sippo/JobGlobalclass/sippo_customstyle.dart';
import 'package:sippo/JobGlobalclass/text_font_size.dart';
import 'package:sippo/sippo_controller/company_display_posts_job_controller/company_show_job_controller.dart';
import 'package:sippo/sippo_custom_widget/container_bottom_sheet_widget.dart';
import 'package:sippo/sippo_custom_widget/job_card_widget.dart';
import 'package:sippo/sippo_custom_widget/setting_item_widget.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';
import 'package:sippo/sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';
import 'package:sippo/sippo_pages/sippo_message_pages/no_items_found_message.dart';
import 'package:sippo/utils/helper.dart' as helper;
import 'package:lottie/lottie.dart';

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
          noItemsFoundIndicatorBuilder: (context) =>
              NoItemsFoundMessageWidget.jobs(),
          firstPageProgressIndicatorBuilder: (context) => Center(
            child: Lottie.asset(
              JobstopPngImg.loadingProgress,
              height: context.height / 6,
            ),
          ),
          itemBuilder: (context, item, index) {
            return JobPostingCard(
              jobDetails: item,
              isActive: item.isActive,
              imagePath: item.company?.profileImage?.url ?? '',
              timeAgo: helper.calculateElapsedTimeFromStringDate(
                    item.createdAt,
                  ) ??
                  "",
              isEditable: true,
              onActionTap: () {
                _openBottomJobSheetOption(context, item.id, item.isActive);
              },
              onAddressTextTap: (location) {
                helper.lunchMapWithLocation(
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
    final showWrapperController = _controller.showWrapperController;

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
              showWrapperController.changeStates(isError: false, message: '');
            },
            text: 'try_again'.tr,
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
              title: "edit".tr,
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
        title: 'job_status'.tr,
        description: '${'confirm_job_status'.tr}'
            ' ${isActive == true ? 'inactive'.tr : 'active'.tr} ',
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
