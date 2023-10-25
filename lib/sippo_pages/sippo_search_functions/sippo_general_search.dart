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
import 'package:jobspot/JopController/sippo_search_controller/general_search_controller.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/sippo_pages/sippo_search_functions/show_general_search_companies.dart';
import 'package:jobspot/sippo_pages/sippo_search_functions/show_general_search_jobs.dart';

import 'show_general_search_profiles_view.dart';

class SippoGeneralSearch extends StatefulWidget {
  const SippoGeneralSearch({super.key});

  @override
  State<SippoGeneralSearch> createState() => _SippoGeneralSearchState();
}

class _SippoGeneralSearchState extends State<SippoGeneralSearch>
    with SingleTickerProviderStateMixin, RestorationMixin {
  late final TabController _tabController;
  final RestorableInt tabIndex = RestorableInt(0);

  @override
  get restorationId => "tab_non_scrollable_view";

  @override
  void restoreState(oldBucket, initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }

  final _controller = UserGeneralSearchController.instance;
  final _tabs = [
    const ShowGeneralSearchCompaniesList(),
    const ShowGeneralSearchJobsList(),
    if (GlobalStorageService.isCompany)
      const ShowGeneralSearchProfilesViewList(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    _tabController.addListener(() {
      // When the tab controller's value is updated, make sure to update the
      // tab index value, which is state restorable.
      _controller.resetStates();
      _controller.generalSearchState.tabsIndex = _tabController.index;
      tabIndex.value = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
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
      controller: _tabController,
      children: _tabs,
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
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
        hintText: 'Search...',
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
      controller: _tabController,
      onTap: (value) {
        _controller.resetStates();
        _controller.generalSearchState.tabsIndex = value;
      },
      unselectedLabelColor: Jobstopcolor.grey,
      labelColor: Jobstopcolor.primarycolor,
      labelStyle: dmsmedium.copyWith(
        fontSize: FontSize.title5(context),
      ),
      tabs: [
        const Tab(text: "Companies"),
        const Tab(text: 'Jobs'),
        if (GlobalStorageService.isCompany) const Tab(text: 'Customers'),
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
              color: Jobstopcolor.primarycolor,
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
              color: Jobstopcolor.primarycolor,
            ),
          );
  }
}
