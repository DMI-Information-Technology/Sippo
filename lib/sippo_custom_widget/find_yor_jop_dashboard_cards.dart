import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/JobServices/shared_global_data_service.dart';
import 'package:jobspot/sippo_data/job_statistics_repo/job_statistics_repo.dart';
import 'package:jobspot/sippo_data/model/job_statistics_model/job_statistics_model.dart';
import 'package:jobspot/utils/states.dart';

class JobStatisticBoardController extends GetxController {
  static JobStatisticBoardController get instance => Get.find();
  final _jobStatistic = JobStatisticsModel().obs;

  JobStatisticsModel get jobsStatistic => _jobStatistic.value;

  set jobsStatistic(JobStatisticsModel value) {
    _jobStatistic.value = value;
  }

  final _states = States().obs;

  States get states => _states.value;

  void set states(States value) => _states.value = value;

  Future<void> fetchJobStatistics() async {
    if (InternetConnectionService.instance.isNotConnected) return;
    if (states.isLoading) return;
    states = States(isLoading: true);
    final response = await JobStatisticsRepo.fetchLocations();
    states = States(isLoading: false);
    await response?.checkStatusResponse(
      onSuccess: (data, _) {
        if (data != null) jobsStatistic = data;
        states = States(isSuccess: true);
      },
      onValidateError: (validateError, _) {
        states = States(isError: true);
      },
      onError: (message, _) {
        states = States(isError: true, message: message);
      },
    );
  }
}

class JobStatisticBoardViewWidget extends StatefulWidget {
  const JobStatisticBoardViewWidget({super.key});

  @override
  State<JobStatisticBoardViewWidget> createState() =>
      _JobStatisticBoardViewWidgetState();
}

class _JobStatisticBoardViewWidgetState
    extends State<JobStatisticBoardViewWidget> {
  final _controller = Get.put(JobStatisticBoardController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.fromWidth(CustomStyle.s),
      ),
      child: Obx(() {
        final jobStatistic = _controller.jobsStatistic;
        return JobStatisticBoardCards(
          jobStatistics: jobStatistic,
          firstCardSubtitle: "Remote".tr,
          secondCardSubtitle: "Full Time".tr,
          thirdCardSubtitle: "Part Time".tr,
          onFirstTap: () {
            if (jobStatistic.remoteJobs == null) return;
            SharedGlobalDataService.instance.jobStatistic =
                jobStatistic.remoteJobs;
            Get.toNamed(SippoRoutes.sippoJobFilterSearch)?.then((_) {
              SharedGlobalDataService.instance.jobStatistic = null;
            });
          },
          onSecondTap: () {
            if (jobStatistic.fullTimeJobs == null) return;
            SharedGlobalDataService.instance.jobStatistic =
                jobStatistic.fullTimeJobs;
            Get.toNamed(SippoRoutes.sippoJobFilterSearch)?.then((_) {
              SharedGlobalDataService.instance.jobStatistic = null;
            });
          },
          onThirdTap: () {
            if (jobStatistic.partTimeJobs == null) return;
            SharedGlobalDataService.instance.jobStatistic =
                jobStatistic.partTimeJobs;
            Get.toNamed(SippoRoutes.sippoJobFilterSearch)?.then((_) {
              SharedGlobalDataService.instance.jobStatistic = null;
            });
          },
        );
      }),
    );
  }
}

class JobStatisticBoardCards extends StatelessWidget {
  final String? firstCardSubtitle;
  final String? secondCardSubtitle;
  final String? thirdCardSubtitle;
  final VoidCallback? onFirstTap;
  final VoidCallback? onSecondTap;
  final VoidCallback? onThirdTap;
  final JobStatisticsModel? jobStatistics;

  const JobStatisticBoardCards({
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
