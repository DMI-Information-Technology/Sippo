import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/sippo_custom_widget/rounded_border_radius_card_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/utils/string_formtter.dart';

import '../JobGlobalclass/jobstopcolor.dart';
import '../JobGlobalclass/jobstopfontstyle.dart';
import '../JobGlobalclass/jobstopimges.dart';
import '../JobGlobalclass/text_font_size.dart';
import '../sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';
import '../sippo_data/model/profile_model/company_profile_resource_model/cord_location.dart';
import 'network_bordered_circular_image_widget.dart';

class JobPostingCard extends StatelessWidget {
  final String? imagePath;
  final String? companyName;
  final bool? isActive;
  final String? timeAgo;
  final bool isEditable;
  final void Function(CoordLocation? location)? onAddressTextTap;
  final bool isSaved;

  // final String salary;
  final VoidCallback? onActionTap;
  final VoidCallback? onImageCompanyTap;
  final CompanyJobModel? jobDetails;

  const JobPostingCard({
    this.imagePath,
    this.timeAgo,
    this.onActionTap,
    this.jobDetails,
    this.isEditable = false,
    this.onAddressTextTap,
    this.companyName,
    this.isActive,
    this.isSaved = false,
    this.onImageCompanyTap,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    return RoundedBorderRadiusCardWidget(
      paddingType: PaddingType.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopImageButtonOptionCard(context),
          SizedBox(height: height / 64),
          _buildTitleAndDescriptionColumn(context),
          SizedBox(height: height / 64),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildCustomChip(
                  context,
                  jobDetails?.specialization?.name,
                  true,
                ),
                _buildCustomChip(context, jobDetails?.employmentType),
                _buildCustomChip(context, jobDetails?.workplaceType),
                _buildCustomChip(
                  context,
                  jobDetails?.experienceLevel?.label,
                ),
              ],
            ),
          ),
          SizedBox(height: height / 64),
          _buildArriveTimeAndPriceRow(context),
        ],
      ),
    );
  }

  Color? checkActivityColor(BuildContext _) {
    return switch (isActive) {
      null => Colors.grey[300],
      true => Colors.greenAccent,
      false => Colors.redAccent,
    };
  }

  Widget _buildTopImageButtonOptionCard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.fromWidth(CustomStyle.paddingValue),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: onImageCompanyTap,
            child: NetworkBorderedCircularImage(
              imageUrl:
                  imagePath ?? jobDetails?.company?.profileImage?.url ?? '',
              size: context.fromHeight(CustomStyle.imageSize3),
              outerBorderColor: checkActivityColor(context),
              errorWidget: (context, url, error) =>
                  Image.asset(JobstopPngImg.companysignup),
            ),
          ),
          const Spacer(),
          if (onActionTap != null) _buildActionButton(context),
        ],
      ),
    );
  }

  InkWell _buildActionButton(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return InkWell(
      onTap: onActionTap, // Replace with your function
      child: isEditable
          ? Icon(
              Icons.more_vert_rounded,
              size: (kIsWeb ? height : width) / 14,
            )
          : Icon(
              isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_outlined,
              size: (kIsWeb ? height : width) / 14,
              color: isSaved ? Colors.yellow : Colors.black,
            ),
    );
  }

  Widget _buildTitleAndDescriptionColumn(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.fromWidth(CustomStyle.paddingValue),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            jobDetails?.title ?? "unknown",
            style: dmsbold.copyWith(
              fontSize: FontSize.title6(context),
              color: Colors.black,
            ),
          ),
          SizedBox(height: context.height / CustomStyle.varyHuge),
          Wrap(
            children: [
              AutoSizeText(
                "${(jobDetails?.company?.name ?? companyName) ?? ''}, ",
                style: dmsregular.copyWith(
                  fontSize: FontSize.title6(context),
                  color: Colors.grey,
                ),
              ),
              InkWell(
                onTap: () {
                  if (onAddressTextTap != null)
                    onAddressTextTap!(
                      CoordLocation(
                        latitude: jobDetails?.latitude.toString(),
                        longitude: jobDetails?.longitude.toString(),
                      ),
                    );
                },
                child: jobDetails?.locationAddress?.name != null
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: SippoColor.primarycolor,
                            size: context.fromHeight(CustomStyle.xxl),
                          ),
                          AutoSizeText(
                            jobDetails?.locationAddress?.name ?? '',
                            style: dmsregular.copyWith(
                              fontSize: FontSize.paragraph4(context),
                              color: SippoColor.primarycolor,
                              decoration: TextDecoration.underline,
                              decorationColor: SippoColor.primarycolor,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildArriveTimeAndPriceRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.fromWidth(CustomStyle.paddingValue),
      ),
      child: Row(
        children: [
          if (timeAgo != null)
            Text(
              timeAgo ?? "",
              style: dmsregular.copyWith(
                fontSize: FontSize.label(context),
                color: Colors.grey,
              ),
            ),
          const Spacer(),
          Text(
            '${jobDetails?.salaryFrom.toString().shortStringNumberFormat} - ${jobDetails?.salaryTo.toString().shortStringNumberFormat}',
            style: dmsbold.copyWith(
              fontSize: FontSize.title5(context),
              color: SippoColor.primarycolor, // Use appropriate color
            ),
          ),

        ],
      ),
    );
  }

  CustomChip _buildCustomChip(
    BuildContext context, [
    String? text,
    bool isFirst = false,
  ]) {
    return CustomChip(
      // onTap: () {},
      backgroundColor: Colors.grey[200],
      child: AutoSizeText(
        text ?? 'unknown',
        style: dmsregular.copyWith(
          fontSize: FontSize.label(context),
          color: Colors.black54,
        ),
      ),
      paddingValue: context.fromWidth(CustomStyle.xxxl),
      borderRadius: context.fromWidth(CustomStyle.xxxl),
      margin: EdgeInsets.only(
        left: isFirst
            ? context.fromWidth(
                CustomStyle.paddingValue,
              )
            : 0.0,
        right: context.fromWidth(
          CustomStyle.paddingValue,
        ),
      ),
    );
  }
}
