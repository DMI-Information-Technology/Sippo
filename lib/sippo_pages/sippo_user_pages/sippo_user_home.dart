import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/sippo_controller/dashboards_controller/user_dashboard_controller.dart';
import 'package:jobspot/sippo_controller/home_controllers/job_home_view_controller.dart';
import 'package:jobspot/sippo_controller/home_controllers/user_home_controllers.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/find_yor_jop_dashboard_cards.dart';
import 'package:jobspot/sippo_custom_widget/network_bordered_circular_image_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/sippo_pages/home_component_widget/job_home_view_widget.dart';

class SippoUserHome extends StatefulWidget {
  const SippoUserHome({Key? key}) : super(key: key);

  @override
  State<SippoUserHome> createState() => _SippoUserHomeState();
}

class _SippoUserHomeState extends State<SippoUserHome> {
  // final _controller = Get.put(UserHomeController());
  final _controller = UserHomeController.instance;
  final jobsHomeView = const JobHomeViewWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildHomeAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          _controller.refreshPage();
        },
        child: BodyWidget(
          paddingContent: EdgeInsets.only(
            bottom: context.fromHeight(CustomStyle.paddingValue),
          ),
          isScrollable: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeUser(context),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.fromWidth(CustomStyle.s)),
                child: _buildAdsBoard(),
              ),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.fromWidth(CustomStyle.s),
                ),
                child: Text(
                  "Category".tr,
                  style: dmsbold.copyWith(fontSize: FontSize.title5(context)),
                ),
              ),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              _buildSpecialListView(context),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.fromWidth(CustomStyle.s),
                ),
                child: Text(
                  "Find_Your_Job".tr,
                  style: dmsbold.copyWith(fontSize: FontSize.title5(context)),
                ),
              ),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.fromWidth(CustomStyle.s),
                ),
                child: Obx(() {
                  final jobStatistic = _controller.userHomeState.jobsStatistic;
                  return FindYorJopDashBoardCards(
                    jobStatistics: jobStatistic,
                    firstCardSubtitle: "Remote".tr,
                    secondCardSubtitle: "Full Time".tr,
                    thirdCardSubtitle: "Part Time".tr,
                    onFirstTap: () {
                      _controller.sharedDataService.jobStatistic =
                          jobStatistic.remoteJobs;
                      Get.toNamed(SippoRoutes.sippoJobFilterSearch)?.then((_) {
                        _controller.sharedDataService.jobStatistic = null;
                      });
                    },
                    onSecondTap: () {
                      _controller.sharedDataService.jobStatistic =
                          jobStatistic.fullTimeJobs;
                      Get.toNamed(SippoRoutes.sippoJobFilterSearch)?.then((_) {
                        _controller.sharedDataService.jobStatistic = null;
                      });
                    },
                    onThirdTap: () {
                      _controller.sharedDataService.jobStatistic =
                          jobStatistic.partTimeJobs;
                      Get.toNamed(SippoRoutes.sippoJobFilterSearch)?.then((_) {
                        _controller.sharedDataService.jobStatistic = null;
                      });
                    },
                  );
                }),
              ),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.fromWidth(CustomStyle.s),
                ),
                child: Text(
                  "Recent_Job_List".tr,
                  style: dmsbold.copyWith(fontSize: FontSize.title5(context)),
                ),
              ),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              // _buildShowHomeJobPagination(context),
              _buildShowHomeJobsList(),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
            ],
          ),
        ),
      ),
      backgroundColor: Jobstopcolor.backgroudHome,
    );
  }

  Widget _buildShowHomeJobsList() => jobsHomeView;

  Widget _buildWelcomeUser(BuildContext context) {
    final dashboardController = UserDashBoardController.instance;
    Image image;
    if (getTimeOfDay() == 'Good Morning') {
      image = Image.asset(
        JobstopPngImg.morning,
        height: 30,
      );
    } else if (getTimeOfDay() == 'Good Afternoon') {
      image = Image.asset(
        JobstopPngImg.afternoon,
        height: 30,
      );
    } else {
      image = Image.asset(
        JobstopPngImg.night,
        height: 30,
      );
    }
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.fromWidth(CustomStyle.s),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                getTimeOfDay(),
                style: dmsbold.copyWith(
                  fontSize: FontSize.title3(context),
                  color: Jobstopcolor.primarycolor,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              image,
            ],
          ),
          Obx(
            () => dashboardController.user.name != null
                ? Text(
                    "${dashboardController.user.name}.",
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

  SizedBox _buildSpecialListView(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double width = size.width;
    return SizedBox(
      height: context.fromHeight(CustomStyle.xs),
      child: Obx(() {
        final specializations = _controller.userHomeState.specializationList;
        return ListView.separated(
          padding: EdgeInsets.symmetric(
            horizontal: context.fromWidth(CustomStyle.s),
          ),
          scrollDirection: Axis.horizontal,
          itemCount: specializations.length,
          itemBuilder: (context, index) {
            return Obx(() {
              final special = specializations[index];
              return CustomChip(
                onTap: () {
                  _controller.userHomeState.selectedSpecialization = special;
                  if (Get.isRegistered<JobsHomeViewController>())
                    JobsHomeViewController.instance.refreshJobs(
                      _controller.userHomeState.selectedSpecialization,
                    );
                },
                child: AutoSizeText(
                  specializations[index].name ?? '',
                  style: dmsregular.copyWith(
                    color: _controller.userHomeState.selectedSpecialization ==
                            special
                        ? Colors.white
                        : Jobstopcolor.black,
                    fontSize: FontSize.label(context),
                  ),
                ),
                backgroundColor:
                    _controller.userHomeState.selectedSpecialization == special
                        ? Jobstopcolor.primarycolor
                        : Jobstopcolor.grey2,
                borderRadius: width / 32,
                paddingValue: context.fromHeight(CustomStyle.xxxl),
              );
            });
          },
          separatorBuilder: (context, index) => SizedBox(
            width: context.fromWidth(CustomStyle.s),
          ),
        );
      }),
    );
  }

  String getTimeOfDay() {
    final time = DateTime.now();
    // Get the hour of the day.
    final hour = time.hour;

    // Determine if it is morning, noon, or evening.
    String timeOfDay;
    if (hour < 12) {
      timeOfDay = 'Good Morning';
    } else if (hour < 18) {
      timeOfDay = 'Good Afternoon';
    } else {
      timeOfDay = 'Good Evening';
    }

    return timeOfDay;
  }

  AppBar _buildHomeAppBar() {
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
                  Icons.search,
                  size: height / 30,
                ),
              ),
              SizedBox(width: width / 52),
              InkWell(
                onTap: () => Get.toNamed(SippoRoutes.sippoUserProfile),
                child: Obx(() => NetworkBorderedCircularImage(
                      imageUrl: _controller.user.profileImage?.url ?? '',
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
                child: Text(
                  "Join Now",
                  style: dmsmedium.copyWith(
                      fontSize: 13, color: Jobstopcolor.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
