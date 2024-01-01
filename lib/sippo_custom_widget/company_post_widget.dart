import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/JobGlobalclass/media_query_sizes.dart';
import 'package:sippo/JobGlobalclass/text_font_size.dart';
import 'package:sippo/sippo_custom_widget/notification_widget.dart';
import 'package:sippo/sippo_custom_widget/rounded_border_radius_card_widget.dart';
import 'package:sippo/sippo_data/model/application_model/application_job_company_model.dart';
import 'package:sippo/sippo_data/model/auth_model/company_response_details.dart';
import 'package:sippo/utils/helper.dart';
import 'package:lottie/lottie.dart';
import 'package:readmore/readmore.dart';

import '../JobGlobalclass/jobstopcolor.dart';
import '../JobGlobalclass/jobstopimges.dart';
import '../JobGlobalclass/sippo_customstyle.dart';
import 'network_bordered_circular_image_widget.dart';

class PostWidget extends StatelessWidget {
  final String authorName;
  final String timeAgo;
  final String postTitle;
  final String postContent;
  final String? imageUrl;
  final bool? isCompany;
  final VoidCallback? onActionButtonPresses;
  final String? imageProfileUrl;

  const PostWidget({
    Key? key,
    required this.authorName,
    required this.timeAgo,
    required this.postTitle,
    required this.postContent,
    this.imageUrl,
    this.isCompany = false,
    this.onActionButtonPresses,
    this.imageProfileUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return RoundedBorderRadiusCardWidget.top(
      paddingValue: context.fromWidth(CustomStyle.paddingValue),
      paddingType: PaddingType.vertical,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: height / CustomStyle.huge2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 32),
              child: _buildPostHeader(context),
            ),
            SizedBox(height: height / 46),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 32),
              child: _buildPostContent(context),
            ),
            SizedBox(height: height / 96),
            _buildImagePost(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPostContent(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          postTitle,
          style: dmsmedium.copyWith(
            fontSize: FontSize.label(context),
            color: SippoColor.primarycolor,
            // Change to your desired color
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: height / CustomStyle.huge2),
        ReadMoreText(
          postContent,
          style: dmsregular.copyWith(
            fontSize: FontSize.label(context),
            color: Colors.grey, // Change to your desired color
          ),
          colorClickableText: SippoColor.primarycolor,
          trimLines: 3,
          trimMode: TrimMode.Line,
          trimCollapsedText: 'read_more'.tr,
          trimExpandedText: 'hide'.tr,
          lessStyle: dmsmedium.copyWith(
            color: SippoColor.primarycolor,
          ),
          moreStyle: dmsmedium.copyWith(
            color: SippoColor.primarycolor,
          ),
        ),
      ],
    );
  }

  Widget _buildPostHeader(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Row(
      children: [
        NetworkBorderedCircularImage(
          imageUrl: imageProfileUrl ?? "",
          outerBorderWidth: context.fromWidth(CustomStyle.huge),
          size: context.fromWidth(8),
          outerBorderColor: Colors.grey[300],
        ),
        SizedBox(
          width: width / 46,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                authorName,
                style: dmsmedium.copyWith(
                  fontSize: FontSize.label(context),
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              SizedBox(
                height: height / CustomStyle.huge2,
              ),
              Row(
                children: [
                  Image.asset(
                    JobstopPngImg.watch,
                    height: height / 56,
                  ),
                  SizedBox(
                    width: width / 46,
                  ),
                  Text(
                    timeAgo,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        _buildShowCompanyMenuOptionsButton()
      ],
    );
  }

  Widget _buildImagePost(BuildContext context) {
    return imageUrl != null
        ? CachedNetworkImage(
            width: context.width,
            progressIndicatorBuilder: (___, __, _) => Center(
              child: Lottie.asset(
                JobstopPngImg.loadingProgress,
                height: context.fromHeight(6),
              ),
            ),
            imageUrl: imageUrl!,
            errorWidget: (___, __, _) => const SizedBox.shrink(),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          )
        : const SizedBox.shrink();
  }

  Widget _buildShowCompanyMenuOptionsButton() {
    return isCompany == true
        ? InkWell(
            onTap: onActionButtonPresses,
            child: Icon(Icons.more_vert_rounded),
          )
        : const SizedBox.shrink();
  }
}

class PostApplicationWidget extends StatelessWidget {
  final String? timeAgo;
  final ApplicationCompanyModel? application;
  final CompanyDetailsModel? company;
  final VoidCallback? onActionButtonPresses;
  final VoidCallback? onProfileImageTap;
  final void Function(String? cvUrl, [String? size])? onShowCvTap;
  final bool isSubscribed;

  const PostApplicationWidget({
    Key? key,
    this.timeAgo,
    this.company,
    this.onActionButtonPresses,
    this.application,
    this.onShowCvTap,
    this.onProfileImageTap,
    this.isSubscribed = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return RoundedBorderRadiusCardWidget.top(
      paddingValue: context.fromWidth(CustomStyle.paddingValue),
      paddingType: PaddingType.vertical,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: height / CustomStyle.huge2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 32),
              child: _buildPostHeader(context),
            ),
            SizedBox(height: height / 46),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 32),
              child: _buildPostContent(context),
            ),
            _buildApplicationDetailsPost(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPostContent(BuildContext context) {
    return application?.description != null &&
            application!.description!.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReadMoreText(
                application?.description ?? "",
                style: dmsregular.copyWith(
                  fontSize: FontSize.label(context),
                  color: Colors.grey, // Change to your desired color
                ),
                colorClickableText: SippoColor.primarycolor,
                trimLines: 3,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'read_more'.tr,
                trimExpandedText: 'hide'.tr,
                lessStyle: dmsmedium.copyWith(
                  color: SippoColor.primarycolor,
                ),
                moreStyle: dmsmedium.copyWith(
                  color: SippoColor.primarycolor,
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }

  Widget _buildPostHeader(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Row(
      children: [
        InkWell(
          onTap: onProfileImageTap,
          child: NetworkBorderedCircularImage(
            imageUrl: application?.customer?.profileImage?.url ?? '',
            errorWidget: (___, __, _) => const CircleAvatar(),
            size: context.fromHeight(24),
            outerBorderColor: SippoColor.backgroudHome,
          ),
        ),
        SizedBox(
          width: width / 46,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                application?.customer?.name ?? "",
                style: dmsmedium.copyWith(
                  fontSize: FontSize.label(context),
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              SizedBox(
                height: height / CustomStyle.huge2,
              ),
              Row(
                children: [
                  Image.asset(
                    JobstopPngImg.watch,
                    height: height / 56,
                  ),
                  SizedBox(
                    width: width / 46,
                  ),
                  Text(
                    calculateElapsedTimeFromStringDate(timeAgo ?? "") ?? "",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(height: height / 96),
        _buildShowCompanyMenuOptionsButton()
      ],
    );
  }

  Widget _buildApplicationDetailsPost(context) {
    if (application?.job != null) {
      return UserJobApplicationWidget(
        isSubscribed: isSubscribed,
        onShowCvTap: onShowCvTap,
        application: application,
        company: company,
      );
    }
    return UserCompanyApplicationWidget(
      isSubscribed: isSubscribed,
      onShowCvTap: onShowCvTap,
      cv: application?.cv,
      company: company,
      applicationStatus: application?.status,
    );
  }

  Widget _buildShowCompanyMenuOptionsButton() {
    return InkWell(
      onTap: onActionButtonPresses,
      child: Icon(Icons.more_vert_rounded),
    );
  }
}
