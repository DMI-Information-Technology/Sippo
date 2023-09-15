import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/sippo_custom_widget/rounded_border_radius_card_widget.dart';
import 'package:jobspot/utils/string_formtter.dart';

import '../JobGlobalclass/jobstopcolor.dart';
import '../JobGlobalclass/jobstopfontstyle.dart';
import '../JobGlobalclass/jobstopimges.dart';
import '../sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';

class JobCard extends StatelessWidget {
  final VoidCallback? onActionTap; // Callback for the favorite button press
  final VoidCallback? onApplyClicked; // Callback for the favorite button press
  final bool canApply;
  final CompanyJobModel? jobDetailsPost;

  const JobCard({
    super.key,
    required this.onCardClicked,
    this.onActionTap,
    this.onApplyClicked,
    this.canApply = true,
    this.width,
    this.height,
    this.jobDetailsPost,
    this.isEditable = false,
  });

  final bool isEditable;
  final double? width;
  final double? height;
  final VoidCallback onCardClicked;

  @override
  Widget build(BuildContext context) {
    return RoundedBorderRadiusCardWidget(
      paddingType: PaddingType.all,
      child: SizedBox(
        width: width,
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildJobCardHeader(context),
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
            AutoSizeText(
              '${jobDetailsPost?.salaryFrom?.toString().salaryValue} -'
              ' ${jobDetailsPost?.salaryTo?.toString().salaryValue} LYD/Mo',
              style: dmsmedium.copyWith(
                fontSize: FontSize.title6(context),
              ),
            ),
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
            _buildJobCardChipsAndApply(context),
          ],
        ),
      ),
    );
  }

  InkWell _buildJobCardHeader(BuildContext context) {
    return InkWell(
      onTap: onCardClicked,
      child: Row(
        children: [
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: 'https://picsum.photos/200',
              width: context.fromHeight(CustomStyle.imageSize3),
              height: context.fromHeight(CustomStyle.imageSize3),
              placeholder: (context, url) => Image.asset(
                JobstopPngImg.google,
              ),
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
                AutoSizeText(
                  jobDetailsPost?.company?.city ?? 'unknown',
                  style: dmsregular.copyWith(
                    fontSize: FontSize.paragraph3(context),
                    color: Colors.grey,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onActionTap,
            icon: Icon(
              isEditable ? Icons.more_vert_rounded : Icons.favorite_border,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobCardChipsAndApply(BuildContext context) {
    // double height = size.height;

    return Row(
      children: [
        _buildChipChildrenList(context),
        if (canApply)
          InkWell(
            onTap: onApplyClicked,
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
