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

import '../../sippo_custom_widget/find_yor_jop_dashboard_cards.dart';
import '../../sippo_custom_widget/job_card_widget.dart';
import '../../sippo_custom_widget/widgets.dart';
import '../../sippo_data/model/profile_model/profile_widget_model/jobstop_jobdetailspost.dart';
import '../../sippo_themes/themecontroller.dart';

class SippoUserHome extends StatefulWidget {
  const SippoUserHome({Key? key}) : super(key: key);

  @override
  State<SippoUserHome> createState() => _SippoUserHomeState();
}

class _SippoUserHomeState extends State<SippoUserHome> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  final themedata = Get.put(JobstopThemecontroler());
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
        'Experienced',
        'Experienced'
      ],
    )
  ];

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: _buildHomeAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.fromWidth(CustomStyle.s),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hello\nHatem Emhemed.".tr,
                    style: dmsbold.copyWith(
                      fontSize: FontSize.title3(context),
                      color: Jobstopcolor.primarycolor,
                    ),
                  ),
                ],
              ),
            ),
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (var i = 0; i < jobData.length; i++) ...[
                    SizedBox(width: context.fromWidth(CustomStyle.s)),
                    JobCard(
                      jobDetails: jobData[i],
                      onFavoriteClicked: () {
                        print('${jobData[i].jobName} added to favorites');
                      },
                      onCardClicked: () {
                        Get.toNamed(SippoRoutes.sippoJobDescription);
                      },
                    ),
                  ],
                  SizedBox(width: context.fromWidth(CustomStyle.s)),
                ],
              ),
            ),
            SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
          ],
        ),
      ),
      backgroundColor: Jobstopcolor.backgroudHome,
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
              if (index == 0)
                SizedBox(width: context.fromWidth(CustomStyle.s)),
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
              if (index == 9)
                SizedBox(width: context.fromWidth(CustomStyle.s)),
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
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
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
