import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/JobGlobalclass/jobstopimges.dart';
import 'package:sippo/JobGlobalclass/media_query_sizes.dart';
import 'package:sippo/JobGlobalclass/sippo_customstyle.dart';
import 'package:sippo/JobGlobalclass/text_font_size.dart';
import 'package:sippo/JobServices/shared_global_data_service.dart';
import 'package:sippo/sippo_controller/sippo_search_controller/general_search_users_view_controller.dart';
import 'package:sippo/sippo_custom_widget/custom_drop_down_button.dart';
import 'package:sippo/sippo_custom_widget/network_bordered_circular_image_widget.dart';
import 'package:sippo/sippo_custom_widget/rounded_border_radius_card_widget.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';
import 'package:sippo/sippo_data/model/profile_model/company_profile_resource_model/company_user_profile_view_model.dart';
import 'package:sippo/sippo_pages/sippo_message_pages/no_items_found_message.dart';
import 'package:lottie/lottie.dart';

class ShowGeneralSearchProfilesViewList extends StatefulWidget {
  const ShowGeneralSearchProfilesViewList({super.key});

  @override
  State<ShowGeneralSearchProfilesViewList> createState() =>
      _ShowGeneralSearchProfilesViewListState();
}

class _ShowGeneralSearchProfilesViewListState
    extends State<ShowGeneralSearchProfilesViewList> {
  final _controller = Get.put(GeneralSearchProfilesViewController());
  ScrollController _scrollController = ScrollController();
  double _previousScrollPosition = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    double currentScrollPosition = _scrollController.position.pixels;

    if (currentScrollPosition > _previousScrollPosition) {
      print('Scrolling down');
      if (!_controller.searchProfilesViewState.showFilterOptions) return;
      _controller.searchProfilesViewState.showFilterOptions = false;
    }
    // else if (currentScrollPosition < _previousScrollPosition) {
    //   // Scrolling up
    //   print('Scrolling up');
    // }
    _previousScrollPosition = currentScrollPosition;
  }

  @override
  void dispose() {
    _scrollController.removeListener(scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _controller.refreshPage();
      },
      child: Column(
        children: [
          SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
          Padding(
            padding: EdgeInsets.only(
              left: context.fromWidth(CustomStyle.paddingValue),
              right: context.fromWidth(CustomStyle.paddingValue),
              top: context.fromWidth(CustomStyle.huge),
              bottom: context.fromWidth(CustomStyle.xxl),
            ),
            child: Obx(() {
              final location = _controller.searchProfilesViewState;
              final padding = context.fromWidth(CustomStyle.paddingValue);
              final isExpanded =
                  _controller.searchProfilesViewState.showFilterOptions;
              return RoundedBorderRadiusCardWidget(
                padding: const EdgeInsets.all(8),
                child: ExpansionPanelList(
                  elevation: 0.0,
                  expansionCallback: (panelIndex, isExpanded) {
                    _controller.searchProfilesViewState.showFilterOptions =
                        isExpanded;
                  },
                  children: [
                    ExpansionPanel(
                      backgroundColor: Colors.white,
                      headerBuilder: (context, isExpanded) {
                        return ListTile(
                          titleAlignment: ListTileTitleAlignment.center,
                          leading: Icon(Icons.filter_alt_outlined),
                          horizontalTitleGap: 0.0,
                          title: Text('users_search_filter_panel'.tr),
                        );
                      },
                      canTapOnHeader: true,
                      body: Padding(
                        padding: EdgeInsets.only(
                          right: padding,
                          left: padding,
                          bottom: padding,
                        ),
                        child: Column(
                          children: [
                            CustomDropdownButton(
                              underLineBorder: true,
                              textHint: 'select_location_address'.tr,
                              labelList: location.locationsAddressNameList,
                              values: location.locationsAddressList,hintTextColor: Colors.black,
                              fillColor: SippoColor.backgroudHome,
                              onItemSelected: (value) async {
                                if (value == null ||
                                    value.id ==
                                        location.selectedLocationAddress.id)
                                  return;
                                location.selectedLocationAddress = value;
                                _controller.generalSearchController
                                    .refreshSearchPage();
                                print(value);
                              },
                              setInitialValue:
                                  location.selectedLocationAddress.id != null,
                              initialValue:
                                  location.selectedLocationAddress.name,
                            ),
                            SizedBox(
                              height: context.fromHeight(
                                CustomStyle.spaceBetween,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _showProfessionList(context);
                              },
                              child: SizedBox(
                                width: context.width,
                                child: RoundedBorderRadiusCardWidget(
                                    color: SippoColor.backgroudHome,
                                    child: Obx(() {
                                      final selected = _controller
                                          .searchProfilesViewState
                                          .selectedProfession
                                          .name;
                                      return Text(
                                        selected ?? 'selected_profession'.tr,style: dmsmedium,
                                      );
                                    })),
                              ),
                            )
                          ],
                        ),
                      ),
                      isExpanded: isExpanded,
                    ),
                  ],
                ),
              );
            }),
          ),
          Expanded(
            child: PagedListView<int, ProfileViewResourceModel>.separated(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              scrollController: _scrollController,
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
                noItemsFoundIndicatorBuilder: (context) =>
                    NoItemsFoundMessageWidget.users(alignmentFromStart: true),
                newPageProgressIndicatorBuilder: (context) =>
                    _buildNewPageProgress(context),
                firstPageProgressIndicatorBuilder: (context) => Center(
                  child: Lottie.asset(
                    JobstopPngImg.loadingProgress,
                    height: context.height / 6,
                  ),
                ),
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
                        errorWidget: (_, __, ___) => Image.asset(JobstopPngImg.signup),
                        placeholder: (_, __) => Image.asset(JobstopPngImg.signup),

                      ),
                      title: AutoSizeText(
                        item.userInfo?.name ?? '',
                        style: dmsmedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: AutoSizeText(
                        item.userInfo?.bio ?? '',
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
              ? Lottie.asset(
                  JobstopPngImg.loadingProgress,
                  height: context.height / 9,
                )
              : SizedBox(
                  width: context.width / 2,
                  child: CustomButton(
                    onTapped: () =>
                        _controller.onLoadMoreProfilesViewSubmitted(),
                    text: '${'load_more'.tr}...',
                    backgroundColor: Colors.transparent,
                    textColor: SippoColor.primarycolor,
                    borderColor: SippoColor.primarycolor,
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

  void _showProfessionList(BuildContext context) {
    final professions = _controller.searchProfilesViewState.professions;
    if (professions.isEmpty) {
      _controller.fetchProfessions();
    }
    Get.dialog(Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: SizedBox(
        height: context.fromHeight(1.3),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: context.fromWidth(CustomStyle.s),
            horizontal: context.fromWidth(CustomStyle.s),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InputBorderedField(
                fillColor: SippoColor.backgroudHome,
                hintText: 'search'.tr,
                prefixIcon: Icon(Icons.search_rounded),
                onTextChanged: (value) {
                  _controller.searchProfilesViewState.searchProfessionKey =
                      value;
                },
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: context.fromHeight(CustomStyle.paddingValue),
                  bottom: context.fromHeight(CustomStyle.huge),
                ),
                child: SizedBox(
                  width: context.width,
                  child: Text(
                    'profession_title'.tr,
                    style: dmsbold.copyWith(
                        fontSize: FontSize.title5(context),
                        color: SippoColor.primarycolor),
                  ),
                ),
              ),
              Obx(() {
                final searchKey =
                    _controller.searchProfilesViewState.searchProfessionKey;
                final professionsItems = _controller.searchProfilesViewState
                    .filteredProfession(searchKey);
                if (professionsItems.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: professionsItems.length,
                      itemBuilder: (context, index) {
                        final item = professionsItems[index];
                        return ListTile(
                          tileColor: item ==
                                  _controller.searchProfilesViewState
                                      .selectedProfession
                              ? SippoColor.backgroudHome
                              : null,
                          onTap: () {
                            _controller.searchProfilesViewState
                                .selectedProfession = item;
                            _controller.generalSearchController
                                .refreshSearchPage();
                            if (Get.isOverlaysOpen) Navigator.pop(context);
                          },
                          titleAlignment: ListTileTitleAlignment.center,
                          title: Text(
                            item.name ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: dmsmedium,
                          ),
                        );
                      },
                    ),
                  );
                } else if (_controller.fetchProfessionsStates.isError) {
                  final msg = _controller.fetchProfessionsStates.message;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        msg ?? "",
                        textAlign: TextAlign.center,
                      ),
                      IconButton(
                        onPressed: () {
                          _controller.fetchProfessions();
                        },
                        icon: Icon(Icons.refresh),
                      )
                    ],
                  );
                } else if (_controller.fetchProfessionsStates.isLoading) {
                  return Center(
                    child: Lottie.asset(
                      JobstopPngImg.loadingProgress,
                      height: context.height / 9,
                    ),
                  );
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "no_professions_found".tr,
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                      onPressed: () => _controller.fetchProfessions(),
                      icon: Icon(Icons.refresh),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    )).then((value) {
      _controller.searchProfilesViewState.searchProfessionKey = "";
    });
  }
}
