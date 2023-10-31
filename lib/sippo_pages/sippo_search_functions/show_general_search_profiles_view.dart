import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/JobServices/shared_global_data_service.dart';
import 'package:jobspot/sippo_controller/sippo_search_controller/general_search_users_view_controller.dart';
import 'package:jobspot/sippo_custom_widget/network_bordered_circular_image_widget.dart';
import 'package:jobspot/sippo_custom_widget/rounded_border_radius_card_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/company_user_profile_view_model.dart';

import '../../sippo_custom_widget/custom_drop_down_button.dart';

class ShowGeneralSearchProfilesViewList extends StatefulWidget {
  const ShowGeneralSearchProfilesViewList({super.key});

  @override
  State<ShowGeneralSearchProfilesViewList> createState() =>
      _ShowGeneralSearchProfilesViewListState();
}

class _ShowGeneralSearchProfilesViewListState
    extends State<ShowGeneralSearchProfilesViewList> {
  final _controller = Get.put(GeneralSearchProfilesViewController());

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _controller.refreshPage();
      },
      child: Column(
        children: [
          SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
          Obx(() {
            final location = _controller.searchProfilesViewState;
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.fromWidth(CustomStyle.paddingValue),
              ),
              child: CustomDropdownButton(
                underLineBorder: true,
                textHint: 'Select your location place.',
                labelList: location.locationsAddressNameList,
                values: location.locationsAddressList,
                fillColor: Colors.white,
                onItemSelected: (value) async {
                  if (value == null ||
                      value.id == location.selectedLocationAddress.id) return;
                  location.selectedLocationAddress = value;
                  _controller.generalSearchController.refreshSearchPage();
                  print(value);
                },
                setInitialValue: location.selectedLocationAddress.id != null,
                initialValue: location.selectedLocationAddress.name,
              ),
            );
          }),
          Expanded(
            child: PagedListView<int, ProfileViewResourceModel>.separated(
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
                newPageProgressIndicatorBuilder: (context) {
                  return _buildNewPageProgress(context);
                },
                itemBuilder: (context, item, i) {
                  return RoundedBorderRadiusCardWidget(
                    padding: EdgeInsets.zero,
                    child: ListTile(
                      onTap: () {
                        SharedGlobalDataService.onProfileViewTap(item: item);
                      },
                      titleAlignment: ListTileTitleAlignment.center,
                      leading: NetworkBorderedCircularImage(
                        imageUrl: item.image?.url ?? '',
                        size: context.fromHeight(21),
                        outerBorderColor: Colors.grey[300],
                        outerBorderWidth: context.fromWidth(CustomStyle.huge2),
                        errorWidget: (_, __, ___) => const CircleAvatar(),
                      ),
                      title: AutoSizeText(
                        item.userInfo?.name ?? '',
                        style: dmsmedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: AutoSizeText(
                        item.userInfo?.bio?.substring(0, 50) ?? '',
                        style: dmsregular,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                },
              ),
              separatorBuilder: (_, __) => SizedBox(
                height: context.fromHeight(CustomStyle.huge2),
              ),
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
                    onTapped: () =>
                        _controller.onLoadMoreProfilesViewSubmitted(),
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
            '${_controller.states.message}',
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
