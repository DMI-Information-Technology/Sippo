import 'package:flutter/material.dart';

import '../JobGlobalclass/jobstopcolor.dart';
import '../JobGlobalclass/jobstopfontstyle.dart';
import '../JobGlobalclass/jobstopimges.dart';
import '../sippo_data/model/job_statistics_model/job_statistics_model.dart';

class FindYorJopDashBoardCards extends StatelessWidget {
  final String? firstCardSubtitle;
  final String? secondCardSubtitle;
  final String? thirdCardSubtitle;
  final VoidCallback? onFirstTap;
  final VoidCallback? onSecondTap;
  final VoidCallback? onThirdTap;
  final JobStatisticsModel? jobStatistics;

  const FindYorJopDashBoardCards({
    this.firstCardSubtitle,
    this.secondCardSubtitle,
    this.thirdCardSubtitle,
    Key? key,
    this.onFirstTap,
    this.onSecondTap,
    this.onThirdTap,
    this.jobStatistics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: onFirstTap,
          child: Container(
            height: height / 4,
            width: width / 2.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Jobstopcolor.lightsky,
            ),
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
                  jobStatistics?.remoteJobs?.countString ?? "",
                  style:
                      dmsbold.copyWith(fontSize: 16, color: Jobstopcolor.black),
                ),
                Text(
                  firstCardSubtitle ?? '',
                  style: dmsregular.copyWith(
                      fontSize: 14, color: Jobstopcolor.black),
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            CustomCard(
              onTap: onSecondTap,
              height: height / 9.5,
              width: width / 2.3,
              color: Jobstopcolor.lightprimary,
              title: jobStatistics?.fullTimeJobs?.countString ?? "",
              subtitle: secondCardSubtitle ?? '',
            ),
            SizedBox(
              height: height / 36,
            ),
            CustomCard(
              onTap: onThirdTap,
              height: height / 9.5,
              width: width / 2.3,
              color: Jobstopcolor.lightorenge,
              title: jobStatistics?.partTimeJobs?.countString ?? "",
              subtitle: thirdCardSubtitle ?? '',
            ),
          ],
        ),
      ],
    );
  }
}

class CustomCard extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const CustomCard({
    required this.height,
    required this.width,
    required this.color,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: dmsbold.copyWith(fontSize: 16, color: Jobstopcolor.black),
            ),
            Text(
              subtitle,
              style:
                  dmsregular.copyWith(fontSize: 14, color: Jobstopcolor.black),
            ),
          ],
        ),
      ),
    );
  }
}
