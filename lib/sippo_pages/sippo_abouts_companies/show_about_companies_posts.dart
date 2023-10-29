import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/JopController/user_community_controller/show_about_companies_posts_controller.dart';
import 'package:jobspot/sippo_custom_widget/company_post_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/company_post_model.dart';
import 'package:jobspot/utils/helper.dart';

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
        itemBuilder: (context, item, index) {
          return Obx(
            () => PostWidget(
              authorName: _controller.company.name ?? '',
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
          "Error",
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
