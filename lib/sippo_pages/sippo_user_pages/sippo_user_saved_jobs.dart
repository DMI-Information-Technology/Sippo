import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/JobServices/shared_global_data_service.dart';
import 'package:jobspot/sippo_controller/user_profile_controller/user_saved_jobs_controller.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/container_bottom_sheet_widget.dart';
import 'package:jobspot/sippo_custom_widget/job_card_widget.dart';
import 'package:jobspot/sippo_custom_widget/setting_item_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';
import 'package:jobspot/utils/helper.dart' as helper;
import 'package:lottie/lottie.dart';

import '../sippo_message_pages/no_resource_screen.dart';

class SippoUserSavedJob extends StatefulWidget {
  const SippoUserSavedJob({Key? key}) : super(key: key);

  @override
  State<SippoUserSavedJob> createState() => _SippoUserSavedJobState();
}

class _SippoUserSavedJobState extends State<SippoUserSavedJob> {
  int selectlist = 0;

  List<String> bottomimg = [
    JobstopPngImg.subtract,
    JobstopPngImg.union,
    JobstopPngImg.deleted,
    JobstopPngImg.applay
  ];
  final List<String> bottomname = ["Send message", "Shared", "Delete", "Apply"];

  final _controller = Get.put(UserSavedJobsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Save_Job".tr,
          style: dmsbold.copyWith(fontSize: 20),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(kToolbarHeight / 3),
            child: InkWell(
              onTap: () {
                Get.dialog(CustomAlertDialog(
                  title: "Remove All Saved Jobs",
                  description: 'are you sure you want remove all saved jobs?',
                  onConfirm: () {
                    if (Get.isOverlaysOpen) Get.back();
                    _controller.removeAllJobs();
                  },
                  onCancel: () {
                    if (Get.isOverlaysOpen) Get.back();
                  },
                ));
              },
              child: AutoSizeText(
                "Delete all",
                style: dmsregular.copyWith(
                  fontSize: FontSize.label(context),
                  color: Jobstopcolor.secondary,
                ),
              ),
            ),
          )
        ],
      ),
      body: BodyWidget(
        paddingContent: EdgeInsets.symmetric(
            horizontal: context.fromWidth(CustomStyle.paddingValue)),
        child: _buildSavedJobList(),
      ),
    );
  }

  Widget _buildNoResourceMessage(BuildContext context) {
    return NoResourceScreen(
      title: 'Saved Job List is Empty',
      description:
          "You don't have any jobs saved, please\nfind it in search to save jobs",
      image: JobstopPngImg.nosavejob,
    );
  }

  Widget _buildSavedJobList() {
    return RefreshIndicator(
      onRefresh: () async {
        _controller.refreshPage();
      },
      child: PagedListView<int, CompanyJobModel>.separated(
        pagingController: _controller.pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          noItemsFoundIndicatorBuilder: (context) =>
              _buildNoResourceMessage(context),
          firstPageErrorIndicatorBuilder: (context) =>
              _buildErrorFirstLoad(context),
          newPageErrorIndicatorBuilder: (context) =>
              _buildErrorNewLoad(context),
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
              imagePath: item.company?.profileImage?.url,
              timeAgo:
                  helper.calculateElapsedTimeFromStringDate(item.createdAt) ??
                      '',
              isEditable: true,
              onActionTap: () {
                _openBottomSheetOption(context, item);
              },
              onImageCompanyTap: () {
                if (!_controller.isNetworkConnected) return;
                SharedGlobalDataService.onCompanyTap(item.company);
              },
              onAddressTextTap: (location) async {
                await helper.lunchMapWithLocation(
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

  void _openBottomSheetOption(
    BuildContext context,
    CompanyJobModel item,
  ) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
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
              title: 'delete'.tr,
              icon: Image.asset(
                JobstopPngImg.deleted,
                color: _controller.savedJobState.selectedOption == 1
                    ? Colors.white
                    : Jobstopcolor.primarycolor,
                height: context.height / 32,
              ),
              onTap: () {
                Get.back();
                print("delete saved job with id: ${item.id}");
                _controller.savedJobState.selectedOption = 1;
                _controller.onRemoveOptionSubmitted(item.id);
              },
              isHavingTrailingIcon: false,
              isBordered: false,
              contentPadding: width / 12,
              isSelected: _controller.savedJobState.selectedOption == 1,
            ),
          ),
          Obx(
            () => SettingItemWidget(
              title: 'title_apply'.tr,
              icon: Image.asset(
                JobstopPngImg.applay,
                color: _controller.savedJobState.selectedOption == 2
                    ? Colors.white
                    : Jobstopcolor.primarycolor,
                height: context.height / 32,
              ),
              onTap: () async {
                Get.back();
                _controller.savedJobState.selectedOption = 2;
                _controller.jobDetailsId = item.id;
                _controller.requestedJobDetails = item;
                await Get.toNamed(SippoRoutes.userApplyJobs);
                _controller.clearRequestedJobDetails();
              },
              isHavingTrailingIcon: false,
              isBordered: false,
              contentPadding: width / 12,
              isSelected: _controller.savedJobState.selectedOption == 2,
            ),
          ),
        ],
      ),
    ).then((_) => _controller.savedJobState.selectedOption = -1);
  }

  Widget _buildErrorNewLoad(BuildContext context) {
    return InkWell(
      onTap: () {
        _controller.changeStates(isError: false, message: '');
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "error".tr,
          style: dmsbold.copyWith(
            color: Jobstopcolor.primarycolor,
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
              _controller.changeStates(isError: false, message: '');
            },
            text: 'try_again'.tr,
          ),
        )
      ],
    );
  }
}
