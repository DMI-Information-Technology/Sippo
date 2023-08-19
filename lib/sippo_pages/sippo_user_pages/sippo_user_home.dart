import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import '../../JobThemes/themecontroller.dart';
import '../../JopCustomWidget/widgets.dart';
import '../../sippo_data/model/profile_model/jobstop_jobdetailspost.dart';
import 'jobstop_search.dart';

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
      companyLogo: 'https://example.com/company_logo.png',
      jobName: 'Flutter Developerrrrrrrrrrrrrrrrr',
      companyName: 'Example Company',
      location: 'New York, USA',
      description: 'We are looking for a skilled Flutter developer...',
      salary: '\$70,000 - \$90,000',
      chips: ['Full-time', 'Remote', 'Experienced'],
    ),
    JobDetailsModel(
      companyLogo: 'https://example.com/company_logo.png',
      jobName: 'Flutter Developer',
      companyName: 'Example Company',
      location: 'New York, USA',
      description: 'We are looking for a skilled Flutter developer...',
      salary: '\$70,000 - \$90,000',
      chips: ['Full-time', 'Remote', 'Experienced'],
    ),
    JobDetailsModel(
      companyLogo: 'https://example.com/company_logo.png',
      jobName: 'Flutter Developer',
      companyName: 'Example Company',
      location: 'New York, USA',
      description: 'We are looking for a skilled Flutter developer...',
      salary: '\$70,000 - \$90,000',
      chips: ['Full-time', 'Remote', 'Experienced'],
    ),
    JobDetailsModel(
      companyLogo: 'https://example.com/company_logo.png',
      jobName: 'Flutter Developer',
      companyName: 'Example Company',
      location: 'New York, USA',
      description: 'We are looking for a skilled Flutter developer...',
      salary: '\$70,000 - \$90,000',
      chips: ['Full-time', 'Remote', 'Experienced'],
    ),
    JobDetailsModel(
      companyLogo: 'https://example.com/company_logo.png',
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
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: height / 64,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height / 96),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width / 26,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hello\nOrlando Diggs.",
                      style: dmsbold.copyWith(
                        fontSize: 22,
                        color: themedata.isdark
                            ? Jobstopcolor.white
                            : Jobstopcolor.primarycolor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height / 36),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width / 26,
                ),
                child: _buildAdsBoard(),
              ),
              SizedBox(height: height / 36),
              SizedBox(
                height: height / 16,
                child: ListView.separated(
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
                            "abcdefghijk",
                            style:
                                dmsregular.copyWith(color: Jobstopcolor.black),
                          ),
                          backgroundColor: Jobstopcolor.grey2,
                          borderRadius: height / 8,
                          paddingValue: height / 64,
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    width: width / 25,
                  ),
                ),
              ),
              SizedBox(
                height: height / 36,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width / 26,
                ),
                child: Text("Find_Your_Job".tr,
                    style: dmsbold.copyWith(fontSize: 16)),
              ),
              SizedBox(
                height: height / 36,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width / 26,
                ),
                child: FindYorJopDashBoardCards(),
              ),
              SizedBox(
                height: height / 36,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width / 26,
                ),
                child: Text("Recent_Job_List".tr,
                    style: dmsbold.copyWith(fontSize: 16)),
              ),
              SizedBox(
                height: height / 36,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (var i = 0; i < jobData.length; i++)
                      Row(
                        children: [
                          SizedBox(width: width / 26),
                          JobCard(
                            jobDetails: jobData[i],
                            onFavoritePressed: () {
                              print('${jobData[i].jobName} added to favorites');
                            },
                          ),
                        ],
                      ),
                    SizedBox(width: width / 26),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Jobstopcolor.backgroudHome,
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
                  )),
              SizedBox(
                width: width / 52,
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications_none,
                    size: height / 25,
                  )),
              SizedBox(
                width: width / 52,
              ),
              InkWell(
                onTap: () => Get.toNamed(SippoRoutesPages.sippoprofile),
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
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const JobSearch();
              },
            ));
          },
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

class JobCard extends StatelessWidget {
  final JobDetailsModel jobDetails;
  final Function()? onFavoritePressed; // Callback for the favorite button press

  JobCard({
    required this.jobDetails,
    this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Container(
      decoration: BoxDecoration(
        color: Jobstopcolor.white,
        borderRadius: BorderRadius.circular(height / 32),
      ),
      child: Padding(
        padding: EdgeInsets.all(height / 48.0),
        child: SizedBox(
          width: width / 1.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: jobDetails.companyLogo,
                    width: height / 16,
                    height: height / 16,
                    placeholder: (context, url) => Image.asset(
                      JobstopPngImg.google,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      JobstopPngImg.google,
                    ),
                  ),
                  SizedBox(width: width / 32.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: width / 3,
                        child: Text(
                          jobDetails.jobName,
                          style: dmsbold.copyWith(
                              fontSize: height / 52,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      SizedBox(
                        width: width / 3,
                        child: Text(jobDetails.companyName,
                            style: dmsregular.copyWith(
                              fontSize: height / 62,
                              color: Colors.grey,
                            ),
                            overflow: TextOverflow.ellipsis),
                      ),
                      SizedBox(
                        width: width / 3,
                        child: Text(jobDetails.location,
                            style: dmsregular.copyWith(
                              fontSize: height / 62,
                              color: Colors.grey,
                            ),
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: onFavoritePressed,
                    icon: Icon(Icons.favorite_border),
                  ),
                ],
              ),
              SizedBox(height: height / 56),
              Text(
                '${jobDetails.salary}',
                style: dmsbold.copyWith(
                  fontSize: height / 52.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height / 56),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: jobDetails.chips.map((chipText) {
                    return Padding(
                      padding: EdgeInsets.only(right: width / 60),
                      child: Chip(
                        label: Text(chipText),
                        backgroundColor: Jobstopcolor.greyyy2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
