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

class ShowGeneralTopSearchJobsList extends StatefulWidget {
  const ShowGeneralTopSearchJobsList({super.key});

  @override
  State<ShowGeneralTopSearchJobsList> createState() =>
      _ShowGeneralTopSearchJobsListState();
}

class _ShowGeneralTopSearchJobsListState
    extends State<ShowGeneralTopSearchJobsList> {
  final _controller = Get.put(GeneralTopSearchJobsController());

  @override
  Widget build(BuildContext context) {
    return PagedSliverList<int, CompanyJobModel>.separated(
      pagingController: _controller.pagingController,
      builderDelegate: PagedChildBuilderDelegate(
        firstPageErrorIndicatorBuilder: (context) =>
            _buildErrorFirstLoad(context),
        newPageErrorIndicatorBuilder: (context) => _buildErrorNewLoad(context),
        newPageProgressIndicatorBuilder: (context) =>
            _buildNewPageProgress(context),
        firstPageProgressIndicatorBuilder: (context) => const SizedBox.shrink(),
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
              onActionTap: GlobalStorageService.appUse == AppUsingType.user
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
    );
  }

  Widget _buildNewPageProgress(BuildContext context) {
    return Center(
      child:
          // _controller.states.isLoading
          //     ? Lottie.asset(
          //         JobstopPngImg.loadingProgress,
          //         height: context.height / 9,
          //       )
          //     :
          Padding(
        padding: EdgeInsets.only(
          bottom: context.fromHeight(CustomStyle.paddingValue),
        ),
        child: SizedBox(
          width: context.width / 2,
          child: CustomButton(
            onTapped: () {
              _controller.generalSearchController.tabController.index = 2;
              if (Get.isRegistered<GeneralSearchJobsController>()) {
                GeneralSearchJobsController.instance.refreshPage();
              }
            },
            text: '${'load_more'.tr}...',
            backgroundColor: Colors.transparent,
            textColor: SippoColor.primarycolor,
            borderColor: SippoColor.primarycolor,
          ),
        ),
      ),
    );
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
          'error'.tr,
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
              _controller.retryLastFailedRequest();
            },
            text: 'try_again'.tr,
          ),
        )
      ],
    );
  }
}
