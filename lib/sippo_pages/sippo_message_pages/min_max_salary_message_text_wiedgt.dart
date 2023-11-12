import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/sippo_controller/company_profile_controller/company_edit_add_job_controller.dart';

class MinMaxSalaryMessageTextWidget extends StatelessWidget {
  const MinMaxSalaryMessageTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '${'accepted_range_salary'.tr} '
      '${"from".tr} ${CompanyEditAddJobState.MIN_SALARY_RANGE} '
      '${"to".tr} ${CompanyEditAddJobState.MAX_SALARY_RANGE}',
      textAlign: TextAlign.start,
      style: dmsregular.copyWith(
        fontSize: FontSize.title6(context),
        color: SippoColor.secondary,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
