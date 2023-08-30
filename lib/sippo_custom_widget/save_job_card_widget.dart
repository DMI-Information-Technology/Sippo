import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/sippo_custom_widget/rounded_border_radius_card_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';

import '../JobGlobalclass/jobstopcolor.dart';
import '../JobGlobalclass/jobstopfontstyle.dart';
import '../JobGlobalclass/jobstopimges.dart';
import '../JobGlobalclass/text_font_size.dart';

class SavedJobCard extends StatelessWidget {
  final String imagePath;
  final String jobTitle;
  final String companyLocation;
  final String jobType;
  final String jobCategory;
  final String jobPosition;
  final String timeAgo;
  final String salary;
  final VoidCallback onActionTap;
  final bool isLastWidget;
  final bool isSaved;

  const SavedJobCard({
    required this.imagePath,
    required this.jobTitle,
    required this.companyLocation,
    required this.jobType,
    required this.jobCategory,
    required this.jobPosition,
    required this.timeAgo,
    required this.salary,
    required this.onActionTap,
    this.isLastWidget = false,
    this.isSaved = false,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return RoundedBorderRadiusCardWidget(
      paddingType: PaddingType.vertical,
      margin: EdgeInsets.only(
        right: width / 24,
        left: width / 24,
        top: width / 32,
        bottom: isLastWidget ? width / 16 : 0.0,
      ),
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
                _buildCustomChip(context, jobType, true),
                _buildCustomChip(context, jobType),
                _buildCustomChip(context, jobCategory),
                _buildCustomChip(context, jobCategory),
                _buildCustomChip(context, jobPosition),
                _buildCustomChip(context, jobPosition),
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
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.fromWidth(CustomStyle.paddingValue),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.grey[200],
            child: Image.asset(
              imagePath,
              height: height / 28,
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: onActionTap, // Replace with your function
            child: Image.asset(
              this.isSaved ? JobstopPngImg.dots : JobstopPngImg.order,
              height: (kIsWeb ? height : width) / 16,
              color: Colors.black,
            ),
          ),
        ],
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
            jobTitle,
            style: TextStyle(
              fontSize: FontSize.title6(context),
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          AutoSizeText(
            companyLocation,
            style: TextStyle(
              fontSize: FontSize.paragraph4(context),
              color: Colors.grey,
            ),
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
            style: const TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
          ),
          const Spacer(),
          Text(
            salary,
            style: const TextStyle(
              fontSize: 14,
              color: Jobstopcolor.primarycolor, // Use appropriate color
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '/Yr',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  CustomChip _buildCustomChip(
    BuildContext context,
    String text, [
    bool isFirst = false,
  ]) {
    return CustomChip(
      onTap: () {},
      backgroundColor: Colors.grey[200],
      child: AutoSizeText(
        text,
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
