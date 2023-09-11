import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/sippo_custom_widget/rounded_border_radius_card_widget.dart';
import 'package:readmore/readmore.dart';

import '../JobGlobalclass/jobstopcolor.dart';
import '../JobGlobalclass/jobstopimges.dart';
import '../JobGlobalclass/sippo_customstyle.dart';

class PostWidget extends StatelessWidget {
  final String authorName;
  final String timeAgo;
  final String postTitle;
  final String postContent;
  final String? imageUrl;
  final bool? isCompany;
  final VoidCallback? onActionButtonPresses;

  const PostWidget({
    Key? key,
    required this.authorName,
    required this.timeAgo,
    required this.postTitle,
    required this.postContent,
    this.imageUrl,
    this.isCompany = false,
    this.onActionButtonPresses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return RoundedBorderRadiusCardWidget(
      paddingValue: context.fromWidth(CustomStyle.paddingValue),
      paddingType: PaddingType.all,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width / 26,
                vertical: height / 66,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(JobstopPngImg.photo),
                      ),
                      SizedBox(
                        width: width / 46,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            authorName,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: height / 150,
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
                      ..._buildShowCompanyMenuOptionsButton()
                    ],
                  ),
                  SizedBox(
                    height: height / 46,
                  ),
                  Text(
                    postTitle,
                    style: dmsmedium.copyWith(
                      fontSize: FontSize.label(context),
                      color: Jobstopcolor.primarycolor,
                      // Change to your desired color
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: height / 96),
                  ReadMoreText(
                    postContent,
                    style: dmsregular.copyWith(
                      fontSize: FontSize.label(context),
                      color: Colors.grey, // Change to your desired color
                    ),
                    colorClickableText: Jobstopcolor.primarycolor,
                    trimLines: 3,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'read_more'.tr,
                    trimExpandedText: 'hide'.tr,
                    lessStyle: dmsmedium.copyWith(
                      color: Jobstopcolor.primarycolor,
                    ),
                    moreStyle: dmsmedium.copyWith(
                      color: Jobstopcolor.primarycolor,
                    ),
                  ),
                  SizedBox(height: height / 96),
                  _buildImagePost(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePost(BuildContext context) {
    return imageUrl != null
        ? CachedNetworkImage(
            progressIndicatorBuilder: (___, __, _) => const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
            imageUrl: imageUrl!,
            errorWidget: (___, __, _) => const SizedBox.shrink(),
            fit: BoxFit.cover,
          )
        : const SizedBox.shrink();
  }

  List<Widget> _buildShowCompanyMenuOptionsButton() {
    return [
      if (isCompany == true) ...[
        const Spacer(),
        InkWell(
          onTap: onActionButtonPresses,
          child: Icon(Icons.more_vert_rounded),
        ),
      ]
    ];
  }
}
