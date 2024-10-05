import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lottie/lottie.dart';
import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/JobGlobalclass/jobstopimges.dart';
import 'package:sippo/JobGlobalclass/media_query_sizes.dart';
import 'package:sippo/JobGlobalclass/sippo_customstyle.dart';
import 'package:sippo/JobGlobalclass/text_font_size.dart';
import 'package:sippo/sippo_controller/user_community_controller/user_show_community_posts_controller.dart';
import 'package:sippo/sippo_custom_widget/company_post_widget.dart';
import 'package:sippo/sippo_custom_widget/container_bottom_sheet_widget.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';
import 'package:sippo/sippo_data/model/profile_model/company_profile_resource_model/company_post_model.dart';
import 'package:sippo/sippo_data/repot_repo.dart';
import 'package:sippo/sippo_pages/sippo_message_pages/no_items_found_message.dart';
import 'package:sippo/utils/helper.dart';

class ShowCommunityCompanyPostsList extends StatefulWidget {
  const ShowCommunityCompanyPostsList({super.key});

  @override
  State<ShowCommunityCompanyPostsList> createState() =>
      _ShowCommunityCompanyPostsListState();
}

class _ShowCommunityCompanyPostsListState
    extends State<ShowCommunityCompanyPostsList> {
  final _controller = Get.put(UserShowCommunityPostsController());

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => _controller.refreshPage(),
      child: PagedListView<int, CompanyDetailsPostModel>.separated(
        pagingController: _controller.pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          firstPageErrorIndicatorBuilder: (context) =>
              _buildErrorFirstLoad(context),
          newPageErrorIndicatorBuilder: (context) =>
              _buildErrorNewLoad(context),
          noItemsFoundIndicatorBuilder: (context) =>
              NoItemsFoundMessageWidget.posts(),
          firstPageProgressIndicatorBuilder: (context) => Center(
            child: Lottie.asset(
              JobstopPngImg.loadingProgress,
              height: context.height / 6,
            ),
          ),
          itemBuilder: (context, item, index) {
            return PostWidget(
              authorName: item.company?.name ?? '',
              imageProfileUrl: item.company?.profileImage?.url,
              timeAgo: item.createdAt != null
                  ? calculateElapsedTimeFromStringDate(item.createdAt) ?? ''
                  : '',
              postTitle: item.title ?? "",
              postContent: item.body ?? "",
              imageUrl: item.image?.url,
              isCompany: false,
              onActionButtonPresses: () {
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
                      ListTile(
                        title: Text(
                          'report'.tr,
                          style: dmsmedium.copyWith(
                              fontSize: FontSize.title5(context)),
                        ),
                        onTap: () {
                          Get.back();
                          _showSubmitReportDialog(item);
                        },
                      )
                    ],
                  ),
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

  void _showSubmitReportDialog(CompanyDetailsPostModel post) {
    Get.dialog(
      AlertDialog(
        title: Text('Your report reason'),
        content: InputBorderedField(
          controller: _controller.postsState.reportReason,
          fillColor: SippoColor.backgroudHome,
          hintText: 'enter your report reason...',
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        contentPadding: EdgeInsets.all(context.width / 16),

        actionsAlignment: MainAxisAlignment.center,
        actions: [
          CustomButton(
            onTapped: () {
              Get.back();
              ReportRepo.report({
                "reason": _controller.postsState.reportReason.text,
                "reportable_type": "company",
                "reportable_id": post.id
              }).then((_) {
                _controller.postsState.reportReason.clear();
                Get.dialog(
                  AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    contentPadding: EdgeInsets.all(context.width / 16),
                    title: Text('Your report is submitted.'),
                    actions: [
                      CustomButton(
                        onTapped: () => Get.back(),
                        text: 'ok'.tr,
                      ),
                    ],
                  ),
                );
              });
            },
            text: 'ok'.tr,
          )
        ],
      ),
    );
  }

  Widget _buildErrorNewLoad(BuildContext context) {
    final showWrapperController = _controller.communityController;
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
    final showWrapperController = _controller.communityController;

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
}
