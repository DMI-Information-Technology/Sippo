import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/JobGlobalclass/jobstopimges.dart';
import 'package:sippo/JobGlobalclass/media_query_sizes.dart';
import 'package:sippo/JobGlobalclass/sippo_customstyle.dart';
import 'package:sippo/JobGlobalclass/text_font_size.dart';
import 'package:sippo/sippo_controller/user_community_controller/show_about_companies_posts_controller.dart';
import 'package:sippo/sippo_custom_widget/company_post_widget.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';
import 'package:sippo/sippo_data/model/profile_model/company_profile_resource_model/company_post_model.dart';
import 'package:sippo/sippo_pages/sippo_message_pages/no_items_found_message.dart';
import 'package:sippo/utils/helper.dart';
import 'package:lottie/lottie.dart';

class ShowAboutCompaniesPostsList extends StatefulWidget {
  const ShowAboutCompaniesPostsList({super.key});

  @override
  State<ShowAboutCompaniesPostsList> createState() =>
      _ShowAboutCompaniesPostsListState();
}

class _ShowAboutCompaniesPostsListState
    extends State<ShowAboutCompaniesPostsList> {
  final _controller = Get.put(ShowAboutsCompaniesPostsController());

  @override
  Widget build(BuildContext context) {
    return PagedSliverList<int, CompanyDetailsPostModel>.separated(
      pagingController: _controller.pagingController,
      builderDelegate: PagedChildBuilderDelegate(
        firstPageErrorIndicatorBuilder: (context) =>
            _buildErrorFirstLoad(context),
        newPageErrorIndicatorBuilder: (context) => _buildErrorNewLoad(context),
        noItemsFoundIndicatorBuilder: (context) =>
            NoItemsFoundMessageWidget.posts(
          alignmentFromStart: true,
        ),
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
                    DateTime.now().toString(),
                  ) ??
                  "",
              postTitle: item.title ?? "",
              postContent: item.body ?? "",
              imageUrl: item.image?.url,
              isCompany: false,
              onActionButtonPresses: () {},
            ),
          );
        },
      ),
      separatorBuilder: (_, __) => SizedBox(
        height: context.fromHeight(CustomStyle.spaceBetween),
      ),
    );
  }

  Widget _buildErrorNewLoad(BuildContext context) {
    return InkWell(
      onTap: () {},
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
              _controller.states =
                  _controller.states.copyWith(isError: false, message: '');
            },
            text: 'try_again'.tr,
          ),
        )
      ],
    );
  }
}
