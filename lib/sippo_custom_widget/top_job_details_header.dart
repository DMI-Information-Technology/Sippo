import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/sippo_custom_widget/save_job_card_widget.dart';

class TopJobDetailsHeader extends StatelessWidget {
  const TopJobDetailsHeader({
    super.key,
    required this.coverHeight,
    required this.profileImageSize,
    this.imageUrl,
    this.backgroundImageColor,
    // this.onLeadingTap,
    this.actions = const [],
    this.isConnectionLost = false,
    this.shrinkOffset = 0.0,
    this.imageOffsetDivider = 1.0,
  });

  final bool isConnectionLost;
  final double imageOffsetDivider;

  // final VoidCallback? onLeadingTap;
  final String? imageUrl;
  final Color? backgroundImageColor;
  final double coverHeight;
  final double profileImageSize;
  final List<Widget> actions;
  final double shrinkOffset;

  double calculateCoverHeight(BuildContext context) {
    if (isConnectionLost) {
      return coverHeight + context.fromHeight(CustomStyle.connectionLostHeight);
    }
    return coverHeight;
  }

  @override
  Widget build(BuildContext context) {
    final topProfileImageOffset =
        (calculateCoverHeight(context) - (profileImageSize / 2)) - 5;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: (profileImageSize / 2) - 5),
          child: _buildCoverImage(context),
        ),
        Positioned(
          top: (topProfileImageOffset / imageOffsetDivider) - shrinkOffset,
          child: _buildProfileImage(context),
        ),
      ],
    );
  }

  Widget _buildCoverImage(BuildContext context) {
    return Container(
      width: context.width,
      height: calculateCoverHeight(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.vertical(
          bottom: Radius.circular(context.height / 45),
        ),
        color: Jobstopcolor.red,
        image: DecorationImage(
          image: AssetImage(
            JobstopPngImg.backgroundProf,
          ),
          fit: BoxFit.cover,
        ),
      ),
      // child: SafeArea(
      //   child: Container(
      //     width: context.width,
      //     alignment: Alignment.topCenter,
      //     margin: EdgeInsets.only(
      //       top: this.isConnectionLost
      //           ? context.fromHeight(CustomStyle.connectionLostHeight)
      //           : 0.0,
      //     ),
      //     height: kToolbarHeight,
      //     child: Row(
      //       children: [
      //         IconButton(
      //           icon: Icon(Icons.arrow_back, color: Colors.white),
      //           onPressed: onLeadingTap,
      //         ),
      //         Spacer(),
      //         if (actions.isNotEmpty)
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.end,
      //             children: actions,
      //           ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    return NetworkBorderedCircularImage(
      outerBorderColor: Jobstopcolor.backgroudHome,
      innerBorderColor: Jobstopcolor.primarycolor,
      backgroundColor: Jobstopcolor.white,
      size: profileImageSize,
      imageUrl: imageUrl ?? "",
      errorWidget: (context, url, error) => Image.asset(
        JobstopPngImg.companysignup,
      ),
    );
  }
}