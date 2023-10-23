import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/sippo_data/model/auth_model/entity_model.dart';

import '../JobGlobalclass/jobstopcolor.dart';
import '../JobGlobalclass/jobstopfontstyle.dart';
import '../JobGlobalclass/sippo_customstyle.dart';
import '../JobGlobalclass/text_font_size.dart';
import 'network_bordered_circular_image_widget.dart';

class UserProfileHeaderWidget extends StatelessWidget {
  final String profileImage;
  final EntityModel profileInfo;
  final VoidCallback? onSettingsPressed;
  final VoidCallback? onEditProfilePressed;
  final bool showConnectionLostBar;
  final bool isCompanyView;
  final bool hasDrawer;

  UserProfileHeaderWidget(
      {super.key,
      required this.profileInfo,
      this.onSettingsPressed,
      this.onEditProfilePressed,
      required this.profileImage,
      this.showConnectionLostBar = false,
      this.isCompanyView = false,
      this.hasDrawer = false});

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
                  _buildPhoneNumberLabels(
                    context,
                    profileInfo.phone,
                    profileInfo.secondaryPhone,
                  ),
                  SizedBox(height: context.fromHeight(CustomStyle.xl)),
                  if (!isCompanyView && onEditProfilePressed != null)
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
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        NetworkBorderedCircularImage(
          imageUrl: profileImage,
          size: context.fromHeight(CustomStyle.imageSize2),
          errorWidget: (context, url, error) => const CircleAvatar(),
          outerBorderColor: Colors.transparent,
        ),
        const Spacer(),
        if (!isCompanyView && onSettingsPressed != null)
          InkWell(
            onTap: onSettingsPressed,
            child: Image.asset(
              JobstopPngImg.setting,
              // Change this to your setting image path
              height: context.fromHeight(CustomStyle.l),
              color: Colors.white, // Change this to your desired color
            ),
          ),
        if (hasDrawer) ...[
          SizedBox(
            width: context.fromWidth(CustomStyle.spaceBetween),
          ),
          InkWell(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildNameText(BuildContext context) {
    return Text(
      profileInfo.name ?? "",
      style: dmsmedium.copyWith(
        fontSize: FontSize.title5(context),
        color: Jobstopcolor.white,
      ),
    );
  }

  Widget _buildLocationText(BuildContext context) {
    return Text(
      profileInfo.locationCity ?? "",
      style: dmsregular.copyWith(
        fontSize: FontSize.label(context),
        color: Jobstopcolor.white,
      ),
    );
  }

  Widget _buildPhoneNumberLabels(
      BuildContext context, String? primaryPhone, String? secondaryPhone) {
    return primaryPhone != null || secondaryPhone != null
        ? Row(
            children: [
              if (primaryPhone != null && primaryPhone.trim().isNotEmpty)
                Text(
                  primaryPhone,
                  style: dmsregular.copyWith(
                    fontSize: FontSize.label(context),
                    color: Jobstopcolor.white,
                  ),
                ),
              if (secondaryPhone != null &&
                  secondaryPhone.trim().isNotEmpty) ...[
                SizedBox(width: context.fromWidth(CustomStyle.spaceBetween)),
                Text(
                  secondaryPhone,
                  style: dmsregular.copyWith(
                    fontSize: FontSize.label(context),
                    color: Jobstopcolor.white,
                  ),
                ),
              ]
            ],
          )
        : const SizedBox.shrink();
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
