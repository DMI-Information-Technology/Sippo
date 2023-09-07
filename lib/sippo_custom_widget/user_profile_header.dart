import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/sippo_data/model/auth_model/entity_model.dart';

import '../JobGlobalclass/jobstopcolor.dart';
import '../JobGlobalclass/jobstopfontstyle.dart';
import '../JobGlobalclass/sippo_customstyle.dart';
import '../JobGlobalclass/text_font_size.dart';
import 'circular_image.dart';

class UserProfileHeaderWidget extends StatelessWidget {
  final String profileImage;
  final EntityModel profileInfo;
  final VoidCallback onSettingsPressed;
  final VoidCallback onEditProfilePressed;
  final bool showConnectionLostBar;

  UserProfileHeaderWidget({
    super.key,
    required this.profileInfo,
    required this.onSettingsPressed,
    required this.onEditProfilePressed,
    required this.profileImage,
    this.showConnectionLostBar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        color: Jobstopcolor.primarycolor, // Change this to your desired color
        image: DecorationImage(
          image: AssetImage(JobstopPngImg.backgroundProf),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            if (showConnectionLostBar)
              SizedBox(
                height: context.fromHeight(CustomStyle.connectionLostHeight),
              ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.fromWidth(CustomStyle.xs),
                vertical: context.fromHeight(CustomStyle.huge),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileRow(context),
                  SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
                  _buildNameText(context),
                  SizedBox(height: context.fromHeight(CustomStyle.huge2)),
                  if (profileInfo.locationCity != null &&
                      profileInfo.locationCity!.trim().isNotEmpty) ...[
                    _buildLocationText(context),
                    SizedBox(height: context.fromHeight(CustomStyle.huge2)),
                  ],
                  _buildPhoneNumberLabels(context),
                  SizedBox(height: context.fromHeight(CustomStyle.xl)),
                  _buildEditProfileButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircularImage(
          profileImage,
          size: context.fromHeight(CustomStyle.imageSize2),
        ),
        InkWell(
          onTap: onSettingsPressed,
          child: Image.asset(
            JobstopPngImg.setting,
            // Change this to your setting image path
            height: context.fromHeight(CustomStyle.l),
            color: Colors.white, // Change this to your desired color
          ),
        ),
      ],
    );
  }

  Widget _buildNameText(BuildContext context) {
    return Text(
      profileInfo.name ?? "unknown",
      style: dmsmedium.copyWith(
        fontSize: FontSize.title5(context),
        color: Jobstopcolor.white,
      ),
    );
  }

  Widget _buildLocationText(BuildContext context) {
    return Text(
      profileInfo.locationCity ?? "unknown",
      style: dmsregular.copyWith(
        fontSize: FontSize.label(context),
        color: Jobstopcolor.white,
      ),
    );
  }

  Widget _buildPhoneNumberLabels(BuildContext context) {
    return Row(
      children: [
        Text(
          profileInfo.phone ?? "unknown",
          style: dmsregular.copyWith(
            fontSize: FontSize.label(context),
            color: Jobstopcolor.white,
          ),
        ),
        if (profileInfo.secondaryPhone != null) ...[
          SizedBox(width: context.fromWidth(CustomStyle.spaceBetween)),
          Text(
            profileInfo.secondaryPhone!,
            style: dmsregular.copyWith(
              fontSize: FontSize.label(context),
              color: Jobstopcolor.white,
            ),
          ),
        ]
      ],
    );
  }

  Widget _buildEditProfileButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: onEditProfilePressed,
          child: Row(
            children: [
              Text(
                "edit_profile".tr,
                style: dmsregular.copyWith(
                  fontSize: FontSize.label(context),
                  color: Jobstopcolor.white,
                ),
              ),
              Image.asset(
                JobstopPngImg.edit,
                // Change this to your edit image path
                height: context.fromHeight(CustomStyle.l),
                color: Jobstopcolor.white,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
