import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/sippo_custom_widget/rounded_border_radius_card_widget.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/cord_location.dart';
import 'package:jobspot/utils/string_formtter.dart';

import '../JobGlobalclass/jobstopcolor.dart';
import '../JobGlobalclass/jobstopfontstyle.dart';
import '../JobGlobalclass/jobstopimges.dart';
import '../sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';
import 'network_bordered_circular_image_widget.dart';

class JobHomeCard extends StatelessWidget {
  final VoidCallback? onActionTap; // Callback for the favorite button press
  final VoidCallback? onApplyTap; // Callback for the favorite button press
  final VoidCallback? onImageProfileTap;
  final bool canApply;
  final CompanyJobModel? jobDetailsPost;

  const JobHomeCard({
    super.key,
    required this.onCardTap,
    this.onActionTap,
    this.onApplyTap,
    this.canApply = true,
    this.width,
    this.height,
    this.jobDetailsPost,
    this.isEditable = false,
    this.imagePath,
    this.onAddressTextTap,
    this.padding,
    this.onImageProfileTap,
  });

  final bool isEditable;
  final double? width;
  final double? height;
  final VoidCallback onCardTap;
  final String? imagePath;
  final void Function(CoordLocation location)? onAddressTextTap;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCardTap,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: RoundedBorderRadiusCardWidget(
          paddingType: PaddingType.all,
          child: SizedBox(
            width: width,
            height: height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildJobCardHeader(context),
                SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
                AutoSizeText(
                  '${jobDetailsPost?.salaryFrom?.toString().shortStringNumberFormat} -'
                  ' ${jobDetailsPost?.salaryTo?.toString().shortStringNumberFormat} LYD/Mo',
                  style: dmsmedium.copyWith(
                    fontSize: FontSize.title6(context),
                  ),
                ),
                SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
                _buildJobCardChipsAndApply(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildJobCardHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: onImageProfileTap,
          child: NetworkBorderedCircularImage(
            size: context.fromHeight(CustomStyle.imageSize3),
            imageUrl: imagePath ?? '',
            outerBorderColor: Colors.grey[300],
            outerBorderWidth: context.fromWidth(CustomStyle.huge2),
            errorWidget: (context, url, error) => Image.asset(
              JobstopPngImg.google,
            ),
          ),
        ),
        SizedBox(
          width: context.fromWidth(CustomStyle.spaceBetween),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                jobDetailsPost?.title ?? 'unknown',
                style: dmsbold.copyWith(
                  fontSize: FontSize.title5(context),
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.clip,
                ),
              ),
              AutoSizeText(
                jobDetailsPost?.company?.name ?? "unknown",
                style: dmsregular.copyWith(
                  fontSize: FontSize.paragraph3(context),
                  color: Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              _buildAddressTextTap(context),
            ],
          ),
        ),
        if (onActionTap != null) _buildActionButton(context),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return InkWell(
      onTap: onActionTap,
      child: isEditable
          ? Icon(Icons.more_vert_rounded)
          : _buildIsSubscribed(jobDetailsPost?.isSaved),
    );
  }

  Widget _buildIsSubscribed(bool? isSaved) {
    return Icon(
      isSaved == true ? Icons.bookmark : Icons.bookmark_border_rounded,
      color: isSaved == true ? Colors.yellow : null,
    );
  }

  Widget _buildAddressTextTap(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onAddressTextTap != null) {
          onAddressTextTap!(
            CoordLocation(
              latitude: jobDetailsPost?.latitude.toString(),
              longitude: jobDetailsPost?.longitude.toString(),
            ),
          );
        }
      },
      child: FutureBuilder(
          future: Future.value(jobDetailsPost?.locationAddress?.name),
          builder: (context, snapshot) {
            final result = snapshot.data;
            if (result == null) return const SizedBox.shrink();
            return AutoSizeText(
              result,
              style: dmsregular.copyWith(
                fontSize: FontSize.paragraph3(context),
                color: Jobstopcolor.primarycolor,
                decoration: TextDecoration.underline,
                decorationColor: Jobstopcolor.primarycolor,
              ),
              overflow: TextOverflow.ellipsis,
            );
          }),
    );
  }

  Widget _buildJobCardChipsAndApply(BuildContext context) {
    // double height = size.height;

    return Row(
      children: [
        _buildChipChildrenList(context),
        if (canApply)
          InkWell(
            onTap: onApplyTap,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.fromWidth(CustomStyle.xxxl)),
              child: Chip(
                label: AutoSizeText(
                  "Apply".tr,
                  style: dmsmedium.copyWith(
                    fontSize: FontSize.label(context),
                  ),
                ),
                backgroundColor: Colors.orangeAccent[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildChipChildrenList(BuildContext context) {
    return FutureBuilder(
        future: Future.value([
          jobDetailsPost?.specialization?.name,
          jobDetailsPost?.experienceLevel?.label,
          jobDetailsPost?.workplaceType,
          jobDetailsPost?.employmentType,
        ]),
        builder: (_, snapshot) {
          final data = snapshot.data;
          return Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: data == null || data.isEmpty
                  ? const SizedBox.shrink()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: data.map((chipText) {
                        return Padding(
                          padding: EdgeInsets.only(
                            right: context.fromWidth(CustomStyle.xxxl),
                          ),
                          child: Chip(
                            label: AutoSizeText(
                              chipText ?? 'unknown',
                              style: dmsregular.copyWith(
                                fontSize: FontSize.label(context),
                              ),
                            ),
                            backgroundColor: Jobstopcolor.greyyy2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
            ),
          );
        });
  }
}
