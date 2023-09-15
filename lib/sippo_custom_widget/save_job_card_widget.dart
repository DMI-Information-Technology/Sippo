import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
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

class JobPostingCard extends StatelessWidget {
  final String? imagePath;

  // final String jobTitle;
  // final String companyLocation;
  // final String jobType;
  // final String jobCategory;
  // final String jobPosition;
  final String timeAgo;
  final bool isEditable;
  final void Function(CordLocation? location)? onAddressTextTap;

  // final String salary;
  final VoidCallback onActionTap;
  final bool isSaved;
  final CompanyJobModel? jobDetailsPost;

  const JobPostingCard({
    this.imagePath,
    required this.timeAgo,
    required this.onActionTap,
    this.isSaved = false,
    this.jobDetailsPost,
    this.isEditable = false,
    this.onAddressTextTap,
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
                  jobDetailsPost?.specialization?.name,
                  true,
                ),
                _buildCustomChip(context, jobDetailsPost?.employmentType),
                _buildCustomChip(context, jobDetailsPost?.workplaceType),
                _buildCustomChip(
                  context,
                  jobDetailsPost?.experienceLevel?.label,
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

  Widget _buildTopImageButtonOptionCard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.fromWidth(CustomStyle.paddingValue),
      ),
      child: Row(
        children: [
          NetworkBorderedCircularImage(
            imageUrl: imagePath ?? '',
            size: context.fromHeight(CustomStyle.imageSize3),
            outerBorderColor: jobDetailsPost?.isActive == true
                ? Colors.greenAccent
                : Colors.redAccent,
            errorWidget: (context, url, error) =>
                Image.asset(JobstopPngImg.companysignup),
          ),
          const Spacer(),
          _buildActionButton(context),
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
              size: (kIsWeb ? height : width) / 16,
            )
          : Image.asset(
              this.isSaved ? JobstopPngImg.dots : JobstopPngImg.order,
              height: (kIsWeb ? height : width) / 16,
              color: Colors.black,
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
            jobDetailsPost?.title ?? "unknown",
            style: dmsbold.copyWith(
              fontSize: FontSize.title6(context),
              color: Colors.black,
            ),
          ),
          SizedBox(height: context.height / CustomStyle.varyHuge),
          Wrap(
            children: [
              AutoSizeText(
                "${jobDetailsPost?.company?.name ?? 'unknown'}, ",
                style: dmsregular.copyWith(
                  fontSize: FontSize.title6(context),
                  color: Colors.grey,
                ),
              ),
              InkWell(
                onTap: () {
                  if (onAddressTextTap != null)
                    onAddressTextTap!(
                      jobDetailsPost?.company?.locations?.first.location,
                    );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Jobstopcolor.primarycolor,
                      size: context.fromHeight(CustomStyle.xxl),
                    ),
                    AutoSizeText(
                      jobDetailsPost?.company?.city?.capitalize ?? 'unknown',
                      style: dmsregular.copyWith(
                          fontSize: FontSize.paragraph4(context),
                          color: Jobstopcolor.primarycolor,
                          decoration: TextDecoration.underline,
                          decorationColor: Jobstopcolor.primarycolor),
                    ),
                  ],
                ),
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
          Text(
            timeAgo,
            style: dmsregular.copyWith(
              fontSize: FontSize.label(context),
              color: Colors.grey,
            ),
          ),
          const Spacer(),
          Text(
            '${jobDetailsPost?.salaryFrom.toString().salaryValue} - ${jobDetailsPost?.salaryTo.toString().salaryValue}',
            style: dmsbold.copyWith(
              fontSize: FontSize.title5(context),
              color: Jobstopcolor.primarycolor, // Use appropriate color
            ),
          ),
          Text(
            '/Yr',
            style: dmsregular.copyWith(
              fontSize: FontSize.label(context),
              color: Colors.grey,
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
      onTap: () {},
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

class NetworkBorderedCircularImage extends StatelessWidget {
  const NetworkBorderedCircularImage({
    super.key,
    required this.imageUrl,
    this.size = 50,
    this.outerBorderColor,
    this.innerBorderColor,
    this.errorWidget,
  });

  final double size;
  final Color? outerBorderColor;
  final Color? innerBorderColor;
  final String imageUrl;
  final Widget Function(BuildContext context, String url, dynamic error)?
      errorWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: outerBorderColor ?? Colors.grey,
          width: context.fromWidth(CustomStyle.xxxl),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: innerBorderColor ?? Colors.white,
            width: context.fromWidth(CustomStyle.varyHuge),
          ),
        ),
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            width: size,
            height: size,
            errorWidget: errorWidget,
          ),
        ),
      ),
    );
  }
}
