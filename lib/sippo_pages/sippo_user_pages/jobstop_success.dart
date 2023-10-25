import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/JopController/user_core_functions/apply_jobs_controllers.dart';
import 'package:jobspot/sippo_custom_widget/ConditionalWidget.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/error_messages_dialog_snackbar/network_connnection_lost_widget.dart';
import 'package:jobspot/sippo_custom_widget/top_job_details_header.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';

class JobSuccess extends StatefulWidget {
  const JobSuccess({Key? key}) : super(key: key);

  @override
  State<JobSuccess> createState() => _JobSuccessState();
}

class _JobSuccessState extends State<JobSuccess> {
  final _controller = Get.find<ApplyJobsController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image.asset(JobstopPngImg.dots),
          ),
        ],
      ),
      body: BodyWidget(
        isScrollable: true,
        paddingContent: EdgeInsets.symmetric(
          horizontal: context.fromWidth(CustomStyle.paddingValue),
          vertical: context.fromHeight(CustomStyle.paddingValue),
        ),
        topScreen: _buildTopJobDetailsHeader(context),
        connectionStatusBar: Obx(() => ConditionalWidget(
              !InternetConnectionService.instance.isConnected,
              guaranteedBuilder: (_, __) =>
                  NetworkStatusNonWidget(color: Colors.black54),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Jobstopcolor.primary,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width / 26, vertical: height / 46),
                child: Row(
                  children: [
                    Image.asset(
                      JobstopPngImg.pdf,
                      height: height / 16,
                    ),
                    SizedBox(
                      width: width / 36,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _controller.applyJobsState.cvJobApply.filename ?? '',
                          style: dmsregular.copyWith(
                              fontSize: 12, color: Jobstopcolor.primarycolor),
                        ),
                        SizedBox(
                          height: height / 150,
                        ),
                        Text(
                          _controller.applyJobsState.cvJobApply.sizeToString,
                          style: dmsregular.copyWith(
                              fontSize: 12, color: Jobstopcolor.grey),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height / 36,
            ),
            Image.asset(
              JobstopPngImg.successful1,
              height: height / 4,
            ),
            SizedBox(
              height: height / 36,
            ),
            Text(
              "Successful".tr,
              style:
                  dmsbold.copyWith(fontSize: 16, color: Jobstopcolor.darkgrey),
            ),
            SizedBox(
              height: height / 46,
            ),
            Text(
              "Congratulations, your application has been sent".tr,
              style: dmsregular.copyWith(
                  fontSize: 12, color: Jobstopcolor.darkgrey),
            ),
            SizedBox(
              height: height / 16,
            ),
          ],
        ),
        paddingBottom: EdgeInsets.all(
          context.fromWidth(CustomStyle.paddingValue),
        ),
        bottomScreen: Column(
          children: [
            CustomButton(
              onTapped: () {},
              text: "Find Another Job".tr,
              backgroundColor: Jobstopcolor.lightprimary,
              textColor: Jobstopcolor.primarycolor,
            ),
            SizedBox(height: height / 36),
            CustomButton(
              onTapped: () {
                Get.until((route) {
                  return Get.currentRoute == SippoRoutes.userDashboard;
                });
              },
              text: "Back to home".tr,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopJobDetailsHeader(BuildContext context) {
    return Obx(() => TopJobDetailsHeader(
          isConnectionLost: !InternetConnectionService.instance.isConnected,
          coverHeight: context.height / 3.5,
          profileImageSize: context.height / 6,
          backgroundImageColor: Colors.white,
          imageUrl: _controller
                  .applyJobsState.jopDetails.company?.profileImage?.url ??
              "",
          // onLeadingTap: () => Get.back(),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
            ),
          ],
        ));
  }

// Widget _buildTopJobInfo(BuildContext context) {
//   return Container(
//     child: Column(
//       children: [
//         Obx(() => Text(
//               _controller.applyJobsState.jopDetails.title ?? '',
//               style: dmsbold.copyWith(
//                 fontSize: FontSize.title2(context),
//                 color: Jobstopcolor.primarycolor,
//               ),
//               overflow: TextOverflow.clip,
//             )),
//         SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
//         Obx(() => _buildTopInfoJobText(
//               context,
//               'Company name',
//               _controller.applyJobsState.jopDetails.company?.name ?? '',
//             )),
//         SizedBox(height: context.fromHeight(CustomStyle.huge2)),
//         Obx(() => _buildTopInfoJobText(
//               context,
//               'Work place',
//               _controller.applyJobsState.jopDetails.company?.city ?? '',
//             )),
//         SizedBox(height: context.fromHeight(CustomStyle.huge2)),
//         Obx(() => _buildTopInfoJobText(
//               context,
//               'Publish time',
//               calculateElapsedTimeFromStringDate(
//                     _controller.applyJobsState.jopDetails.createdAt,
//                   ) ??
//                   "",
//             )),
//       ],
//     ),
//   );
// }
//
// Widget _buildTopInfoJobText(
//   BuildContext context,
//   String label,
//   String content,
// ) {
//   return SizedBox(
//     width: context.width,
//     child: Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         AutoSizeText(
//           label,
//           style: dmsregular.copyWith(
//             fontSize: FontSize.title4(context),
//             color: Jobstopcolor.primarycolor,
//           ),
//           overflow: TextOverflow.clip,
//         ),
//         SizedBox(width: context.fromWidth(CustomStyle.xxxl)),
//         Expanded(
//           child: AutoSizeText(
//             content,
//             style: dmsmedium.copyWith(
//               fontSize: FontSize.title4(context),
//               color: Jobstopcolor.primarycolor,
//             ),
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ],
//     ),
//   );
// }
}
