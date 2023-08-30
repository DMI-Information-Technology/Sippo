import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/sippo_custom_widget/rounded_border_radius_card_widget.dart';

import '../JobGlobalclass/jobstopcolor.dart';
import '../JobGlobalclass/jobstopfontstyle.dart';
import '../JobGlobalclass/jobstopimges.dart';
import '../sippo_data/model/profile_model/profile_widget_model/jobstop_jobdetailspost.dart';

class JobCard extends StatelessWidget {
  final JobDetailsModel jobDetails;
  final VoidCallback?
      onFavoriteClicked; // Callback for the favorite button press
  final VoidCallback? onApplyClicked; // Callback for the favorite button press

  const JobCard({
    required this.jobDetails,
    required this.onCardClicked,
    this.onFavoriteClicked,
    this.onApplyClicked,
  });

  final VoidCallback onCardClicked;

  @override
  Widget build(BuildContext context) {
    return RoundedBorderRadiusCardWidget(
      paddingType: PaddingType.all,
      child: SizedBox(
        width: context.fromWidth(CustomStyle.jobCardWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildJobCardHeader(context),
            SizedBox(
              height: context.fromHeight(CustomStyle.verticalSpaceBetween),
            ),
            AutoSizeText(
              '${jobDetails.salary}',
              style: dmsbold.copyWith(
                fontSize: FontSize.title6(context),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: context.fromHeight(CustomStyle.verticalSpaceBetween),
            ),
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
              imageUrl: jobDetails.companyLogo,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: context.fromWidth(CustomStyle.overBy3),
                child: AutoSizeText(
                  jobDetails.jobName,
                  style: dmsbold.copyWith(
                      fontSize: FontSize.title5(context),
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
              SizedBox(
                width: context.fromWidth(CustomStyle.overBy3),
                child: AutoSizeText(
                  jobDetails.companyName,
                  style: dmsregular.copyWith(
                    fontSize: FontSize.paragraph3(context),
                    color: Colors.grey,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: context.fromWidth(CustomStyle.overBy3),
                child: AutoSizeText(
                  jobDetails.location,
                  style: dmsregular.copyWith(
                    fontSize: FontSize.paragraph3(context),
                    color: Colors.grey,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Spacer(),
          IconButton(
            onPressed: onFavoriteClicked,
            icon: Icon(Icons.favorite_border),
          ),
        ],
      ),
    );
  }

  Row _buildJobCardChipsAndApply(BuildContext context) {
    // double height = size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: context.fromWidth(CustomStyle.overBy2),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: jobDetails.chips.map((chipText) {
                return Padding(
                  padding: EdgeInsets.only(
                    right: context.fromWidth(CustomStyle.xxxl),
                  ),
                  child: Chip(
                    label: AutoSizeText(
                      chipText,
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
        ),
        InkWell(
          onTap: onApplyClicked,
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
      ],
    );
  }
}
