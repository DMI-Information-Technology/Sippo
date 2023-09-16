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
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/job_card_widget.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';
import 'package:jobspot/utils/states.dart';

import '../../JopController/dashboards_controller/user_dashboard_controller.dart';
import '../../JopController/home_controllers/user_home_controllers.dart';
import '../../sippo_custom_widget/find_yor_jop_dashboard_cards.dart';
import '../../sippo_custom_widget/widgets.dart';
import '../../utils/helper.dart' as helper;

class SippoUserHome extends StatefulWidget {
  const SippoUserHome({Key? key}) : super(key: key);

  @override
  State<SippoUserHome> createState() => _SippoUserHomeState();
}

class _SippoUserHomeState extends State<SippoUserHome> {
  final _controller = Get.put(UserHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildHomeAppBar(),
      body: BodyWidget(
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
            _buildWorkExListView(context),
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
                  horizontal: context.fromWidth(CustomStyle.s)),
              child: FindYorJopDashBoardCards(
                firstCardTitle: "44.5k",
                firstCardSubtitle: "Remote Job",
                secondCardTitle: "66.8k",
                secondCardSubtitle: "Full Time",
                thirdCardTitle: "38.9k",
                thirdCardSubtitle: "Part Time",
              ),
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
            _buildShowHomeJobsList(context),
            SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
          ],
        ),
      ),
      backgroundColor: Jobstopcolor.backgroudHome,
    );
  }

  Widget _buildShowHomeJobsList(BuildContext context) {
    return Obx(() => FutureBuilder(
          future: Future.value(_controller.jobsHomeState.jobStates),
          builder: (context, snapshot) {
            final states = snapshot.data;
            final data = _controller.jobsHomeState.jobsList;
            print(states);
            if (states == null) return const SizedBox.shrink();
            if (states.isError) return _buildFieldJobsMessage(context, states);
            if (states.isSuccess && data.isNotEmpty)
              return _buildJobList(context, data);
            if (states.isLoading)
              return const Center(child: CircularProgressIndicator());
            return const SizedBox.shrink();
          },
        ));
  }

  SingleChildScrollView _buildJobList(
    BuildContext context,
    List<CompanyJobModel> data,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.fromWidth(CustomStyle.spaceBetween),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...List.generate(data.length, (index) {
              final item = data[index];
              return JobHomeCard(
                padding: EdgeInsets.only(
                  right: index == data.length - 1
                      ? 0.0
                      : context.fromWidth(CustomStyle.paddingValue),
                ),
                width: context.width / 1.3,
                jobDetailsPost: item,
                imagePath: [
                  'https://www.designbust.com/download/1060/png/microsoft_logo_transparent512.png',
                  'https://logodownload.org/wp-content/uploads/2014/09/facebook-logo-1-2.png',
                ][1],
                onCardClicked: () {
                  Get.toNamed(SippoRoutes.sippoJobDescription);
                },
                isEditable: false,
                onAddressTextTap: (location) async {
                  helper.lunchMapWithLocation(
                    location.dLatitude,
                    location.dLongitude,
                  );
                },
              );
            }),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.all(
                  context.fromWidth(CustomStyle.xxl),
                ),
                child: Icon(
                  Icons.arrow_circle_right_rounded,
                  color: Jobstopcolor.secondary,
                  size: context.fromHeight(12),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Center _buildFieldJobsMessage(BuildContext context, States states) {
    return Center(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: context.fromWidth(CustomStyle.s)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              states.message ?? 'something wrong is happened.',
              style: dmsregular.copyWith(
                fontSize: FontSize.paragraph3(context),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: context.fromHeight(CustomStyle.huge)),
            SizedBox(
              width: context.fromWidth(CustomStyle.overBy3),
              height: context.fromHeight(12),
              child: CustomButton(
                onTappeed: () {
                  _controller.jobsHomeState.refreshJobs();
                },
                text: 'Try again',
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeUser(BuildContext context) {
    final dashboardController = UserDashBoardController.instance;
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
            () => dashboardController.user.name != null
                ? Text(
                    "${dashboardController.user.name}.",
                    style: dmsbold.copyWith(
                      fontSize: FontSize.title3(context),
                      color: Jobstopcolor.primarycolor,
                    ),
                  )
                : const CircularProgressIndicator(strokeWidth: 1.8),
          ),
        ],
      ),
    );
  }

  SizedBox _buildWorkExListView(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return SizedBox(
      height: context.fromHeight(CustomStyle.xs),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Row(
            children: [
              if (index == 0) SizedBox(width: context.fromWidth(CustomStyle.s)),
              CustomChip(
                height: height,
                onTap: () {},
                child: AutoSizeText(
                  "Senior",
                  style: dmsregular.copyWith(
                    color: Jobstopcolor.black,
                    fontSize: FontSize.title6(context),
                  ),
                ),
                backgroundColor: Jobstopcolor.grey2,
                borderRadius: width / 32,
                paddingValue: context.fromHeight(CustomStyle.xxxl),
              ),
              if (index == 9) SizedBox(width: context.fromWidth(CustomStyle.s)),
            ],
          );
        },
        separatorBuilder: (context, index) => SizedBox(
          width: context.fromWidth(CustomStyle.s),
        ),
      ),
    );
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
                onPressed: () {},
                icon: Icon(
                  Icons.search_sharp,
                  size: height / 25,
                ),
              ),
              SizedBox(width: width / 52),
              InkWell(
                onTap: () => Get.toNamed(SippoRoutes.sippoprofile),
                child: CircleAvatar(
                  radius: 20,
                  child: Image.asset(JobstopPngImg.photo),
                ),
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
