import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/media_query_sizes.dart';
import 'package:sippo/JobGlobalclass/sippo_customstyle.dart';
import 'package:sippo/sippo_controller/company_display_posts_job_controller/company_show_job_post_wrapper_controller.dart';
import 'package:sippo/sippo_custom_widget/ConditionalWidget.dart';
import 'package:sippo/sippo_custom_widget/body_widget.dart';
import 'package:sippo/sippo_custom_widget/error_messages_dialog_snackbar/network_connnection_lost_widget.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';

import 'company_post_and_jobs/show_company_jobs.dart';
import 'company_post_and_jobs/show_company_posts.dart';

class SippoJobsPostsCompanyWrapper extends StatefulWidget {
  const SippoJobsPostsCompanyWrapper({Key? key}) : super(key: key);

  @override
  State<SippoJobsPostsCompanyWrapper> createState() =>
      _SippoJobsPostsCompanyWrapperState();
}

class _SippoJobsPostsCompanyWrapperState
    extends State<SippoJobsPostsCompanyWrapper> {
  final _controller = Get.put(CompanyShowJobPostWrapperController());

  final _tabs = const [ShowCompanyPostsList(), ShowCompanyJobsList()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyWidget(
        isTopScrollable: true,
        topScreen: Column(
          children: [
            Obx(() => ConditionalWidget(
                  !_controller.isNetworkConnected,
                  guaranteedBuilder: (_, __) => NetworkStatusNonWidget(
                    isPositioned: false,
                    color: Colors.black54,
                  ),
                  avoidBuilder: (_, __) => SizedBox(
                    height: context.fromHeight(CustomStyle.spaceBetween),
                  ),
                )),
          ],
        ),
        paddingContent: EdgeInsets.symmetric(
          horizontal: context.width / 36,
        ),
        child: Obx(() => _tabs[_controller.selected]),
        paddingBottom: EdgeInsets.only(
          bottom: context.height / CustomStyle.xxl,
          top: context.height / CustomStyle.xxl,
          left: context.width / 36,
          right: context.width / 36,
        ),
        bottomScreen: _buildBottomControlButtons(context),
      ),
    );
  }

  Widget _buildBottomControlButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(() => SizedBox(
              width: context.width / 2.2,
              height: context.height / 18,
              child: CustomButton(
                onTapped: () {
                  _controller.switchSelectedTap(0);
                },
                text: "posts".tr,
                backgroundColor: _controller.selected == 0
                    ? SippoColor.primarycolor
                    : SippoColor.lightprimary,
                textColor: _controller.selected == 0
                    ? SippoColor.white
                    : SippoColor.primarycolor,
              ),
            )),
        Obx(() => SizedBox(
              width: context.width / 2.2,
              height: context.height / 18,
              child: CustomButton(
                onTapped: () {
                  _controller.resetStates();
                  _controller.switchSelectedTap(1);
                },
                text: "jobs".tr,
                backgroundColor: _controller.selected == 1
                    ? SippoColor.primarycolor
                    : SippoColor.lightprimary,
                textColor: _controller.selected == 1
                    ? SippoColor.white
                    : SippoColor.primarycolor,
              ),
            )),
      ],
    );
  }
}
