import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/sippo_controller/sippo_search_controller/general_search_companies_controller.dart';
import 'package:jobspot/sippo_controller/sippo_search_controller/genral_search_jobs_controller.dart';
import 'package:jobspot/sippo_pages/sippo_search_functions/custom_general_search/show_general_top_search_companies.dart';
import 'package:jobspot/sippo_pages/sippo_search_functions/custom_general_search/show_general_top_search_jobs.dart';

class SippoGeneralTopSearch extends StatefulWidget {
  const SippoGeneralTopSearch({super.key});

  @override
  State<SippoGeneralTopSearch> createState() => _SippoGeneralTopSearchState();
}

class _SippoGeneralTopSearchState extends State<SippoGeneralTopSearch> {
  final topCompanies = const ShowGeneralTopSearchCompaniesList();
  final topJobs = const ShowGeneralTopSearchJobsList();

  Future<void> refreshTop() async {
    if (Get.isRegistered<GeneralTopSearchCompaniesController>()) {
      GeneralTopSearchCompaniesController.instance.refreshPage();
    }
    if (Get.isRegistered<GeneralTopSearchJobsController>()) {
      GeneralTopSearchJobsController.instance.refreshPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshTop,
      child: Padding(
        padding: EdgeInsets.only(
          left: context.fromWidth(CustomStyle.paddingValue),
          right: context.fromWidth(CustomStyle.paddingValue),
          top: context.fromHeight(CustomStyle.paddingValue),
        ),
        child: CustomScrollView(
          slivers: [
            topCompanies,
            SliverToBoxAdapter(
              child: SizedBox(
                height: context.fromHeight(CustomStyle.xxxl),
              ),
            ),
            topJobs,
          ],
        ),
      ),
    );
  }
}
