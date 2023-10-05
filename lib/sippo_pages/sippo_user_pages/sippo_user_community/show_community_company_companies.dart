import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/JobServices/shared_global_data_service.dart';
import 'package:jobspot/sippo_custom_widget/save_job_card_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/sippo_data/model/auth_model/company_response_details.dart';

import '../../../JobGlobalclass/jobstopimges.dart';
import '../../../JobGlobalclass/sippo_customstyle.dart';
import '../../../JopController/user_community_controller/user_show_community_companies_controller.dart';
import '../../../sippo_custom_widget/rounded_border_radius_card_widget.dart';

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
      child: PagedGridView<int, CompanyDetailsResponseModel>(
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
          itemBuilder: (context, item, index) {
            return InkWell(
              onTap: () => _onCompanyCardTapped(item),
              child: ConnectionCard(
                imageUrl: 'https://www.designbust.com/download/1060/'
                    'png/microsoft_logo_transparent512.png',
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
    final showWrapperController = _controller.communityController;

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
            onTapped: () {
              _controller.refreshPage();
              showWrapperController.changeStates(isError: false, message: '');
            },
            text: 'Try again',
          ),
        )
      ],
    );
  }

  void _onCompanyCardTapped(CompanyDetailsResponseModel company) async {
    final companyDashBoardState =
        SharedGlobalDataService.instance.companyDashboardState;
    companyDashBoardState.id = company.id ?? -1;
    companyDashBoardState.details = company;
    await Get.toNamed(SippoRoutes.sippoAboutCompanies);
    if (companyDashBoardState.details.isFollowed != company.isFollowed) {
      _controller.changeFollowingState(
        companyDashBoardState.details,
        (isFollowing) => isFollowing == true,
      );
    }
    companyDashBoardState.clearDetails(() => CompanyDetailsResponseModel());
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
            outerBorderColor: Jobstopcolor.primarycolor,
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
              text: isFollowing ? 'Followed' : 'Follow',
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
