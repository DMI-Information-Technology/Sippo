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
import 'package:sippo/sippo_controller/company_display_posts_job_controller/company_show_posts_controller.dart';
import 'package:sippo/sippo_custom_widget/company_post_widget.dart';
import 'package:sippo/sippo_custom_widget/container_bottom_sheet_widget.dart';
import 'package:sippo/sippo_custom_widget/setting_item_widget.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';
import 'package:sippo/sippo_data/model/profile_model/company_profile_resource_model/company_post_model.dart';
import 'package:sippo/sippo_pages/sippo_message_pages/no_items_found_message.dart';
import 'package:sippo/utils/helper.dart';
import 'package:lottie/lottie.dart';

class ShowCompanyPostsList extends StatefulWidget {
  const ShowCompanyPostsList({super.key});

  @override
  State<ShowCompanyPostsList> createState() => _ShowCompanyPostsListState();
}

class _ShowCompanyPostsListState extends State<ShowCompanyPostsList> {
  final _controller = Get.put(CompanyShowPostsController());

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
            return Obx(
              () => PostWidget(
                authorName: _controller.company.name ?? '',
                imageProfileUrl: _controller.company.profileImage?.url,
                timeAgo: calculateElapsedTimeFromStringDate(
                      item.createdAt,
                    ) ??
                    "",
                postTitle: item.title ?? "",
                postContent: item.body ?? "",
                imageUrl: item.image?.url,
                isCompany: true,
                onActionButtonPresses: () {
                  _openBottomPostSheetOption(context, item.id);
                },
              ),
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

  void _openBottomPostSheetOption(
    BuildContext context,
    int? postId,
  ) {
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
              title: "delete".tr,
              icon: Icon(Icons.delete_forever_outlined),
              onTap: () async {
                Get.back();
                _showConfirmDeleteDialog(context, postId);
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
                Get.toNamed(SippoRoutes.companyAddPost)?.then(
                  (result) {
                    _controller.refreshPostsAfterEdit(result);
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

  void _showConfirmDeleteDialog(BuildContext context, int? postId) {
    Get.dialog(
      CustomAlertDialog(
        title: 'delete_post'.tr,
        description: 'confirm_delete_post'.tr,
        onConfirm: () async {
          Get.back();
          await _controller.onDeletePostSubmitted(postId);
        },
        onCancel: () {
          Get.back();
        },
      ),
    );
  }
}
