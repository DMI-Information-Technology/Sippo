import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/JopController/NotificationController/user_notification_application/user_application_controller.dart';
import 'package:jobspot/sippo_custom_widget/resume_card_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';

import '../../../sippo_custom_widget/network_bordered_circular_image_widget.dart';

class JobApplication extends StatelessWidget {
  const JobApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = context.width;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.fromWidth(CustomStyle.s),
          ),
          child: Column(
            children: [
              AutoSizeText(
                "Your application",
                style: dmsbold.copyWith(
                  fontSize: FontSize.title3(context),
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
              _buildApplicationContainer(context),
              SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
              SizedBox(
                width: width / 1.5,
                child: CustomButton(
                  onTapped: () {},
                  text: "Apply for more jobs",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildApplicationContainer(BuildContext context) {
    final applicationController = UserApplicationController.instance;

    return Container(
      margin: EdgeInsets.only(
        bottom: context.fromHeight(CustomStyle.l),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Colors.grey,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.fromWidth(CustomStyle.s),
          vertical: context.fromHeight(CustomStyle.m),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NetworkBorderedCircularImage(
              imageUrl: applicationController.userApplicationState.application
                      .company?.profileImage?.url ??
                  '',
              errorWidget: (context, url, error) => CircleAvatar(),
              outerBorderColor: Colors.grey[300],
              size: context.fromHeight(CustomStyle.xs),
            ),
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
            Text(
              applicationController
                      .userApplicationState.application.job?.title ??
                  '',
              style: dmsbold.copyWith(
                fontSize: FontSize.title6(context),
                color: Colors.black87,
              ),
            ),
            SizedBox(height: context.fromHeight(CustomStyle.huge2)),
            Text(
              "${applicationController.userApplicationState.application.company?.name ?? ''}"
              ". California, USA",
              style: TextStyle(
                fontSize: FontSize.label(context),
                color: Colors.grey,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: context.fromHeight(CustomStyle.huge2)),
            _buildDetailRow(
              context,
              "Shipped on ${applicationController.userApplicationState.application.createdAt ?? ''}",
            ),
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
            Text(
              "Job details",
              style: dmsbold.copyWith(
                fontSize: FontSize.title6(context),
                color: Colors.black87,
              ),
            ),
            _buildDetailRow(
              context,
              applicationController.userApplicationState.application.job
                      ?.specialization?.name ??
                  '',
            ),
            _buildDetailRow(
              context,
              applicationController
                      .userApplicationState.application.job?.employmentType ??
                  "",
            ),
            _buildDetailRow(
              context,
              applicationController.userApplicationState.application.job
                      ?.experienceLevel?.label ??
                  "",
            ),
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
            Text(
              "Application details",
              style: dmsbold.copyWith(
                fontSize: FontSize.title6(context),
                color: Colors.black87,
              ),
            ),
            _buildDetailRow(context, "CV/Resume"),
            SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
            Card(
              margin: EdgeInsets.zero,
              color: Jobstopcolor.lightprimary2,
              child: Padding(
                padding: EdgeInsets.all(context.fromWidth(CustomStyle.m)),
                child: CvCardWidget.fromRemote(
                  remoteCv:
                      applicationController.userApplicationState.application.cv,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String text) {
    return Row(
      children: [
        Image.asset(
          JobstopPngImg.dot,
          height: context.fromHeight(CustomStyle.huge2),
          color: Colors.grey,
        ),
        SizedBox(height: context.fromWidth(CustomStyle.spaceBetween)),
        Text(
          text,
          style: TextStyle(
            fontSize: FontSize.label(context),
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
