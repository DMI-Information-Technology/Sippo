import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';

import '../../../JobGlobalclass/routes.dart';
import '../../../JobGlobalclass/sippo_customstyle.dart';
import '../../../JopController/company_display_posts_job_controller/company_show_posts_controller.dart';
import '../../../sippo_custom_widget/company_post_widget.dart';
import '../../../sippo_custom_widget/container_bottom_sheet_widget.dart';
import '../../../sippo_custom_widget/setting_item_widget.dart';
import '../../../sippo_data/model/profile_model/company_profile_resource_model/company_post_model.dart';

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
      child: PagedListView<int, CompanyResponsePostModel>.separated(
        pagingController: _controller.pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          firstPageErrorIndicatorBuilder: (context) =>
              _buildErrorFirstLoad(context),
          newPageErrorIndicatorBuilder: (context) =>
              _buildErrorNewLoad(context),
          itemBuilder: (context, item, index) {
            return Obx(
              () => PostWidget(
                authorName: _controller.company.name ?? 'unknown',
                timeAgo: '21 minutes ago',
                postTitle: item.title ?? "unknown title",
                postContent: item.body ?? "unknown content",
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
            onTappeed: () {
              _controller.refreshPage();
              showWrapperController.changeStates(isError: false, message: '');
            },
            text: 'Try again',
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
              title: "Delete",
              icon: Icon(Icons.delete_forever_outlined),
              onTap: () async {
                Get.back();
                await _controller.onDeletePostSubmitted(postId);
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
}