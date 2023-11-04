import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jobspot/JobGlobalclass/global_storage.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/JobServices/shared_global_data_service.dart';
import 'package:jobspot/sippo_controller/sippo_search_controller/genral_search_jobs_controller.dart';
import 'package:jobspot/sippo_custom_widget/job_card_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';
import 'package:jobspot/utils/app_use.dart';
import 'package:jobspot/utils/helper.dart';

class ShowGeneralSearchJobsList extends StatefulWidget {
  const ShowGeneralSearchJobsList({super.key});

  @override
  State<ShowGeneralSearchJobsList> createState() =>
      _ShowGeneralSearchJobsListState();
}

class _ShowGeneralSearchJobsListState extends State<ShowGeneralSearchJobsList> {
  final _controller = Get.put(GeneralSearchJobsController());

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _controller.refreshPage();
      },
      child: PagedListView<int, CompanyJobModel>.separated(
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
          newPageProgressIndicatorBuilder: (context) =>
              _buildNewPageProgress(context),
          itemBuilder: (context, item, index) {
            return InkWell(
              onTap: () {
                SharedGlobalDataService.onJobTap(item);
              },
              child: JobPostingCard(
                jobDetails: item,
                companyName: item.company?.name,
                onImageCompanyTap: () {
                  SharedGlobalDataService.onCompanyTap(item.company);
                },
                imagePath: item.company?.profileImage?.url,
                timeAgo: calculateElapsedTimeFromStringDate(item.createdAt),
                isEditable: GlobalStorageService.appUse != AppUsingType.user,
                isSaved: item.isSaved == true,
                onActionTap: GlobalStorageService.isUser
                    ? () {
                        _controller.onToggleSavedJobsSubmitted(item.id);
                      }
                    : null,
                onAddressTextTap: (location) async {
                  await lunchMapWithLocation(
                    location?.dLatitude,
                    location?.dLongitude,
                  );
                },
              ),
            );
          },
        ),
        separatorBuilder: (_, __) => SizedBox(
          height: context.fromHeight(CustomStyle.huge2),
        ),
      ),
    );
  }

  Widget _buildNewPageProgress(BuildContext context) {
    return Obx(() => Align(
          alignment: Alignment.center,
          child: _controller.states.isLoading
              ? const CircularProgressIndicator()
              : SizedBox(
                  width: context.width / 2,
                  child: CustomButton(
                    onTapped: () => _controller.onLoadMoreJobsSubmitted(),
                    text: 'Load More...',
                    backgroundColor: Colors.transparent,
                    textColor: Jobstopcolor.primarycolor,
                    borderColor: Jobstopcolor.primarycolor,
                  ),
                ),
        ));
  }

  Widget _buildErrorNewLoad(BuildContext context) {
    return InkWell(
      onTap: () => _controller.retryLastFailedRequest(),
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
          _controller.states.message ??
              'Something wrong is happened.',
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
            },
            text: 'Try again',
          ),
        )
      ],
    );
  }
}
