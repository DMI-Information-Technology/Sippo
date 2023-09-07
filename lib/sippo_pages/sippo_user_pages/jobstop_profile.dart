import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/jobstopprefname.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/sippo_custom_widget/add_info_profile_card.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/resume_card_widget.dart';
import 'package:jobspot/sippo_pages/sippo_user_pages/job_aboutme.dart';
import 'package:readmore/readmore.dart';

import '../../JobGlobalclass/sippo_customstyle.dart';
import '../../JopController/ProfileController/profile_user_controller.dart';
import '../../sippo_custom_widget/expandable_item_list_widget.dart';
import '../../sippo_custom_widget/user_profile_header.dart';

class SippoUserProfile extends StatefulWidget {
  const SippoUserProfile({Key? key}) : super(key: key);

  @override
  State<SippoUserProfile> createState() => _SippoUserProfileState();
}

class _SippoUserProfileState extends State<SippoUserProfile> {
  ProfileUserController _controller = ProfileUserController.instance;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          extendBodyBehindAppBar: _controller.netController.isConnected,
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: _controller.netController.isConnected
                ? Colors.black54
                : Colors.black87,
          ),
          body: BodyWidget(
            isTopScrollable: true,
            isScrollable: true,
            isConnectionLost: !_controller.netController.isConnected,
            topScreen: _buildUserProfileHeader(),
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
        ));
  }

  Widget _buildUserProfileHeader() {
    return UserProfileHeaderWidget(
      showConnectionLostBar: !_controller.netController.isConnected,
      profileInfo: _controller.user,
      onSettingsPressed: () => Get.toNamed(SippoRoutes.sippoprofilesetting),
      onEditProfilePressed: () => Get.toNamed(SippoRoutes.edituserprofile),
      profileImage: JobstopPngImg.photo,
    );
  }

  Widget _buildResumeInfo(BuildContext context) {
    return AddInfoProfileCard(
      title: 'resume'.tr,
      leading: Image.asset(
        JobstopPngImg.resume,
        height: context.fromHeight(CustomStyle.l),
        color: Jobstopcolor.primarycolor,
        colorBlendMode: BlendMode.srcIn,
      ),
      onAddClicked: () async {
        Get.toNamed(SippoRoutes.uploadresume);
        print(_controller.profileState.resumeFiles);
      },
      noInfoProfile: false,
      profileInfo: [ResumeCardWidget()],
    );
  }

  Widget _buildAppreciationInfo(BuildContext context) {
    return Obx(
      () => AddInfoProfileCard(
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
            more: _controller.profileState.showAllAppreciations,
            titleExpandColor: Jobstopcolor.primarycolor,
            spacing: context.fromHeight(CustomStyle.xxxl),
            itemCount: _controller.profileState.appreciations.length,
            itemBuilder: (BuildContext context, int index) {
              final item = _controller.profileState.appreciations[index];
              return _buildTextDescriptionInfo(
                context,
                item.awardName,
                item.categoryAchieve,
                item.year,
                onEdit: () {
                  Get.toNamed(
                    SippoRoutes.appreciationaddedit,
                    arguments: {appreciationArg: item.toJson()},
                  );
                },
              );
            },
            onExpandClicked: () {
              _controller.profileState.showAllAppreciations =
                  !_controller.profileState.showAllAppreciations;
            },
          ),
        ],
        onAddClicked: () {
          Get.toNamed(
            SippoRoutes.appreciationaddedit,
            arguments: {appreciationArg: null},
          );
        },
      ),
    );
  }

  Widget _buildLanguagesInfo(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    return Obx(
      () => AddInfoProfileCard(
        title: 'language'.tr,
        noInfoProfile: _controller.profileState.languages.isEmpty,
        leading: Image.asset(
          JobstopPngImg.language,
          height: context.fromHeight(CustomStyle.l),
          color: Jobstopcolor.primarycolor,
          colorBlendMode: BlendMode.srcIn,
        ),
        iconAction: _controller.profileState.languages.isNotEmpty
            ? Icon(
                Icons.mode_edit_outline_outlined,
                size: context.fromHeight(CustomStyle.l),
                color: Jobstopcolor.primarycolor,
              )
            : null,
        profileInfo: [
          ExpandableItemList.wrapBuilder(
            isExpandable: _controller.profileState.languages.length > 1,
            more: _controller.profileState.showAllLangs,
            titleExpandColor: Jobstopcolor.primarycolor,
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
        onAddClicked: () {
          Get.toNamed(
            SippoRoutes.languageeditadd,
            arguments: {
              langListArg: _controller.profileState.languages
                  .map((e) => e.toJson())
                  .toList()
            },
          );
        },
      ),
    );
  }

  Obx _buildSkillsInfo(BuildContext context) {
    return Obx(
      () => AddInfoProfileCard(
        title: 'skill'.tr,
        noInfoProfile: _controller.profileState.skillsList.isEmpty,
        leading: Image.asset(
          JobstopPngImg.skil,
          height: context.fromHeight(CustomStyle.l),
          color: Jobstopcolor.primarycolor,
          colorBlendMode: BlendMode.srcIn,
        ),
        iconAction: _controller.profileState.skillsList.isNotEmpty
            ? Icon(
                Icons.mode_edit_outline_outlined,
                size: context.fromHeight(CustomStyle.l),
                color: Jobstopcolor.primarycolor,
              )
            : null,
        profileInfo: [
          ExpandableItemList.wrapBuilder(
            isExpandable: _controller.profileState.skillsList.length > 1,
            more: _controller.profileState.showAllSkills,
            titleExpandColor: Jobstopcolor.primarycolor,
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
        onAddClicked: () {
          Get.toNamed(
            SippoRoutes.skillsaddedit,
            arguments: {skillsListArg: _controller.profileState.skillsList},
          );
        },
      ),
    );
  }

  Obx _buildEducationInfo(BuildContext context) {
    return Obx(() => AddInfoProfileCard(
          title: 'education'.tr,
          noInfoProfile: _controller.profileState.educationList.isEmpty,
          leading: Image.asset(
            JobstopPngImg.education,
            height: context.fromHeight(CustomStyle.spaceBetween),
            color: Jobstopcolor.primarycolor,
            colorBlendMode: BlendMode.srcIn,
          ),
          onAddClicked: () {
            Get.toNamed(
              SippoRoutes.educationaddedit,
              arguments: {educationArg: null},
            );
          },
          profileInfo: [
            ExpandableItemList(
              isExpandable: _controller.profileState.educationList.length > 1,
              more: _controller.profileState.showAllEdui,
              titleExpandColor: Jobstopcolor.primarycolor,
              spacing: context.fromHeight(CustomStyle.l),
              itemCount: _controller.profileState.educationList.length,
              itemBuilder: (BuildContext context, int index) {
                final item = _controller.profileState.educationList[index];
                return _buildTextDescriptionInfo(
                  context,
                  item.level,
                  item.institution,
                  item.periodic,
                  onEdit: () {
                    Get.toNamed(SippoRoutes.educationaddedit);
                    _controller.editingId = item.id ?? -1;
                  },
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
        title: 'work_experience'.tr,
        noInfoProfile: _controller.profileState.workExList.isEmpty,
        leading: Image.asset(
          JobstopPngImg.bag,
          height: context.fromHeight(CustomStyle.l),
          color: Jobstopcolor.primarycolor,
          colorBlendMode: BlendMode.srcIn,
        ),
        onAddClicked: () {
          Get.toNamed(
            SippoRoutes.workexperience,
            arguments: {workExperienceArg: null},
          );
        },
        profileInfo: [
          ExpandableItemList(
            isExpandable: _controller.profileState.workExList.length > 1,
            more: _controller.profileState.showAllWei,
            titleExpandColor: Jobstopcolor.primarycolor,
            spacing: context.fromHeight(CustomStyle.xxxl),
            itemCount: _controller.profileState.workExList.length,
            itemBuilder: (BuildContext context, int index) {
              final item = _controller.profileState.workExList[index];
              return _buildTextDescriptionInfo(
                context,
                item.jobTitle,
                item.company,
                item.periodic,
                onEdit: () {
                  _controller.editingId = item.id?.toInt() ?? -1;
                  Get.toNamed(SippoRoutes.workexperience);
                },
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
        title: 'about_me'.tr,
        noInfoProfile: _controller.profileState.aboutMeText.isEmpty,
        leading: Image.asset(
          JobstopPngImg.aboutme,
          height: context.fromHeight(CustomStyle.l),
          color: Jobstopcolor.primarycolor,
          colorBlendMode: BlendMode.srcIn,
        ),
        iconAction: _controller.profileState.aboutMeText.isNotEmpty
            ? Icon(
                Icons.mode_edit_outline_outlined,
                size: context.fromHeight(CustomStyle.l),
                color: Jobstopcolor.primarycolor,
              )
            : null,
        onAddClicked: () {
          Get.to(JobAboutme());
        },
        profileInfo: [
          _controller.profileState.aboutMeText.isNotEmpty
              ? ReadMoreText(
                  _controller.profileState.aboutMeText,
                  trimLines: 2,
                  style: dmsregular.copyWith(
                    fontSize: context.fromHeight(CustomStyle.xxxl),
                    color: Jobstopcolor.textColor,
                  ),
                  colorClickableText: Jobstopcolor.primarycolor,
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
    String? periodic, {
    required VoidCallback onEdit,
  }) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          SizedBox(
            width: context.fromWidth(CustomStyle.halfFullSize),
            child: Text(
              title ?? "",
              style: dmsbold.copyWith(
                fontSize: FontSize.title6(context),
                color: Jobstopcolor.primarycolor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Spacer(),
          InkWell(
              onTap: onEdit,
              child: Image.asset(
                JobstopPngImg.edit,
                height: context.fromHeight(CustomStyle.l),
                color: Jobstopcolor.primarycolor,
                colorBlendMode: BlendMode.srcIn,
              )),
        ],
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

// Widget _buildHeaderInfoProfile(BuildContext context) {
//   // double topPaddingValue = MediaQuery.of(context).viewPadding.top;
//   return Container(
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.only(
//         bottomLeft: Radius.circular(25),
//         bottomRight: Radius.circular(25),
//       ),
//       color: Jobstopcolor.primarycolor,
//       image: DecorationImage(
//         image: AssetImage(JobstopPngImg.backgroundProf),
//         fit: BoxFit.cover,
//       ),
//     ),
//     // padding: EdgeInsets.only(top: kToolbarHeight),
//     child: SafeArea(
//       child: Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: context.fromWidth(CustomStyle.xs),
//           vertical: context.fromHeight(CustomStyle.huge2),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 CircularImage(
//                   JobstopPngImg.photo,
//                   size: context.fromHeight(CustomStyle.imageSize2),
//                 ),
//                 Spacer(),
//                 InkWell(
//                   onTap: () {
//                     Get.toNamed(SippoRoutes.sippoprofilesetting);
//                   },
//                   child: Image.asset(
//                     JobstopPngImg.setting,
//                     height: context.fromHeight(CustomStyle.l),
//                     color: Jobstopcolor.white,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
//             Text(
//               "Orlando Diggs",
//               style: dmsmedium.copyWith(
//                 fontSize: FontSize.title5(context),
//                 color: Jobstopcolor.white,
//               ),
//             ),
//             SizedBox(height: context.fromHeight(CustomStyle.huge2)),
//             Text(
//               "California, USA",
//               style: dmsregular.copyWith(
//                 fontSize: FontSize.label(context),
//                 color: Jobstopcolor.white,
//               ),
//             ),
//             SizedBox(height: context.fromHeight(CustomStyle.huge2)),
//             _buildPhoneNumberLabels(context, "0922698540", "0910663477"),
//             SizedBox(height: context.fromHeight(CustomStyle.xl)),
//             Row(
//               children: [
//                 Spacer(),
//                 InkWell(
//                   onTap: () => Get.toNamed(SippoRoutes.edituserprofile),
//                   child: Row(
//                     children: [
//                       Text(
//                         "edit_profile".tr,
//                         style: dmsregular.copyWith(
//                           fontSize: FontSize.label(context),
//                           color: Jobstopcolor.white,
//                         ),
//                       ),
//                       Image.asset(
//                         JobstopPngImg.edit,
//                         height: context.fromHeight(CustomStyle.l),
//                         color: Jobstopcolor.white,
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }

// Row _buildPhoneNumberLabels(
//   BuildContext context,
//   String phone1, [
//   String? phone2,
// ]) {
//   return Row(
//     children: [
//       Text(
//         phone1,
//         style: dmsregular.copyWith(
//           fontSize: FontSize.label(context),
//           color: Jobstopcolor.white,
//         ),
//       ),
//       if (phone2 != null) ...[
//         SizedBox(
//           width: context.fromWidth(CustomStyle.spaceBetween),
//         ),
//         Text(
//           phone2,
//           style: dmsregular.copyWith(
//             fontSize: FontSize.label(context),
//             color: Jobstopcolor.white,
//           ),
//         ),
//       ]
//     ],
//   );
// }
}
