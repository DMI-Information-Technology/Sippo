import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/JopController/dashboards_controller/company_dashboard_controller.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/save_job_card_widget.dart';

import '../../JobGlobalclass/sippo_customstyle.dart';
import '../../JobGlobalclass/text_font_size.dart';
import '../../sippo_custom_widget/job_card_widget.dart';
import '../../sippo_custom_widget/widgets.dart';
import '../../sippo_data/model/profile_model/profile_widget_model/jobstop_jobdetailspost.dart';

class SippoCompanyHomePage extends StatefulWidget {
  const SippoCompanyHomePage({Key? key}) : super(key: key);

  @override
  State<SippoCompanyHomePage> createState() => _SippoCompanyHomePageState();
}

class _SippoCompanyHomePageState extends State<SippoCompanyHomePage> {
  final List<JobDetailsModel> jobData = [
    JobDetailsModel(
      companyLogo: 'https://picsum.photos/200',
      jobName: 'Flutter Developerrrrrrrrrrrrrrrrr',
      companyName: 'Example Company',
      location: 'New York, USA',
      description: 'We are looking for a skilled Flutter developer...',
      salary: '\$70,000 - \$90,000',
      chips: ['Full-time', 'Remote', 'Experienced'],
    ),
    JobDetailsModel(
      companyLogo: 'https://picsum.photos/200',
      jobName: 'Flutter Developer',
      companyName: 'Example Company',
      location: 'New York, USA',
      description: 'We are looking for a skilled Flutter developer...',
      salary: '\$70,000 - \$90,000',
      chips: ['Full-time', 'Remote', 'Experienced'],
    ),
    JobDetailsModel(
      companyLogo: 'https://picsum.photos/200',
      jobName: 'Flutter Developer',
      companyName: 'Example Company',
      location: 'New York, USA',
      description: 'We are looking for a skilled Flutter developer...',
      salary: '\$70,000 - \$90,000',
      chips: ['Full-time', 'Remote', 'Experienced'],
    ),
    JobDetailsModel(
      companyLogo: 'https://picsum.photos/200',
      jobName: 'Flutter Developer',
      companyName: 'Example Company',
      location: 'New York, USA',
      description: 'We are looking for a skilled Flutter developer...',
      salary: '\$70,000 - \$90,000',
      chips: ['Full-time', 'Remote', 'Experienced'],
    ),
    JobDetailsModel(
      companyLogo: 'https://picsum.photos/200',
      jobName: 'Flutter Developer',
      companyName: 'Example Company',
      location: 'New York, USA',
      description: 'We are looking for a skilled Flutter developer...',
      salary: '\$70,000 - \$90,000',
      chips: [
        'Full-time',
        'Remote',
        'Experienced',
      ],
    )
    // Add more job data as needed...
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                        onTap: () {},
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
                separatorBuilder: (context, index) => SizedBox(
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
                horizontal: context.fromWidth(CustomStyle.paddingValue),
              ),
              child: FindYorJopDashBoardCards(),
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
            FutureBuilder(
                future: Future.value(jobData),
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  if (data == null) return const SizedBox.shrink();
                  return SizedBox(
                    height: height / 3.8,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.length,
                      padding: EdgeInsets.symmetric(
                          horizontal: width / CustomStyle.spaceBetween),
                      itemBuilder: (context, index) {
                        return JobHomeCard(
                          width: context.width / 1.3,
                          onActionTap: () {
                            print('${data[index].jobName} added to favorites');
                          },
                          onCardTap: () {},
                          canApply: false,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(width: context.width / 32);
                      },
                    ),
                  );
                })
          ],
        ),
      ),
      backgroundColor: Jobstopcolor.backgroudHome,
    );
  }

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
                child: NetworkBorderedCircularImage(
                  imageUrl: dashboardController.company.profileImage?.url ?? '',
                  errorWidget: (___, __, _) => const CircleAvatar(),
                  size: context.fromHeight(24),
                  outerBorderColor: Jobstopcolor.backgroudHome,
                ),
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

class FindYorJopDashBoardCards extends StatelessWidget {
  const FindYorJopDashBoardCards({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            height: height / 4,
            width: width / 2.3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Jobstopcolor.lightsky),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  JobstopPngImg.headhunting,
                  height: height / 20,
                ),
                SizedBox(
                  height: height / 96,
                ),
                Text(
                  "44.5k",
                  style:
                      dmsbold.copyWith(fontSize: 16, color: Jobstopcolor.black),
                ),
                Text(
                  "Remote Job",
                  style: dmsregular.copyWith(
                      fontSize: 14, color: Jobstopcolor.black),
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            Container(
              height: height / 9.5,
              width: width / 2.3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Jobstopcolor.lightprimary),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "66.8k",
                    style: dmsbold.copyWith(
                        fontSize: 16, color: Jobstopcolor.black),
                  ),
                  Text(
                    "Full Time",
                    style: dmsregular.copyWith(
                        fontSize: 14, color: Jobstopcolor.black),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height / 36,
            ),
            Container(
              height: height / 9.5,
              width: width / 2.3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Jobstopcolor.lightorenge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "38.9k",
                    style: dmsbold.copyWith(
                        fontSize: 16, color: Jobstopcolor.black),
                  ),
                  Text(
                    "Part Time",
                    style: dmsregular.copyWith(
                        fontSize: 14, color: Jobstopcolor.black),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
