import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';

import '../../../JobGlobalclass/jobstopcolor.dart';
import '../../../JobGlobalclass/jobstopfontstyle.dart';
import '../../../JobGlobalclass/sippo_customstyle.dart';
import '../../../JobGlobalclass/text_font_size.dart';
import '../../../JopController/sippo_search_controller/genral_search_jobs_controller.dart';
import '../../../sippo_custom_widget/save_job_card_widget.dart';
import '../../../sippo_custom_widget/widgets.dart';
import '../../../sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';
import '../../../utils/helper.dart';

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
    return PagedListView<int, CompanyJobModel>.separated(
      padding: EdgeInsets.symmetric(
        vertical: context.fromHeight(CustomStyle.paddingValue),
        horizontal: context.fromWidth(CustomStyle.paddingValue),
      ),
      pagingController: _controller.pagingController,
      builderDelegate: PagedChildBuilderDelegate(
        firstPageErrorIndicatorBuilder: (context) =>
            _buildErrorFirstLoad(context),
        newPageErrorIndicatorBuilder: (context) => _buildErrorNewLoad(context),
        newPageProgressIndicatorBuilder: (context) =>
            _buildNewPageProgress(context),
        itemBuilder: (context, item, index) {
          return JobPostingCard(
            jobDetails: item,
            companyLocations: item.company?.locations,
            companyName: item.company?.name,
            imagePath: [
              'https://www.designbust.com/download/1060/png/microsoft_logo_transparent512.png',
              'https://logodownload.org/wp-content/uploads/2014/09/facebook-logo-1-2.png',
            ][index % 2 == 0 ? 0 : 1],
            timeAgo: '21 min ago',
            isEditable: false,
            onActionTap: () {},
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
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${_controller.generalSearchController.states.message}',
            textAlign: TextAlign.center,
            style: dmsregular.copyWith(
              fontSize: FontSize.paragraph3(context),
              color: Jobstopcolor.primarycolor,
            ),
          ),
          InkWell(
            onTap: () {
              _controller.retryLastFailedRequest();

            },
            child: Icon(
              Icons.refresh,
              color: Jobstopcolor.primarycolor,
            ),
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
          _controller.generalSearchController.states.message ??
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
