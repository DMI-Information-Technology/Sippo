import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/JopController/company_profile_controller/profile_user_view_controller.dart';
import 'package:jobspot/sippo_custom_widget/add_info_profile_card.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:readmore/readmore.dart';

import '../../../JobGlobalclass/sippo_customstyle.dart';
import '../../../sippo_custom_widget/expandable_item_list_widget.dart';
import '../../../sippo_custom_widget/resume_card_widget.dart';
import '../../../sippo_custom_widget/user_profile_header.dart';

class SippoCompanyUserProfileView extends StatefulWidget {
  const SippoCompanyUserProfileView({Key? key}) : super(key: key);

  @override
  State<SippoCompanyUserProfileView> createState() =>
      _SippoCompanyUserProfileViewState();
}

class _SippoCompanyUserProfileViewState
    extends State<SippoCompanyUserProfileView> {
  final _controller = ProfileUserViewController.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.black87,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _controller.requestProfileInfo();
        },
        child: BodyWidget(
          isTopScrollable: true,
          isScrollable: true,
          topScreen: _buildUserProfileHeader(context),
          paddingContent: EdgeInsets.symmetric(
            horizontal: context.fromWidth(CustomStyle.paddingValue),
          ),
          child: Column(
            children: [
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              _buildAboutMeInfo(context),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              _buildWorkExperienceInfo(context),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              _buildEducationInfo(context),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              _buildSkillsInfo(context),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              _buildLanguagesInfo(context),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              _buildAppreciationInfo(context),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              _buildResumeInfo(context),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfileHeader(BuildContext context) {
    return Obx(() => UserProfileHeaderWidget(
          profileInfo: _controller.profileState.profileInfo,
          profileImage: JobstopPngImg.photo,
        ));
  }

  Widget _buildResumeInfo(BuildContext context) {
    return AddInfoProfileCard(
      isCompanyView: true,
      title: 'resume'.tr,
      leading: Image.asset(
        JobstopPngImg.resume,
        height: context.fromHeight(CustomStyle.l),
        color: Jobstopcolor.primarycolor,
        colorBlendMode: BlendMode.srcIn,
      ),
      noInfoProfile: false,
      profileInfo: [
        CvCardWidget.fromRemote(
          remoteCv: _controller.profileState.profileInfo.cv,
          onCvTapped: () {},
        )
      ],
    );
  }

  Widget _buildAppreciationInfo(BuildContext context) {
    return Obx(
      () => AddInfoProfileCard(
        isCompanyView: true,
        title: 'appreciation'.tr,
        noInfoProfile: _controller.profileState.appreciations.isEmpty,
        leading: Image.asset(
          JobstopPngImg.appreciation,
          height: context.fromHeight(CustomStyle.l),
          color: Jobstopcolor.primarycolor,
          colorBlendMode: BlendMode.srcIn,
        ),
        profileInfo: [
          ExpandableItemList(
            isExpandable: _controller.profileState.appreciations.length > 1,
            expandItems: _controller.profileState.showAllAppreciations,
            spacing: context.fromHeight(CustomStyle.xxxl),
            itemCount: _controller.profileState.appreciations.length,
            itemBuilder: (BuildContext context, int index) {
              final item = _controller.profileState.appreciations[index];
              return _buildTextDescriptionInfo(
                context,
                item.awardName,
                item.categoryAchieve,
                item.year,
              );
            },
            onExpandClicked: () {
              _controller.profileState.showAllAppreciations =
                  !_controller.profileState.showAllAppreciations;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLanguagesInfo(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    return Obx(
      () => AddInfoProfileCard(
        isCompanyView: true,
        title: 'language'.tr,
        noInfoProfile: _controller.profileState.languages.isEmpty,
        leading: Image.asset(
          JobstopPngImg.language,
          height: context.fromHeight(CustomStyle.l),
          color: Jobstopcolor.primarycolor,
          colorBlendMode: BlendMode.srcIn,
        ),
        profileInfo: [
          ExpandableItemList.wrapBuilder(
            isExpandable: _controller.profileState.languages.length > 1,
            expandItems: _controller.profileState.showAllLangs,
            spacing: height / 220,
            itemCount: _controller.profileState.showAllLangs
                ? _controller.profileState.languages.length
                : 1,
            itemBuilder: (BuildContext context, int index) {
              final item = _controller.profileState.languages[index];
              return _buildChips(
                context,
                item.name ?? "",
              );
            },
            onExpandClicked: () {
              _controller.profileState.showAllLangs =
                  !_controller.profileState.showAllLangs;
            },
          ),
        ],
      ),
    );
  }

  Obx _buildSkillsInfo(BuildContext context) {
    return Obx(
      () => AddInfoProfileCard(
        isCompanyView: true,
        title: 'skill'.tr,
        noInfoProfile: _controller.profileState.skillsList.isEmpty,
        leading: Image.asset(
          JobstopPngImg.skil,
          height: context.fromHeight(CustomStyle.l),
          color: Jobstopcolor.primarycolor,
          colorBlendMode: BlendMode.srcIn,
        ),
        profileInfo: [
          ExpandableItemList.wrapBuilder(
            isExpandable: _controller.profileState.skillsList.length > 1,
            expandItems: _controller.profileState.showAllSkills,
            spacing: context.height / 220,
            itemCount: _controller.profileState.skillsList.length,
            itemBuilder: (BuildContext context, int index) {
              final item = _controller.profileState.skillsList[index];
              return _buildChips(context, item);
            },
            onExpandClicked: () {
              _controller.profileState.showAllSkills =
                  !_controller.profileState.showAllSkills;
            },
          ),
        ],
      ),
    );
  }

  Obx _buildEducationInfo(BuildContext context) {
    return Obx(() => AddInfoProfileCard(
          isCompanyView: true,
          title: 'education'.tr,
          noInfoProfile: _controller.profileState.educationList.isEmpty,
          leading: Image.asset(
            JobstopPngImg.education,
            height: context.fromHeight(CustomStyle.spaceBetween),
            color: Jobstopcolor.primarycolor,
            colorBlendMode: BlendMode.srcIn,
          ),
          profileInfo: [
            ExpandableItemList(
              isExpandable: _controller.profileState.educationList.length > 1,
              expandItems: _controller.profileState.showAllEdui,
              spacing: context.fromHeight(CustomStyle.l),
              itemCount: _controller.profileState.educationList.length,
              itemBuilder: (BuildContext context, int index) {
                final item = _controller.profileState.educationList[index];
                return _buildTextDescriptionInfo(
                  context,
                  item.level,
                  item.institution,
                  item.periodic,
                );
              },
              onExpandClicked: () {
                _controller.profileState.showAllEdui =
                    !_controller.profileState.showAllEdui;
              },
            ),
          ],
        ));
  }

  Widget _buildWorkExperienceInfo(BuildContext context) {
    return Obx(
      () => AddInfoProfileCard(
        isCompanyView: true,
        title: 'work_experience'.tr,
        noInfoProfile: _controller.profileState.workExList.isEmpty,
        leading: Image.asset(
          JobstopPngImg.bag,
          height: context.fromHeight(CustomStyle.l),
          color: Jobstopcolor.primarycolor,
          colorBlendMode: BlendMode.srcIn,
        ),
        alignmentFromStart: true,
        profileInfo: [
          ExpandableItemList(
            isExpandable: _controller.profileState.workExList.length > 1,
            expandItems: _controller.profileState.showAllWei,
            spacing: context.fromHeight(CustomStyle.xxxl),
            itemCount: _controller.profileState.workExList.length,
            itemBuilder: (BuildContext context, int index) {
              final item = _controller.profileState.workExList[index];
              return _buildTextDescriptionInfo(
                context,
                item.jobTitle,
                item.company,
                item.periodic,
              );
            },
            onExpandClicked: () {
              _controller.profileState.showAllWei =
                  !_controller.profileState.showAllWei;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAboutMeInfo(BuildContext context) {
    return Obx(
      () => AddInfoProfileCard(
        isCompanyView: true,
        title: 'about_me'.tr,
        noInfoProfile: _controller.profileState.aboutMeText.isEmpty,
        leading: Image.asset(
          JobstopPngImg.aboutme,
          height: context.fromHeight(CustomStyle.l),
          color: Jobstopcolor.primarycolor,
          colorBlendMode: BlendMode.srcIn,
        ),
        profileInfo: [
          _controller.profileState.aboutMeText.isNotEmpty
              ? ReadMoreText(
                  _controller.profileState.aboutMeText,
                  style: dmsregular.copyWith(
                    fontSize: context.fromHeight(CustomStyle.xxxl),
                    color: Jobstopcolor.textColor,
                  ),
                  colorClickableText: Jobstopcolor.primarycolor,
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'show_more'.tr,
                  trimExpandedText: 'show_less'.tr,
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildChips(
    BuildContext context,
    String value,
  ) {
    return Chip(
      backgroundColor: Jobstopcolor.grey2,
      label: Text(
        value,
        style: dmsregular.copyWith(
          color: Jobstopcolor.textColor,
        ),
      ),
    );
  }

  Widget _buildTextDescriptionInfo(
    BuildContext context,
    String? title,
    String? from,
    String? periodic,
  ) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        width: context.width,
        child: Text(
          title ?? "",
          style: dmsbold.copyWith(
            fontSize: FontSize.title6(context),
            color: Jobstopcolor.primarycolor,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      SizedBox(
        height: context.fromHeight(CustomStyle.huge2),
      ),
      Text(
        from ?? "",
        style: dmsregular.copyWith(
            fontSize: FontSize.label(context), color: Jobstopcolor.darkgrey),
      ),
      SizedBox(
        height: context.fromHeight(CustomStyle.huge2),
      ),
      Text(
        periodic ?? "",
        style: dmsregular.copyWith(
            fontSize: FontSize.label(context), color: Jobstopcolor.darkgrey),
      ),
    ]);
  }
}