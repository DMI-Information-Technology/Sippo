import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/jobstopimges.dart';
import 'package:sippo/JobGlobalclass/media_query_sizes.dart';
import 'package:sippo/sippo_custom_widget/rounded_border_radius_card_widget.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';
import 'package:sippo/sippo_data/model/application_model/application_job_company_model.dart';
import 'package:sippo/sippo_data/model/auth_model/company_response_details.dart';
import 'package:sippo/sippo_data/model/notification/job_application_model.dart';
import 'package:sippo/utils/helper.dart';

import '../JobGlobalclass/jobstopcolor.dart';
import '../JobGlobalclass/jobstopfontstyle.dart';
import '../JobGlobalclass/sippo_customstyle.dart';
import '../JobGlobalclass/text_font_size.dart';
import '../sippo_data/model/profile_model/profile_resource_model/cv_file_model.dart';
import 'job_application_chip_widget.dart';
import 'network_bordered_circular_image_widget.dart';

class UserApplicationWidget extends StatelessWidget {
  final VoidCallback? onDeletePressed;
  final VoidCallback onTap;
  final CompanyDetailsModel? company;
  final ApplicationUserModel? application;
  final bool isSelected;
  final VoidCallback? onPopupNotificationButtonTapped;

  UserApplicationWidget({
    this.onDeletePressed,
    required this.onTap,
    this.application,
    this.onPopupNotificationButtonTapped,
    this.isSelected = false,
    this.company,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: RoundedBorderRadiusCardWidget(
        paddingType: PaddingType.all,
        color: isSelected ? SippoColor.primary : Colors.white,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NetworkBorderedCircularImage(
                  imageUrl: company?.profileImage?.url ?? '',
                  size: context.fromHeight(CustomStyle.xs),
                  outerBorderColor: Colors.grey[200],
                  outerBorderWidth: context.fromWidth(CustomStyle.huge2),
                  errorWidget: (context, url, error) {
                    return Image.asset(JobstopPngImg.companysignup);
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
                    onTap: onPopupNotificationButtonTapped,
                    child: Icon(
                      Icons.more_vert_rounded,
                    ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: context.fromHeight(CustomStyle.xl)),
          Text(
            application?.createdAt != null
                ? calculateElapsedTimeFromStringDate(
                      application?.createdAt ?? '',
                    ) ??
                    ''
                : "",
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
      ),
    );
  }

  Widget _buildMainDetailsApplication(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            application?.job?.title ?? application?.company?.name ?? "",
            style: dmsbold.copyWith(
              fontSize: FontSize.title6(context),
              color: SippoColor.black,
            ),
          ),
          if (application?.job?.title != null) ...[
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
          ],
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

class UserJobApplicationWidget extends StatelessWidget {
  final void Function(String? cvUrl, [String? size])? onShowCvTap;
  final CompanyDetailsModel? company;
  final ApplicationCompanyModel? application;
  final bool isSubscribed;

  UserJobApplicationWidget({
    required this.onShowCvTap,
    this.application,
    this.company,
    this.isSubscribed = false,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedBorderRadiusCardWidget(
      paddingType: PaddingType.all,
      color: SippoColor.backgroudHome,
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
                imageUrl: company?.profileImage?.url ?? '',
                size: context.fromHeight(CustomStyle.s),
                outerBorderColor: Colors.grey[300],
                errorWidget: (context, _, __) => const CircleAvatar(),
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
            onTapped: () {
              final cvUrl = cv?.url;
              print(application);
              onShowCvTap?.call(cvUrl, cv?.size);
            },
            maxLine: 2,
            textPadding: const EdgeInsets.symmetric(vertical: 12),
            text: "show_cv".tr,
            backgroundColor: cv == null ? Colors.grey : SippoColor.lightprimary,
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
              color: SippoColor.black,
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

class UserCompanyApplicationWidget extends StatelessWidget {
  const UserCompanyApplicationWidget({
    super.key,
    this.onShowCvTap,
    this.company,
    this.cv,
    this.applicationStatus,
    this.isSubscribed = false,
  });

  final void Function(String cvUrl, [String? size])? onShowCvTap;
  final CompanyDetailsModel? company;
  final String? applicationStatus;
  final CvModel? cv;
  final bool isSubscribed;

  @override
  Widget build(BuildContext context) {
    final myCv = cv;
    return RoundedBorderRadiusCardWidget(
      margin: EdgeInsets.symmetric(
        horizontal: context.fromWidth(CustomStyle.paddingValue),
      ),
      color: SippoColor.backgroudHome,
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
              child: CustomButton(
                fitHeight: true,
                onTapped: () {
                  final cvUrl = myCv?.url;
                  if (cvUrl != null) {
                    onShowCvTap?.call(cvUrl, myCv?.size);
                  }
                },
                maxLine: 2,
                textPadding: const EdgeInsets.symmetric(vertical: 12),
                text: "show_cv".tr,
                backgroundColor:
                    cv == null ? Colors.grey : SippoColor.lightprimary,
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
