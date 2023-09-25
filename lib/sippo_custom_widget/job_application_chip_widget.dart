import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../JobGlobalclass/jobstopfontstyle.dart';
import '../JobGlobalclass/text_font_size.dart';
import '../sippo_data/model/notification/job_application_model.dart';
import '../sippo_data/model/notification/job_application_status_model.dart';

class JobApplicationStatusChipWidget extends StatelessWidget {
  const JobApplicationStatusChipWidget({
    super.key,
    required this.statusType,
  });

  static final applicationStatus =
      <JobApplicationStatusType, JobApplicationStatusModel>{
    JobApplicationStatusType.Accepted: JobApplicationStatusModel(
      text: 'app_accepted'.tr,
      textColor: Colors.green,
      backgroundColor: Colors.green[100],
    ),
    JobApplicationStatusType.Rejected: JobApplicationStatusModel(
      text: 'app_rejected'.tr,
      textColor: Colors.red,
      backgroundColor: Colors.red[100],
    ),
    JobApplicationStatusType.Pending: JobApplicationStatusModel(
      text: "app_sent".tr,
      textColor: Colors.blue,
      backgroundColor: Colors.blue[100],
    ),
  };

  final JobApplicationStatusType statusType;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.all(width / 64),
        child: AutoSizeText(
          applicationStatus[statusType]?.text ?? "",
          style: dmsregular.copyWith(
            color: applicationStatus[statusType]?.textColor,
            fontSize: FontSize.label(context),
          ),
        ),
      ),
      color: applicationStatus[statusType]?.backgroundColor,
    );
  }
}
