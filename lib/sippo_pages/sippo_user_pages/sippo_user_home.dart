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
import 'package:sippo/sippo_controller/dashboards_controller/user_dashboard_controller.dart';
import 'package:sippo/sippo_controller/home_controllers/job_home_view_controller.dart';
import 'package:sippo/sippo_controller/home_controllers/user_home_controllers.dart';
import 'package:sippo/sippo_custom_widget/body_widget.dart';
import 'package:sippo/sippo_custom_widget/find_yor_jop_dashboard_cards.dart';
import 'package:sippo/sippo_custom_widget/network_bordered_circular_image_widget.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';
import 'package:sippo/sippo_pages/ads_view/ads_view_widget.dart';
import 'package:sippo/sippo_pages/home_component_widget/job_home_view_widget.dart';

class SippoUserHome extends StatefulWidget {
  const SippoUserHome({Key? key}) : super(key: key);

  @override
  State<SippoUserHome> createState() => _SippoUserHomeState();
}

class _SippoUserHomeState extends State<SippoUserHome> {
  // final _controller = Get.put(UserHomeController());
  final _controller = UserHomeController.instance;
  final jobsHomeView = const JobHomeViewWidget();
  final adsView = const AdsViewWidget();
  final jobStatisticBoard = const JobStatisticBoardViewWidget();

  @override
  void didUpdateWidget(covariant SippoUserHome oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('_SippoUserHomeState.didUpdateWidget');
  }

  @override
  Widget build(BuildContext context) {
    print('_SippoUserHomeState.build');
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
                  horizontal: context.fromWidth(CustomStyle.s),
                ),
                child: Text(
                  "Find_Your_Job".tr,
                  style: dmsbold.copyWith(fontSize: FontSize.title5(context)),
                ),
              ),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              _buildShowJobStatisticBoard(),
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
      backgroundColor: SippoColor.backgroudHome,
    );
  }

  Widget _buildShowHomeJobsList() => jobsHomeView;

  Widget _buildShowAdsBoard() => adsView;

  Widget _buildShowJobStatisticBoard() => jobStatisticBoard;

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
            () => dashboardController.user.name != null
                ? Text(
                    "${dashboardController.user.name}.",
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
                        : SippoColor.black.withAlpha(200),
                    fontSize: FontSize.label(context) + 3,
                  ),
                ),
                backgroundColor:
                    _controller.userHomeState.selectedSpecialization == special
                        ? SippoColor.primarycolor
                        : SippoColor.transparent,
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

  AppBar _buildHomeAppBar() {
    Size size = Get.mediaQuery.size;
    //Size size = MediaQuery.sizeOf(context);
    double height = size.height;
    double width = size.width;
    return AppBar(
      leadingWidth: width,
      leading: Padding(
        padding: EdgeInsets.symmetric(horizontal: width/40, vertical: 5),
        child: Row(
          children: [
           // Image.asset(JobstopPngImg.sippoLogo),
           //  SizedBox(
           //    width: 10,
           //  ),
            Image.asset(JobstopPngImg.sponserLogo),
          ],
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
                  Icons.search,
                  color: SippoColor.primarycolor,
                  size: height / 30,
                ),
              ),
              SizedBox(width: width / 52),
              InkWell(
                onTap: () => Get.toNamed(SippoRoutes.sippoUserProfile),
                child: Obx(() => NetworkBorderedCircularImage(
                      imageUrl: _controller.user.profileImage?.url ?? '',
                      errorWidget: (___, __, _) =>Stack(
    children: [
    CircleAvatar(
    backgroundColor: Colors.white,
    child: Image.asset(
    JobstopPngImg.sign_up_image,
    fit: BoxFit.cover,
    ),
    ),
    Positioned.fill(
    child: Container(
    decoration: BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(color: SippoColor.primarycolor, width: 1.5), // Customize as needed
    ),
    ),
    ),
    ],
    ),
                      placeholder: (_, __) => Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Image.asset(
                              JobstopPngImg.sign_up_image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: SippoColor.primarycolor, width: 1.5), // Customize as needed
                              ),
                            ),
                          ),
                        ],
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
}
