import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JopController/dashboards_controller/user_dashboard_controller.dart';
import 'package:jobspot/sippo_custom_widget/rounded_border_radius_card_widget.dart';
import 'package:jobspot/sippo_custom_widget/save_job_card_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';

import '../../../JobGlobalclass/jobstopcolor.dart';
import '../../../JobGlobalclass/jobstopfontstyle.dart';
import '../../../JobGlobalclass/text_font_size.dart';
import '../../../JopController/user_core_functions/general_search_controller.dart';

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
            _buildCompaniesList(context),
            _buildJobsList(context),
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
          _controller.generalSearchState.isArrowBack,
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
            _controller.generalSearchState.searchController.clearText();
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

  Widget _buildCompaniesList(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(
        vertical: context.fromHeight(CustomStyle.paddingValue),
        horizontal: context.fromWidth(CustomStyle.paddingValue),
      ),
      itemCount: 15,
      itemBuilder: (context, index) {
        return RoundedBorderRadiusCardWidget(
          padding: EdgeInsets.zero,
          child: ListTile(
            onTap: () {
              print('hello from company ListTile.');
            },
            titleAlignment: ListTileTitleAlignment.center,
            leading: CircleAvatar(
              radius: context.fromWidth(21),
            ),
            title: AutoSizeText(
              'Company Name Placeholder',
              style: dmsmedium,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: AutoSizeText(
              'Company Description Text Placeholder xxxxxx',
              style: dmsregular,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        height: context.fromHeight(CustomStyle.spaceBetween),
      ),
    );
  }

  ListView _buildJobsList(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(
        vertical: context.fromHeight(CustomStyle.paddingValue),
        horizontal: context.fromWidth(CustomStyle.paddingValue),
      ),
      itemCount: 15,
      itemBuilder: (context, index) {
        return JobPostingCard(
          onActionTap: () {},
          jobDetails: null,
          companyName: null,
          imagePath: null,
          onAddressTextTap: (location) {},
          timeAgo: '',
          isSaved: false,
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        height: context.fromHeight(CustomStyle.spaceBetween),
      ),
    );
  }

  Widget _buildFilterJobActionButton(BuildContext context, bool isJobTab) {
    return isJobTab
        ? IconButton(
            onPressed: () async {
              UserDashBoardController.instance.searchTextKey =
                  _controller.generalSearchState.searchController.text;
              await Get.toNamed(SippoRoutes.sippoUserJobSearch);
              UserDashBoardController.instance.searchTextKey = '';
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
            onTap: () {},
            child: Icon(
              Icons.search_rounded,
              color: Jobstopcolor.primarycolor,
            ),
          );
  }
}
