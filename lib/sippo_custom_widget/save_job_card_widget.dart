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
import '../sippo_data/model/profile_model/company_profile_resource_model/work_location_model.dart';

class JobPostingCard extends StatelessWidget {
  final String? imagePath;
  final List<WorkLocationModel>? companyLocations;
  final String? companyName;
  final bool? isActive;
  final String? timeAgo;
  final bool isEditable;
  final void Function(CordLocation? location)? onAddressTextTap;
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
    this.companyLocations,
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
              imageUrl: imagePath ?? '',
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
                "${(jobDetails?.company?.name ?? companyName) ?? 'unknown'}, ",
                style: dmsregular.copyWith(
                  fontSize: FontSize.title6(context),
                  color: Colors.grey,
                ),
              ),
              InkWell(
                onTap: () {
                  if (onAddressTextTap != null)
                    onAddressTextTap!(
                      CordLocation(
                        latitude: jobDetails?.latitude.toString(),
                        longitude: jobDetails?.longitude.toString(),
                      ),
                    );
                },
                child: FutureBuilder(
                    future: Future.value(
                      jobDetails?.company?.locations ?? companyLocations,
                    ),
                    builder: (context, snapshot) {
                      final result = snapshot.data;
                      if (result == null) return const SizedBox.shrink();
                      final workPlace = result.firstWhereOrNull((e) {
                        return e.location?.dLatitude == jobDetails?.latitude &&
                            e.location?.dLongitude == jobDetails?.longitude;
                      });
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Jobstopcolor.primarycolor,
                            size: context.fromHeight(CustomStyle.xxl),
                          ),
                          AutoSizeText(
                            workPlace?.address?.capitalize ?? 'unknown',
                            style: dmsregular.copyWith(
                                fontSize: FontSize.paragraph4(context),
                                color: Jobstopcolor.primarycolor,
                                decoration: TextDecoration.underline,
                                decorationColor: Jobstopcolor.primarycolor),
                          ),
                        ],
                      );
                    }),
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
            '${jobDetails?.salaryFrom.toString().salaryValue} - ${jobDetails?.salaryTo.toString().salaryValue}',
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

class NetworkBorderedCircularImage extends StatelessWidget {
  const NetworkBorderedCircularImage({
    super.key,
    required this.imageUrl,
    this.size = 50,
    this.outerBorderColor,
    this.innerBorderColor,
    this.errorWidget,
    this.backgroundColor,
  });

  final Color? backgroundColor;
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
          color: backgroundColor,
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
