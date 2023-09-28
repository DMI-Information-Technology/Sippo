import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/sippo_custom_widget/rounded_border_radius_card_widget.dart';
import 'package:jobspot/sippo_custom_widget/save_job_card_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/sippo_data/model/auth_model/company_response_details.dart';
import 'package:jobspot/sippo_data/model/notification/job_application_model.dart';
import 'package:jobspot/utils/helper.dart';

import '../JobGlobalclass/jobstopcolor.dart';
import '../JobGlobalclass/jobstopfontstyle.dart';
import '../JobGlobalclass/jobstopimges.dart';
import '../JobGlobalclass/sippo_customstyle.dart';
import '../JobGlobalclass/text_font_size.dart';
import '../sippo_data/model/profile_model/company_profile_resource_model/application_job_company_model.dart';
import '../sippo_data/model/profile_model/profile_resource_model/cv_file_model.dart';
import 'job_application_chip_widget.dart';

class NotificationApplicationWidget extends StatelessWidget {
  final VoidCallback? onDeletePressed;
  final VoidCallback onTap;
  final CompanyDetailsResponseModel? company;
  final ApplicationCompanyModel? application;
  final bool isSelected;
  final VoidCallback? onPopupNotificationButtonTapped;
  final bool isCompany;

  NotificationApplicationWidget({
    this.onDeletePressed,
    required this.onTap,
    this.application,
    this.onPopupNotificationButtonTapped,
    required this.isSelected,
    this.company,
    this.isCompany = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: RoundedBorderRadiusCardWidget(
        paddingType: PaddingType.all,
        color: isSelected ? Jobstopcolor.primary : Colors.white,
        margin: EdgeInsets.symmetric(
          horizontal: context.fromWidth(CustomStyle.s),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NetworkBorderedCircularImage(
                  imageUrl: '',
                  size: context.fromHeight(CustomStyle.s),
                  outerBorderColor: Colors.grey[300],
                  errorWidget: (context, url, error) {
                    return Image.asset(
                      JobstopPngImg.google,
                      height: context.fromWidth(CustomStyle.xs),
                    );
                  },
                ),
                SizedBox(
                  width: context.fromWidth(CustomStyle.spaceBetween),
                ),
                _buildMainDetailsApplication(context),
                SizedBox(
                  width: context.fromWidth(CustomStyle.spaceBetween),
                ),
                if (onPopupNotificationButtonTapped != null)
                  InkWell(
                    onTap: onPopupNotificationButtonTapped ??
                        () => print("null bottom sheet function"),
                    child: Icon(Icons.more_vert_rounded),
                  ),
              ],
            ),
            SizedBox(height: context.fromHeight(CustomStyle.huge2)),
            _buildDeleteButtonAndArrivalTimeRow(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDeleteButtonAndArrivalTimeRow(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: context.fromHeight(14)),
        Text(
          calculateElapsedTimeFromStringDate(application?.createdAt ?? '') ??
              "",
          style: TextStyle(
            fontSize: FontSize.label(context),
            color: Colors.grey,
          ),
        ),
        if (onDeletePressed != null) ...[
          Spacer(),
          TextButton(
            onPressed: onDeletePressed,
            child: Text(
              'delete'.tr,
              style: TextStyle(
                fontSize: FontSize.title6(context),
                color: Colors.red,
              ),
            ),
          )
        ],
      ],
    );
  }

  Widget _buildMainDetailsApplication(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            application?.job?.title ?? "",
            style: dmsbold.copyWith(
              fontSize: FontSize.title6(context),
              color: Jobstopcolor.black,
            ),
          ),
          SizedBox(
            height: context.fromHeight(CustomStyle.huge2),
          ),
          AutoSizeText(
            company?.name ?? "",
            style: TextStyle(
              fontSize: FontSize.paragraph4(context),
              color: Colors.grey,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (application?.status != null) ...[
            SizedBox(
              height: context.fromHeight(CustomStyle.huge2),
            ),
            _buildJobApplicationStatusChipWidget(context, application?.status),
          ],
        ],
      ),
    );
  }

  Widget _buildJobApplicationStatusChipWidget(
    BuildContext context,
    String? status,
  ) {
    if (status == null) return const SizedBox.shrink();
    return switch (status) {
      'Accepted' => JobApplicationStatusChipWidget(
          statusType: ApplicationStatusType.Accepted,
        ),
      'Rejected' => JobApplicationStatusChipWidget(
          statusType: ApplicationStatusType.Rejected,
        ),
      'Pending' => JobApplicationStatusChipWidget(
          statusType: ApplicationStatusType.Pending,
        ),
      _ => const SizedBox.shrink(),
    };
  }
}

class NotificationJobApplicationWidget extends StatelessWidget {
  final void Function(String cvUrl)? onShowCvTap;
  final CompanyDetailsResponseModel? company;
  final ApplicationCompanyModel? application;

  NotificationJobApplicationWidget({
    required this.onShowCvTap,
    this.application,
    this.company,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedBorderRadiusCardWidget(
      paddingType: PaddingType.all,
      color: Jobstopcolor.backgroudHome,
      margin: EdgeInsets.symmetric(
        horizontal: context.fromWidth(CustomStyle.paddingValue),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NetworkBorderedCircularImage(
                imageUrl: '',
                size: context.fromHeight(CustomStyle.s),
                outerBorderColor: Colors.grey[300],
                errorWidget: (context, url, error) {
                  return Image.asset(
                    JobstopPngImg.google,
                    height: context.fromWidth(CustomStyle.xs),
                  );
                },
              ),
              SizedBox(
                width: context.fromWidth(CustomStyle.spaceBetween),
              ),
              _buildMainDetailsApplication(context),
            ],
          ),
          SizedBox(height: context.fromHeight(CustomStyle.huge2)),
          _buildShowCvUser(context),
        ],
      ),
    );
  }

  Widget _buildShowCvUser(BuildContext context) {
    final cv = application?.cv;
    return Row(
      children: [
        SizedBox(
          width: context.fromHeight(CustomStyle.xs),
        ),
        SizedBox(
          width: context.width / 3,
          height: context.height / 21,
          child: CustomButton(
            onTapped: onShowCvTap != null && cv != null
                ? () {
                    final cvUrl = cv.url;
                    if (cvUrl != null) {
                      onShowCvTap!(cvUrl);
                    }
                  }
                : null,
            text: "Show CV",
            backgroundColor:
                cv == null ? Colors.grey : Jobstopcolor.lightprimary,
            textColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildMainDetailsApplication(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            application?.job?.title ?? "",
            style: dmsbold.copyWith(
              fontSize: FontSize.title6(context),
              color: Jobstopcolor.black,
            ),
          ),
          SizedBox(
            height: context.fromHeight(CustomStyle.huge2),
          ),
          AutoSizeText(
            company?.name ?? "",
            style: TextStyle(
              fontSize: FontSize.paragraph4(context),
              color: Colors.grey,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (application?.status != null) ...[
            SizedBox(
              height: context.fromHeight(CustomStyle.huge2),
            ),
            _buildJobApplicationStatusChipWidget(context, application?.status),
          ],
        ],
      ),
    );
  }

  Widget _buildJobApplicationStatusChipWidget(
    BuildContext context,
    String? status,
  ) {
    if (status == null) return const SizedBox.shrink();
    return switch (status) {
      'Accepted' => JobApplicationStatusChipWidget(
          statusType: ApplicationStatusType.Accepted,
        ),
      'Rejected' => JobApplicationStatusChipWidget(
          statusType: ApplicationStatusType.Rejected,
        ),
      'Pending' => JobApplicationStatusChipWidget(
          statusType: ApplicationStatusType.Pending,
        ),
      _ => const SizedBox.shrink(),
    };
  }
}

class CompanyNotificationApplicationWidget extends StatelessWidget {
  const CompanyNotificationApplicationWidget({
    super.key,
    this.onShowCvTap,
    this.company,
    this.cv,
    this.applicationStatus,
  });

  final void Function(String cvUrl)? onShowCvTap;
  final CompanyDetailsResponseModel? company;
  final String? applicationStatus;
  final CvModel? cv;

  @override
  Widget build(BuildContext context) {
    final myCv = cv;
    return RoundedBorderRadiusCardWidget(
      margin: EdgeInsets.symmetric(
        horizontal: context.fromWidth(CustomStyle.paddingValue),
      ),
      color: Jobstopcolor.backgroudHome,
      child: SizedBox(
        width: context.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (applicationStatus != null) ...[
              JobApplicationStatusChipWidget.getApplicationStatusWidget(
                applicationStatus,
              ),
            ],
            SizedBox(height: context.fromHeight(CustomStyle.huge2)),
            SizedBox(
              width: context.width / 3,
              height: context.height / 21,
              child: CustomButton(
                onTapped: onShowCvTap != null && myCv != null
                    ? () {
                        final cvUrl = myCv.url;
                        if (cvUrl != null) {
                          onShowCvTap!(cvUrl);
                        }
                      }
                    : null,
                text: "Show CV",
                backgroundColor:
                    cv == null ? Colors.grey : Jobstopcolor.lightprimary,
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
