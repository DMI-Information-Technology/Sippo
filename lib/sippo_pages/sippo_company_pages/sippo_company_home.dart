import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/JobGlobalclass/jobstopimges.dart';
import 'package:sippo/JobGlobalclass/media_query_sizes.dart';
import 'package:sippo/JobGlobalclass/routes.dart';
import 'package:sippo/JobGlobalclass/sippo_customstyle.dart';
import 'package:sippo/JobGlobalclass/text_font_size.dart';
import 'package:sippo/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:sippo/sippo_controller/dashboards_controller/company_dashboard_controller.dart';
import 'package:sippo/sippo_controller/home_controllers/company_home_controller.dart';
import 'package:sippo/sippo_controller/home_controllers/job_home_view_controller.dart';
import 'package:sippo/sippo_custom_widget/body_widget.dart';
import 'package:sippo/sippo_custom_widget/find_yor_jop_dashboard_cards.dart';
import 'package:sippo/sippo_custom_widget/network_bordered_circular_image_widget.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';
import 'package:sippo/sippo_pages/ads_view/ads_view_widget.dart';
import 'package:sippo/sippo_pages/home_component_widget/job_home_view_widget.dart';

class SippoCompanyHomePage extends StatefulWidget {
  const SippoCompanyHomePage({Key? key}) : super(key: key);

  @override
  State<SippoCompanyHomePage> createState() => _SippoCompanyHomePageState();
}

class _SippoCompanyHomePageState extends State<SippoCompanyHomePage> {
  final _controller = CompanyHomeController.instance;
  final jobsHomeView = const JobHomeViewWidget();
  final adsView = const AdsViewWidget();
  final jobStatisticBoard = const JobStatisticBoardViewWidget();
  Widget _buildWelcomeUser(BuildContext context) {
    final dashboardController = CompanyDashBoardController.instance;
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
                  color: SippoColor.primarycolor,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              image,
            ],
          ),
          Obx(
                () => dashboardController.company.name != null
                ? Text(
              "${dashboardController.company.name}.",
              style: dmsbold.copyWith(
                fontSize: FontSize.title3(context),
                color: SippoColor.primarycolor,
              ),
            )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildHomeAppBar(context),
      body: RefreshIndicator(
        onRefresh: () async => _controller.refreshPage(),
        child: BodyWidget(
          paddingContent: EdgeInsets.only(
              bottom: context.fromHeight(CustomStyle.paddingValue)),
          isScrollable: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeUser(context),
              SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
              _buildShowAdsBoard(),
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
                  horizontal: context.fromWidth(CustomStyle.paddingValue),
                ),
                child: Text("Find_Your_Job".tr,
                    style: dmsbold.copyWith(fontSize: 16)),
              ),
              SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
              _buildShowJobStatisticBoard(),
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
      ),
      backgroundColor: SippoColor.backgroudHome,
    );
  }

  Widget _buildShowHomeJobsList() => jobsHomeView;

  Widget _buildShowAdsBoard() => adsView;

  Widget _buildShowJobStatisticBoard() => jobStatisticBoard;

  SizedBox _buildSpecialListView(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double width = size.width;
    return SizedBox(
      height: context.fromHeight(CustomStyle.xs),
      child: Obx(() {
        final specializations = _controller.companyHomeState.specializationList;
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
                  _controller.companyHomeState.selectedSpecialization = special;
                  if (Get.isRegistered<JobsHomeViewController>())
                    JobsHomeViewController.instance.refreshJobs(
                      _controller.companyHomeState.selectedSpecialization,
                    );
                },
                child: AutoSizeText(
                  specializations[index].name ?? '',
                  style: dmsregular.copyWith(
                    color:
                        _controller.companyHomeState.selectedSpecialization ==
                                special
                            ? Colors.white
                            : SippoColor.black,
                    fontSize: FontSize.label(context),
                  ),
                ),
                backgroundColor:
                    _controller.companyHomeState.selectedSpecialization ==
                            special
                        ? SippoColor.primarycolor
                        : SippoColor.grey2,
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
      timeOfDay = 'good_morning'.tr;
    } else if (hour < 18) {
      timeOfDay = 'good_afternoon'.tr;
    } else {
      timeOfDay = 'good_evening'.tr;
    }

    return timeOfDay;
  }

  AppBar _buildHomeAppBar(BuildContext context) {
    final dashboardController = CompanyDashBoardController.instance;
    Size size = Get.size;
    double height = size.height;
    double width = size.width;
    return AppBar(
      leadingWidth: width,

      leading: Padding(
        padding:  EdgeInsets.symmetric(horizontal: width/40 , vertical: 5),
        child: Expanded(
          child: Row(
            children: [
              // Image.asset(JobstopPngImg.sippoLogo , height: height),
              // SizedBox(width: 10,),
              Image.asset(JobstopPngImg.sponserLogo , height:  height,),
            ],
          ),
        ),
      ),
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
                    color: SippoColor.primarycolor
                    ,
                    size: height / 25,
                  )),
              SizedBox(
                width: width / 52,
              ),
              InkWell(
                onTap: () {
                  if (InternetConnectionService.instance.isNotConnected) return;
                  Get.toNamed(SippoRoutes.sippocompanyprofile);
                },
                child: Obx(() => NetworkBorderedCircularImage(
                      imageUrl:
                          dashboardController.company.profileImage?.url ?? '',
                      errorWidget: (___, __, _) => CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Image.asset(JobstopPngImg.comp),
                      ),
                      placeholder: (__, _) => CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Image.asset(JobstopPngImg.comp),
                      ),
                      size: context.fromHeight(24),
                      outerBorderColor: SippoColor.backgroudHome,
                    )),
              ),
            ],
          ),
        )
      ],
    );
  }
  //
  // Padding _buildWelcomeCompany(BuildContext context) {
  //   final dashboardController = CompanyDashBoardController.instance;
  //   return Padding(
  //     padding: EdgeInsets.symmetric(
  //       horizontal: context.fromWidth(CustomStyle.s),
  //     ),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           "hello".tr,
  //           style: dmsbold.copyWith(
  //             fontSize: FontSize.title3(context),
  //             color: SippoColor.primarycolor,
  //           ),
  //         ),
  //         Obx(
  //           () => dashboardController.company.name != null
  //               ? Text(
  //                   "${dashboardController.company.name}",
  //                   style: dmsbold.copyWith(
  //                     fontSize: FontSize.title3(context),
  //                     color: SippoColor.primarycolor,
  //                   ),
  //                 )
  //               : const SizedBox.shrink(),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
