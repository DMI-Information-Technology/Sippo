import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/JopController/dashboards_controller/company_dashboard_controller.dart';
import 'package:jobspot/JopController/home_controllers/company_home_controller.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/utils/image_picker_service.dart';

import '../../JobServices/shared_global_data_service.dart';
import '../../sippo_custom_widget/find_yor_jop_dashboard_cards.dart';
import '../../sippo_custom_widget/network_bordered_circular_image_widget.dart';
import '../home_component_widget/job_home_view_widget.dart';

class SippoCompanyHomePage extends StatefulWidget {
  const SippoCompanyHomePage({Key? key}) : super(key: key);

  @override
  State<SippoCompanyHomePage> createState() => _SippoCompanyHomePageState();
}

class _SippoCompanyHomePageState extends State<SippoCompanyHomePage> {
  final _controller = CompanyHomeController.instance;
  final jobsHomeView = const JobHomeViewWidget();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double height = size.height;
    double width = size.width;

    return Scaffold(
      appBar: _buildHomeAppBar(context),
      body: BodyWidget(
        paddingContent: EdgeInsets.only(
            bottom: context.fromHeight(CustomStyle.paddingValue)),
        isScrollable: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeUser(context),
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.fromWidth(CustomStyle.paddingValue),
              ),
              child: _buildAdsBoard(),
            ),
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
            SizedBox(
              height: height / 16,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: context.fromWidth(CustomStyle.paddingValue),
                ),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      SizedBox(width: width / 64),
                      CustomChip(
                        height: height,
                        onTap: () {
                          ImagePickerFile.pickMultiImageFromGallery();
                        },
                        child: Text(
                          "Senior",
                          style: dmsregular.copyWith(color: Jobstopcolor.black),
                        ),
                        backgroundColor: Jobstopcolor.grey2,
                        borderRadius: height / 64,
                        paddingValue: height / 64,
                      ),
                    ],
                  );
                },
                separatorBuilder: (_, __) => SizedBox(
                  width: width / 32,
                ),
              ),
            ),
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.fromWidth(CustomStyle.paddingValue),
              ),
              child: Text("Find_Your_Job".tr,
                  style: dmsbold.copyWith(fontSize: 16)),
            ),
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.fromWidth(CustomStyle.s),
              ),
              child: Obx(() {
                final jobStatistic = _controller.jobsHomeState.jobStatistic;
                return FindYorJopDashBoardCards(
                  jobStatistics: jobStatistic,
                  firstCardSubtitle: "Remote".tr,
                  secondCardSubtitle: "Full Time".tr,
                  thirdCardSubtitle: "Part Time".tr,
                  onFirstTap: () {
                    SharedGlobalDataService.instance.jobStatistics =
                        jobStatistic.remoteJobs;
                    Get.toNamed(SippoRoutes.sippoJobFilterSearch)?.then((_) {
                      SharedGlobalDataService.instance.jobStatistics = null;
                    });
                  },
                  onSecondTap: () {
                    SharedGlobalDataService.instance.jobStatistics =
                        jobStatistic.fullTimeJobs;
                    Get.toNamed(SippoRoutes.sippoJobFilterSearch)?.then((_) {
                      SharedGlobalDataService.instance.jobStatistics = null;
                    });
                  },
                  onThirdTap: () {
                    SharedGlobalDataService.instance.jobStatistics =
                        jobStatistic.partTimeJobs;
                    Get.toNamed(SippoRoutes.sippoJobFilterSearch)?.then((_) {
                      SharedGlobalDataService.instance.jobStatistics = null;
                    });
                  },
                );
              }),
            ),
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.fromWidth(CustomStyle.paddingValue),
              ),
              child: Text("Recent_Job_List".tr,
                  style: dmsbold.copyWith(fontSize: 16)),
            ),
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
            _buildShowHomeJobsList()
          ],
        ),
      ),
      backgroundColor: Jobstopcolor.backgroudHome,
    );
  }

  Widget _buildShowHomeJobsList() => jobsHomeView;

  AppBar _buildHomeAppBar(BuildContext context) {
    final dashboardController = CompanyDashBoardController.instance;
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return AppBar(
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width / 28),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Get.toNamed(SippoRoutes.sippoGeneralSearchPage);
                  },
                  icon: Icon(
                    Icons.search_sharp,
                    size: height / 25,
                  )),
              SizedBox(
                width: width / 52,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_none,
                  size: height / 25,
                ),
              ),
              SizedBox(
                width: width / 52,
              ),
              InkWell(
                onTap: () => Get.toNamed(SippoRoutes.sippocompanyprofile),
                child: Obx(() => NetworkBorderedCircularImage(
                      imageUrl:
                          dashboardController.company.profileImage?.url ?? '',
                      errorWidget: (___, __, _) => const CircleAvatar(),
                      size: context.fromHeight(24),
                      outerBorderColor: Jobstopcolor.backgroudHome,
                    )),
              ),
            ],
          ),
        )
      ],
    );
  }

  Padding _buildWelcomeUser(BuildContext context) {
    final dashboardController = CompanyDashBoardController.instance;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.fromWidth(CustomStyle.s),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hello",
            style: dmsbold.copyWith(
              fontSize: FontSize.title3(context),
              color: Jobstopcolor.primarycolor,
            ),
          ),
          Obx(
            () => dashboardController.company.name != null
                ? Text(
                    "${dashboardController.company.name}",
                    style: dmsbold.copyWith(
                      fontSize: FontSize.title3(context),
                      color: Jobstopcolor.primarycolor,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildAdsBoard() {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Container(
      decoration: BoxDecoration(
          color: Jobstopcolor.primarycolor,
          borderRadius: BorderRadius.circular(height / 32)),
      child: Stack(
        children: [
          Image.asset(JobstopPngImg.banner),
          Positioned(
              top: 50,
              left: 20,
              child: Text(
                "50% off\ntake any courses",
                style: dmsregular.copyWith(
                    fontSize: 18, color: Jobstopcolor.white),
              )),
          Positioned(
              bottom: 30,
              left: 20,
              child: Container(
                height: height / 30,
                width: width / 3.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Jobstopcolor.orenge),
                child: Center(
                    child: Text("Join Now",
                        style: dmsmedium.copyWith(
                            fontSize: 13, color: Jobstopcolor.white))),
              )),
        ],
      ),
    );
  }
}
