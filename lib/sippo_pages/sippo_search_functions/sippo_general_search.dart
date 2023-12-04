import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/global_storage.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/JobServices/shared_global_data_service.dart';
import 'package:jobspot/sippo_controller/sippo_search_controller/general_search_controller.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/sippo_pages/sippo_search_functions/show_general_search_companies.dart';
import 'package:jobspot/sippo_pages/sippo_search_functions/show_general_search_jobs.dart';

import 'show_general_search_profiles_view.dart';
import 'show_general_top_search.dart';

class SippoGeneralSearch extends StatefulWidget {
  const SippoGeneralSearch({super.key});

  @override
  State<SippoGeneralSearch> createState() => _SippoGeneralSearchState();
}

class _SippoGeneralSearchState extends State<SippoGeneralSearch>
    with SingleTickerProviderStateMixin, RestorationMixin {
  @override
  get restorationId => "tab_non_scrollable_view";

  @override
  void restoreState(oldBucket, initialRestore) {
    registerForRestoration(_controller.tabIndex, 'tab_index');
    _controller.tabController.index = _controller.tabIndex.value;
  }

  final _controller = GeneralSearchController.instance;
  final _tabs = [
    const SippoGeneralTopSearch(),
    const ShowGeneralSearchCompaniesList(),
    const ShowGeneralSearchJobsList(),
    if (GlobalStorageService.isCompany)
      const ShowGeneralSearchProfilesViewList(),
  ];

  @override
  void initState() {
    super.initState();
    _controller.tabController =
        TabController(initialIndex: 0, length: 4, vsync: this);
    _controller.tabController.addListener(() {
      // When the tab controller's value is updated, make sure to update the
      // tab index value, which is state restorable.
      _controller.generalSearchState.tabsIndex =
          _controller.tabController.index;
      _controller.tabIndex.value = _controller.tabController.index;
    });
  }

  @override
  void dispose() {
    _controller.tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildTabBarView(context),
    );
  }

  Widget _buildTabBarView(BuildContext context) {
    return TabBarView(
      controller: _controller.tabController,
      children: _tabs,
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      notificationPredicate: (notification) {
        return false;
      },
      toolbarHeight:
          kToolbarHeight + context.fromHeight(CustomStyle.paddingValue),
      leading: Obx(
        () => _buildLeadingAppBarButton(
          context,
          _controller.generalSearchState.hasFocus,
        ),
      ),
      titleSpacing: 0.0,
      title: InputBorderedField(
        gController: _controller.generalSearchState.searchController,
        focusNode: _controller.generalSearchState.focusNode,
        hintText: '${'search'.tr}...',
        hintStyle: TextStyle(
          fontSize: FontSize.title6(context),
        ),
        onTextChanged: (_) {
          _controller.onSearchSubmitted();
        },
        suffixIcon: InkWell(
          onTap: () {
            _controller.onClearSearchFiledSubmitted();
          },
          child: Icon(Icons.close),
        ),
      ),
      actions: [
        Obx(
          () => _buildFilterJobActionButton(
            context,
            _controller.generalSearchState.isJobTab,
          ),
        ),
      ],
      bottom: _buildTabBar(context),
    );
  }

  TabBar _buildTabBar(BuildContext context) {
    return TabBar(
      controller: _controller.tabController,
      onTap: (value) {
        _controller.generalSearchState.tabsIndex = value;
      },
      unselectedLabelColor: SippoColor.grey,
      labelColor: SippoColor.primarycolor,
      labelStyle: dmsmedium.copyWith(
        fontSize: FontSize.title5(context),
      ),
      isScrollable: GlobalStorageService.isCompany,
      tabs: [
        Tab(
          text: "top".tr,
        ),
        Tab(text: "companies".tr),
        Tab(text: 'jobs'.tr),
        if (GlobalStorageService.isCompany) Tab(text: 'users'.tr),
      ],
    );
  }

  Widget _buildFilterJobActionButton(BuildContext context, bool isJobTab) {
    return isJobTab
        ? IconButton(
            alignment: Alignment.center,
            onPressed: () async {
              SharedGlobalDataService.instance.searchTextKey =
                  _controller.generalSearchState.searchController.text;
              await Get.toNamed(SippoRoutes.sippoJobFilterSearch);
              SharedGlobalDataService.instance.searchTextKey = '';
            },
            icon: Icon(
              Icons.filter_alt_outlined,
              color: SippoColor.primarycolor,
            ),
          )
        : SizedBox(
            width: context.fromWidth(
              CustomStyle.spaceBetween,
            ),
          );
  }

  Widget _buildLeadingAppBarButton(BuildContext context, bool isBack) {
    return isBack
        ? InkWell(
            onTap: () => Get.back(),
            child: Icon(Icons.arrow_back_rounded),
          )
        : InkWell(
            onTap: () {
              _controller.onSearchSubmitted();
            },
            child: Icon(
              Icons.search_rounded,
              color: SippoColor.primarycolor,
            ),
          );
  }
}
