import 'package:auto_size_text/auto_size_text.dart';
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
import 'package:sippo/JobServices/shared_global_data_service.dart';
import 'package:sippo/sippo_controller/sippo_search_controller/general_search_companies_controller.dart';
import 'package:sippo/sippo_custom_widget/network_bordered_circular_image_widget.dart';
import 'package:sippo/sippo_custom_widget/rounded_border_radius_card_widget.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';
import 'package:sippo/sippo_data/model/auth_model/company_response_details.dart';
import 'package:sippo/sippo_pages/sippo_message_pages/no_items_found_message.dart';
import 'package:lottie/lottie.dart';

class ShowGeneralTopSearchCompaniesList extends StatefulWidget {
  const ShowGeneralTopSearchCompaniesList({super.key});

  @override
  State<ShowGeneralTopSearchCompaniesList> createState() =>
      _ShowGeneralTopSearchCompaniesListState();
}

class _ShowGeneralTopSearchCompaniesListState
    extends State<ShowGeneralTopSearchCompaniesList> {
  final _controller = Get.put(GeneralTopSearchCompaniesController());

  @override
  Widget build(BuildContext context) {
    return PagedSliverList<int, CompanyDetailsModel>.separated(
      pagingController: _controller.pagingController,
      builderDelegate: PagedChildBuilderDelegate(
        firstPageErrorIndicatorBuilder: (context) =>
            _buildErrorFirstLoad(context),
        newPageErrorIndicatorBuilder: (context) => _buildErrorNewLoad(context),
        newPageProgressIndicatorBuilder: (context) =>
            _buildNewPageProgress(context),
        noItemsFoundIndicatorBuilder: (context) =>
            NoItemsFoundMessageWidget(alignmentFromStart: true),
        firstPageProgressIndicatorBuilder: (context) => Center(
          child: Lottie.asset(
            JobstopPngImg.loadingProgress,
            height: context.height / 6,
          ),
        ),
        itemBuilder: (context, item, index) {
          return RoundedBorderRadiusCardWidget(
            padding: EdgeInsets.zero,
            child: ListTile(
              onTap: () {
                _onCompanyCardTapped(item);
              },
              titleAlignment: ListTileTitleAlignment.center,
              leading: NetworkBorderedCircularImage(
                imageUrl: item.profileImage?.url ?? '',
                size: context.fromHeight(21),
                outerBorderColor: Colors.grey[300],
                outerBorderWidth: context.fromWidth(CustomStyle.huge2),

                errorWidget: (_, __, ___) => Image.asset(JobstopPngImg.companysignup),
                placeholder: (_, __) => Image.asset(JobstopPngImg.companysignup),
              ),
              title: AutoSizeText(
                item.name ?? '',
                style: dmsmedium,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: AutoSizeText(
                "${item.locations?.firstWhereOrNull((e) => e.isHQ == true)?.locationAddress?.name ?? ''}, ${item.establishmentDate ?? ''}",
                style: dmsregular,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        },
      ),
      separatorBuilder: (_, __) => SizedBox(
        height: context.fromHeight(CustomStyle.huge),
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
          InkWell(
            onTap: () {
              _controller.retryLastFailedRequest();
            },
            child: Icon(
              Icons.refresh,
              color: SippoColor.primarycolor,
            ),
          ),
        ],
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
                    onTapped: () {
                      _controller.generalSearchController.tabController.index =
                          1;
                      if (Get.isRegistered<
                          GeneralSearchCompaniesController>()) {
                        GeneralSearchCompaniesController.instance.refreshPage();
                      }
                    },
                    text: '${'load_more'.tr}...',
                    backgroundColor: Colors.transparent,
                    textColor: SippoColor.primarycolor,
                    borderColor: SippoColor.primarycolor,
                  ),
                ),
        ));
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
              _controller.retryLastFailedRequest();
            },
            text: 'try_again'.tr,
          ),
        )
      ],
    );
  }

  void _onCompanyCardTapped(CompanyDetailsModel company) async {
    final companyDashBoardState =
        SharedGlobalDataService.instance.companyGlobalState;
    companyDashBoardState.id = company.id ?? -1;
    companyDashBoardState.details = company;
    await Get.toNamed(SippoRoutes.sippoAboutCompanies);
    companyDashBoardState.clearDetails(() => CompanyDetailsModel());
  }
}
