import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/JobServices/shared_global_data_service.dart';
import 'package:jobspot/JopController/sippo_search_controller/general_search_controller.dart';
import 'package:jobspot/sippo_custom_widget/rounded_border_radius_card_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/sippo_pages/sippo_user_pages/sippo_user_search/show_general_search_companies.dart';
import 'package:jobspot/sippo_pages/sippo_user_pages/sippo_user_search/show_general_search_jobs.dart';

class SippoGeneralSearch extends StatefulWidget {
  const SippoGeneralSearch({super.key});

  @override
  State<SippoGeneralSearch> createState() => _SippoGeneralSearchState();
}

class _SippoGeneralSearchState extends State<SippoGeneralSearch> {
  final _controller = UserGeneralSearchController.instance;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: TabBarView(
          children: [
            // _buildCompaniesList(context),
            const ShowGeneralSearchCompaniesList(),
            const ShowGeneralSearchJobsList(),
          ],
        ),
      ),
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
        suffixIcon: InkWell(
          onTap: () {
            print(_controller.generalSearchState.searchController.text);
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
      onTap: (value) {
        _controller.generalSearchState.tabsIndex = value;
        _controller.generalSearchState.isJobTab = value == 1;
      },
      unselectedLabelColor: Jobstopcolor.grey,
      labelColor: Jobstopcolor.primarycolor,
      labelStyle: dmsmedium.copyWith(
        fontSize: FontSize.title5(context),
      ),
      tabs: [
        Tab(text: "Companies"),
        Tab(text: 'Jobs'),
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
              await Get.toNamed(SippoRoutes.sippoUserJobSearch);
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
