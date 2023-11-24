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
import 'package:jobspot/sippo_controller/sippo_search_controller/user_search_jobs.dart';
import 'package:jobspot/sippo_custom_widget/custom_body_widget.dart';
import 'package:jobspot/sippo_custom_widget/job_card_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';
import 'package:jobspot/sippo_pages/sippo_message_pages/no_items_found_message.dart';
import 'package:jobspot/utils/helper.dart';
import 'package:lottie/lottie.dart';

class SippoJobSearch extends StatefulWidget {
  const SippoJobSearch({Key? key}) : super(key: key);

  @override
  State<SippoJobSearch> createState() => _SippoJobSearchState();
}

class _SippoJobSearchState extends State<SippoJobSearch> {
  final _controller = SearchJobsController.instances;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 0.0,
        backgroundColor: Colors.transparent,
        notificationPredicate: (notification) {
          if (notification.metrics.pixels > kToolbarHeight) {
            _controller.searchJobsState.isHeightOverAppBar = true;
          } else {
            _controller.searchJobsState.isHeightOverAppBar = false;
          }
          return false;
        },
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _controller.searchJobsState.clearQuerySearch();
          _controller.refreshPage();
        },
        child: CustomBodyWidget.children(
          pinnedAppBar: true,
          automaticallyImplyLeading: true,
          expandedAppBarHeight: context.fromHeight(4.5),
          expandedAppBar: _buildScrollableTopAppBar(context, haveToolBar: true),
          leading: Obx(() {
            final isHeightOverAppBar =
                _controller.searchJobsState.isHeightOverAppBar;
            return IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back_rounded,
                color: isHeightOverAppBar ? Colors.black : Colors.white,
              ),
            );
          }),
          children: [
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: context.fromWidth(CustomStyle.paddingValue),
              ),
              sliver: PagedSliverList<int, CompanyJobModel>.separated(
                pagingController: _controller.pagingController,
                builderDelegate: PagedChildBuilderDelegate(
                  firstPageErrorIndicatorBuilder: (context) =>
                      _buildErrorFirstLoad(context),
                  newPageErrorIndicatorBuilder: (context) =>
                      _buildErrorNewLoad(context),
                  noItemsFoundIndicatorBuilder: (context) =>
                      NoItemsFoundMessageWidget.jobs(),
                  firstPageProgressIndicatorBuilder: (context) => Center(
                    child: Lottie.asset(
                      JobstopPngImg.loadingProgress,
                      height: context.height / 6,
                    ),
                  ),
                  itemBuilder: (context, item, index) {
                    return InkWell(
                      onTap: () => SharedGlobalDataService.onJobTap(item),
                      child: JobPostingCard(
                        jobDetails: item,
                        isActive: item.isActive,
                        timeAgo: item.createdAt != null
                            ? calculateElapsedTimeFromStringDate(item.createdAt)
                            : null,
                        isEditable: false,
                        isSaved: item.isSaved == true,
                        onImageCompanyTap: () =>
                            SharedGlobalDataService.onCompanyTap(
                          item.company,
                        ),
                        onAddressTextTap: (location) {
                          lunchMapWithLocation(
                            location?.dLatitude,
                            location?.dLongitude,
                          );
                        },
                      ),
                    );
                  },
                ),
                separatorBuilder: (context, _) => SizedBox(
                  height: context.fromHeight(CustomStyle.huge),
                ),
              ),
            )
          ],
        ),
      ),
    );
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
              _controller.refreshPage();
              _controller.changeStates(isError: false, message: '');
            },
            text: 'try_again'.tr,
          ),
        )
      ],
    );
  }

  Widget _buildScrollableTopAppBar(BuildContext context,
      {bool haveToolBar = false}) {
    return SingleChildScrollView(
      child: ColoredBox(
        color: SippoColor.backgroudHome,
        child: Column(
          children: [
            _buildTopSearchBar(context, haveToolBar: haveToolBar),
            SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
            _buildRequiredJobChipsList(context),
            SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
          ],
        ),
      ),
    );
  }

  Row _buildRequiredJobChipsList(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => Get.toNamed(SippoRoutes.sippoFilterOptionJobSearch),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.fromWidth(CustomStyle.paddingValue2),
            ),
            child: Container(
              height: context.height / 18,
              width: context.height / 18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: SippoColor.primarycolor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(JobstopPngImg.filter),
              ),
            ),
          ),
        ),
        SizedBox(
          height: context.height / 18,
          width: context.width / 1.22,
          child: Obx(() => ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount:
                    _controller.searchJobsState.employmentTypeList.length,
                itemBuilder: (context, index) {
                  final item =
                      _controller.searchJobsState.employmentTypeList[index];
                  return Obx(() => CustomChip(
                        borderRadius: context.fromWidth(CustomStyle.m),
                        margin: EdgeInsets.symmetric(
                          horizontal: context.fromWidth(
                            CustomStyle.spaceBetween,
                          ),
                        ),
                        backgroundColor:
                            _controller.searchJobsState.employmentType == item
                                ? SippoColor.primarycolor
                                : Colors.grey[300],
                        paddingValue:
                            context.fromWidth(CustomStyle.paddingValue2),
                        onTap: () {
                          _controller.onSelectedEmploymentTypeSubmitted(item);
                        },
                        child: Text(
                          item.title,
                          style: dmsregular.copyWith(
                            fontSize: 12,
                            color: _controller.searchJobsState.employmentType ==
                                    item
                                ? SippoColor.white
                                : SippoColor.primarycolor,
                          ),
                        ),
                      ));
                },
              )),
        ),
      ],
    );
  }

  Container _buildTopSearchBar(BuildContext context,
      {bool haveToolBar = false}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        color: SippoColor.primarycolor,
        // Change this to your desired color
        image: DecorationImage(
          image: AssetImage(JobstopPngImg.backgroundProf),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(
            context.fromHeight(CustomStyle.paddingValue),
          ),
          child: Column(
            children: [
              if (haveToolBar) SizedBox(height: kToolbarHeight),
              InputBorderedField(
                keyboardType: TextInputType.text,
                onFieldSubmitted: (value) {
                  if (!_controller.searchJobsState.textSearch.isTextEmpty) {
                    _controller.refreshPage();
                  }
                },
                gController: _controller.searchJobsState.textSearch,
                height: context.fromHeight(13.5),
                hintText: "Design".tr,
                fontSize: FontSize.paragraph2(context),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(
                    context.fromHeight(CustomStyle.xl),
                  ),
                  child: Image.asset(
                    JobstopPngImg.search,
                    height: context.fromHeight(CustomStyle.l),
                    width: context.fromHeight(CustomStyle.l),
                  ),
                ),
                textInputAction: TextInputAction.next,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
