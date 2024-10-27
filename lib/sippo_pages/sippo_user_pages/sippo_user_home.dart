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
import 'package:sippo/sippo_custom_widget/widgets.dart';
import 'package:sippo/sippo_pages/ads_view/ads_view_widget.dart';
import 'package:sippo/sippo_pages/home_component_widget/job_home_view_widget.dart';

import '../../JobServices/ConnectivityController/internet_connection_controller.dart';

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
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15,),
                    _buildShowAdsBoard(),
                    SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(
                    //     horizontal: context.fromWidth(CustomStyle.s),
                    //   ),
                    //   child: Text(
                    //     "Category".tr,
                    //     style: dmsbold.copyWith(fontSize: FontSize.title5(context)),
                    //   ),
                    // ),
                    // SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
                    // _buildSpecialListView(context),
                    // SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
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
              )


            ],
          ),
        ),
      ),
      backgroundColor: SippoColor.primarycolor,
    );
  }

  Widget _buildShowHomeJobsList() => jobsHomeView;

  Widget _buildShowAdsBoard() => adsView;

  Widget _buildShowJobStatisticBoard() => jobStatisticBoard;

  Widget _buildWelcomeUser(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.height * 0.26,
      decoration: BoxDecoration(
        color: SippoColor.transparent,
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: context.fromWidth(CustomStyle.s), vertical: context.fromHeight(CustomStyle.s)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
            onTap: () {
              Get.toNamed(SippoRoutes.sippoGeneralSearchPage);
      },child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200], // Customize background color
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.search, color: Colors.grey),
            const SizedBox(width: 8),
            Text(
              'Search...',
              style: TextStyle(
                color: Colors.grey[600], // Customize text color
              ),
            ),
          ],
        ),),
      ),
            SizedBox(height: 15,),
            Text(
              "Category".tr,
              style: dmsbold.copyWith(fontSize: FontSize.title5(context), color: Colors.white),
            ),
            SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
            Expanded(child: _buildSpecialListView(context)),



          ],
        ),
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
                icon: Icons.star,
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
                        ? SippoColor.white
                        : SippoColor.white.withAlpha(200),
              fontSize: FontSize.label(context) + 3 +
              (_controller.userHomeState.selectedSpecialization == special? 1 : 0), // Increase font size if selected                  ),
                )
                ),
                backgroundColor:
                    _controller.userHomeState.selectedSpecialization == special
                        ? SippoColor.secondary
                        : SippoColor.black.withAlpha(700),
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
    final dashboardController = UserDashBoardController.instance;
    Image image;
    if (getTimeOfDay() == 'Good Morning') {
      image = Image.asset(
        JobstopPngImg.morning,
        height: kToolbarHeight * 0.80,
      );
    } else if (getTimeOfDay() == 'Good Afternoon') {
      image = Image.asset(
        JobstopPngImg.afternoon,
        height: kToolbarHeight * 0.80,
      );
    } else {
      image = Image.asset(
        JobstopPngImg.night,
        height: kToolbarHeight * 0.80,
      );
    }
    Size size = Get.mediaQuery.size;
    //Size size = MediaQuery.sizeOf(context);
    double width = size.width;
    return AppBar(

      leadingWidth: width,
      backgroundColor: SippoColor.transparent,
      leading: Padding(
        padding:  EdgeInsets.symmetric(horizontal: width * 0.040 ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

          Row(children: [
           SizedBox(width: 5,),
          image,
          SizedBox(width: context.width * 0.05,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                getTimeOfDay(),
                style: dmsregular.copyWith(
                  fontSize: FontSize.label(context),
                  color: SippoColor.white,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Obx(
                    () => dashboardController.user.name != null
                    ? Text(
                  "${dashboardController.user.name}.",
                  style: dmsbold.copyWith(
                      fontSize: FontSize.title4(context),
                      color: SippoColor.white,
                      overflow: TextOverflow.ellipsis
                  ),
                )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
          ],),

        // leading: Padding(
        //   padding: EdgeInsets.symmetric(horizontal: width/40, vertical: 5),
        //   child: Row(
        //     children: [
        //      // Image.asset(JobstopPngImg.sippoLogo),
        //      //  SizedBox(
        //      //    width: 10,
        //      //  ),
        //       Image.asset(JobstopPngImg.sponserLogo),
        //     ],
        //   ),
        // ),
        ]
            ),
      ),

      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          // child: Icon(Icons.notifications_active_outlined, color: Colors.white,),
          child: InkWell(
            onTap: () {
              if (InternetConnectionService.instance.isNotConnected) return;
              Get.toNamed(SippoRoutes.sippoUserProfile);
            },
            child: Obx(() {
              final imageUrl = dashboardController.user.profileImage?.url;

              return ClipOval(
                child: imageUrl != null
                    ? Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: context.width * 0.1, // Adjust the size as needed
                  height: context.width * 0.1,
                  errorBuilder: (context, error, stackTrace) => CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset(JobstopPngImg.comp),
                  ),
                )
                    : CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.asset(JobstopPngImg.comp),
                ),
              );
            }),
          )
        )
      ],
    );
  }
}
