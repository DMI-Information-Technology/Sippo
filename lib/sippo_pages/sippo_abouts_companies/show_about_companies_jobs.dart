import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/JopController/user_community_controller/show_about_companies_jobs_controller.dart';
import 'package:jobspot/sippo_custom_widget/job_card_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';
import 'package:jobspot/utils/helper.dart';

class ShowAboutCompaniesJobsList extends StatefulWidget {
  const ShowAboutCompaniesJobsList({super.key});

  @override
  State<ShowAboutCompaniesJobsList> createState() =>
      _ShowAboutCompaniesJobsListState();
}

class _ShowAboutCompaniesJobsListState
    extends State<ShowAboutCompaniesJobsList> {
  final _controller = Get.put(ShowAboutsCompaniesJobsController());

  @override
  Widget build(BuildContext context) {
    return PagedSliverList<int, CompanyJobModel>.separated(
      pagingController: _controller.pagingController,
      builderDelegate: PagedChildBuilderDelegate(
        firstPageErrorIndicatorBuilder: (context) =>
            _buildErrorFirstLoad(context),
        newPageErrorIndicatorBuilder: (context) => _buildErrorNewLoad(context),
        itemBuilder: (context, item, index) {
          return JobPostingCard(
            jobDetails: item,
            companyName: _controller.company.name,
            imagePath: _controller.company.profileImage?.url,
            timeAgo: calculateElapsedTimeFromStringDate(item.createdAt),
            isEditable: false,
            isSaved: item.isSaved == true,
            onActionTap: () {
              _controller.onToggleSavedJobsSubmitted(index, item.id);
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
          _controller.states.message ?? 'Something wrong is happened.',
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
              _controller.retryLastFailedRequest();
              _controller.states =
                  _controller.states.copyWith(isError: false, message: '');
            },
            text: 'Try again',
          ),
        )
      ],
    );
  }
}
