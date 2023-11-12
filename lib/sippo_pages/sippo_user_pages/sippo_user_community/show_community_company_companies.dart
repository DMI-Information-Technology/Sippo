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
import 'package:jobspot/sippo_controller/user_community_controller/user_show_community_companies_controller.dart';
import 'package:jobspot/sippo_custom_widget/rounded_border_radius_card_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/sippo_data/model/auth_model/company_response_details.dart';

import 'package:jobspot/sippo_custom_widget/network_bordered_circular_image_widget.dart';
import 'package:jobspot/sippo_pages/sippo_message_pages/no_items_found_message.dart';
import 'package:lottie/lottie.dart';

class ShowCommunityCompanyCompaniesList extends StatefulWidget {
  const ShowCommunityCompanyCompaniesList({super.key});

  @override
  State<ShowCommunityCompanyCompaniesList> createState() =>
      _ShowCommunityCompanyCompaniesListState();
}

class _ShowCommunityCompanyCompaniesListState
    extends State<ShowCommunityCompanyCompaniesList> {
  final _controller = Get.put(UserShowCommunityCompaniesController());

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => _controller.refreshPage(),
      child: PagedGridView<int, CompanyDetailsModel>(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 2 / 2.7,
        ),
        pagingController: _controller.pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          firstPageErrorIndicatorBuilder: (context) =>
              _buildErrorFirstLoad(context),
          newPageErrorIndicatorBuilder: (context) =>
              _buildErrorNewLoad(context),
          noItemsFoundIndicatorBuilder: (context) =>
              NoItemsFoundMessageWidget.companies(),
          firstPageProgressIndicatorBuilder: (context) => Center(
            child: Lottie.asset(
              JobstopPngImg.loadingProgress,
              height: context.height / 6,
            ),
          ),
          itemBuilder: (context, item, index) {
            return InkWell(
              onTap: () => _onCompanyCardTapped(item),
              child: ConnectionCard(
                imageUrl: item.profileImage?.url??"",
                connectionName: item.name ?? '',
                isFollowing: item.isFollowed == true,
                onFollowTapped: () => _controller.onToggleSubmitted(item),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildErrorNewLoad(BuildContext context) {
    final showWrapperController = _controller.communityController;
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
    final showWrapperController = _controller.communityController;

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

  void _onCompanyCardTapped(CompanyDetailsModel company) async {
    final companyDashBoardState =
        SharedGlobalDataService.instance.companyGlobalState;
    companyDashBoardState.id = company.id ?? -1;
    companyDashBoardState.details = company;
    await Get.toNamed(SippoRoutes.sippoAboutCompanies);
    if (companyDashBoardState.details?.isFollowed != company.isFollowed) {
      _controller.changeFollowingState(
        companyDashBoardState.details,
        (isFollowing) => isFollowing == true,
      );
    }
    companyDashBoardState.clearDetails(() => CompanyDetailsModel());
  }
}

class ConnectionCard extends StatelessWidget {
  final String? imageUrl;
  final String? connectionName;
  final String? followerCount;
  final bool isFollowing;
  final VoidCallback? onFollowTapped;

  ConnectionCard({
    this.imageUrl,
    this.connectionName,
    this.followerCount,
    this.isFollowing = false,
    this.onFollowTapped,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    print(this.isFollowing);
    return RoundedBorderRadiusCardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NetworkBorderedCircularImage(
            outerBorderColor: SippoColor.primarycolor,
            size: height / 12,
            imageUrl: imageUrl ?? "",
            errorWidget: (context, url, error) {
              return Image.asset(
                JobstopPngImg.companysignup,
              );
            },
          ),
          SizedBox(height: height / 46),
          if (connectionName != null) ...[
            Text(
              connectionName!,
              style: TextStyle(
                fontSize: FontSize.title5(context),
                color: Colors.black87,
              ),
            ),
            SizedBox(height: height / 100),
          ],
          if (followerCount != null) ...[
            Text(
              followerCount!,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: height / 60,
            ),
          ],
          SizedBox(
            height: height / 21,
            width: context.width / 3.5,
            child: CustomButton(
              onTapped: () => {if (onFollowTapped != null) onFollowTapped!()},
              text: isFollowing ? 'followed'.tr : 'follow'.tr,
              textColor: isFollowing ? null : Colors.black87,
              backgroundColor: isFollowing ? null : Colors.white,
              borderColor: isFollowing ? null : Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
