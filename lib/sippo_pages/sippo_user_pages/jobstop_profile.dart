import 'package:flutter/material.dart';
import 'package:jobspot/JobGlobalclass/jobstopprefname.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:get/get.dart';
import 'package:jobspot/JopController/ProfileController/profile_user_controller.dart';
import 'package:jobspot/JopCustomWidget/add_info_profile_card.dart';
import 'package:jobspot/JopCustomWidget/resume_card_widget.dart';
import 'package:readmore/readmore.dart';
import '../../JopCustomWidget/expandable_item_list_widget.dart';
import '../../sippo_data/model/profile_model/jobstop_appreciation_info_card_model.dart';
import '../../sippo_data/model/profile_model/jobstop_education_info_card_model.dart';
import '../../sippo_data/model/profile_model/jobstop_work_experience_info_card_model.dart';

class SippoUserProfile extends StatefulWidget {
  const SippoUserProfile({Key? key}) : super(key: key);

  @override
  State<SippoUserProfile> createState() => _SippoUserProfileState();
}

class _SippoUserProfileState extends State<SippoUserProfile> {
  ProfileUserController profileController = Get.put(ProfileUserController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderInfoProfile(),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width / 26, vertical: height / 46),
              child: Column(
                children: [
                  Obx(
                    () => AddInfoProfileCard(
                      title: "About me",
                      noInfoProfile: profileController.aboutMeText.isEmpty,
                      leading: Image.asset(
                        JobstopPngImg.aboutme,
                        height: height / 40,
                        color: Jobstopcolor.primarycolor,
                        colorBlendMode: BlendMode.srcIn,
                      ),
                      iconAction: profileController.aboutMeText.isNotEmpty
                          ? Icon(
                              Icons.mode_edit_outline_outlined,
                              size: height / 36,
                              color: Jobstopcolor.primarycolor,
                            )
                          : null,
                      onAddClicked: () {},
                      profileInfo: [
                        profileController.aboutMeText.isNotEmpty
                            ? ReadMoreText(
                                profileController.aboutMeText,
                                trimLines: 2,
                                style: dmsregular.copyWith(
                                  fontSize: height / 58,
                                  color: Jobstopcolor.textColor,
                                ),
                                colorClickableText: Jobstopcolor.primarycolor,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: '...show more',
                                trimExpandedText: ' show less',
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height / 46,
                  ),
                  Obx(
                    () => AddInfoProfileCard(
                      title: "Work experience",
                      noInfoProfile: profileController.wei.isEmpty,
                      leading: Image.asset(
                        JobstopPngImg.bag,
                        height: height / 40,
                        color: Jobstopcolor.primarycolor,
                        colorBlendMode: BlendMode.srcIn,
                      ),
                      onAddClicked: () {
                        Get.toNamed(
                          SippoRoutesPages.workexperience,
                          arguments: {workExperienceArg: null},
                        );
                      },
                      profileInfo: [
                        ExpandableItemList(
                          isExpandable: profileController.wei.length > 1,
                          more: profileController.showAllWei,
                          titleExpandColor: Jobstopcolor.primarycolor,
                          spacing: height / 64,
                          itemCount: profileController.showAllWei
                              ? profileController.wei.length
                              : profileController.wei.length > 0
                                  ? 1
                                  : 0,
                          itemBuilder: (BuildContext context, int index) {
                            final item = profileController.wei[index];
                            return _buildWorkExperienceInfo(
                              context,
                              item,
                              onEdit: () {
                                Get.toNamed(
                                  SippoRoutesPages.workexperience,
                                  arguments: {workExperienceArg: item.toJson()},
                                );
                              },
                            );
                          },
                          onExpandClicked: () {
                            profileController.showAllWei =
                                !profileController.showAllWei;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height / 46),
                  Obx(() => AddInfoProfileCard(
                        title: "Education",
                        noInfoProfile: profileController.edui.isEmpty,
                        leading: Image.asset(
                          JobstopPngImg.education,
                          height: height / 40,
                          color: Jobstopcolor.primarycolor,
                          colorBlendMode: BlendMode.srcIn,
                        ),
                        onAddClicked: () {
                          Get.toNamed(
                            SippoRoutesPages.educationaddedit,
                            arguments: {educationArg: null},
                          );
                        },
                        profileInfo: [
                          ExpandableItemList(
                            isExpandable: profileController.edui.length > 1,
                            more: profileController.showAllEdui,
                            titleExpandColor: Jobstopcolor.primarycolor,
                            spacing: height / 64,
                            itemCount: profileController.showAllEdui
                                ? profileController.edui.length
                                : 1,
                            itemBuilder: (BuildContext context, int index) {
                              final item = profileController.edui[index];
                              return _buildEductionInfo(
                                context,
                                item,
                                onEdit: () {
                                  Get.toNamed(
                                    SippoRoutesPages.educationaddedit,
                                    arguments: {educationArg: item.toJson()},
                                  );
                                },
                              );
                            },
                            onExpandClicked: () {
                              profileController.showAllEdui =
                                  !profileController.showAllEdui;
                            },
                          ),
                        ],
                      )),
                  SizedBox(height: height / 46),
                  Obx(
                    () => AddInfoProfileCard(
                      title: "Skill",
                      noInfoProfile: profileController.skills.isEmpty,
                      leading: Image.asset(
                        JobstopPngImg.skil,
                        height: height / 40,
                        color: Jobstopcolor.primarycolor,
                        colorBlendMode: BlendMode.srcIn,
                      ),
                      iconAction: profileController.skills.isNotEmpty
                          ? Icon(
                              Icons.mode_edit_outline_outlined,
                              size: height / 36,
                              color: Jobstopcolor.primarycolor,
                            )
                          : null,
                      profileInfo: [
                        ExpandableItemList.wrapBuilder(
                          isExpandable: profileController.skills.length > 1,
                          more: profileController.showAllSkills,
                          titleExpandColor: Jobstopcolor.primarycolor,
                          spacing: height / 220,
                          itemCount: profileController.showAllSkills
                              ? profileController.skills.length
                              : 1,
                          itemBuilder: (BuildContext context, int index) {
                            final item = profileController.skills[index];
                            return _buildChips(context, item);
                          },
                          onExpandClicked: () {
                            profileController.showAllSkills =
                                !profileController.showAllSkills;
                          },
                        ),
                      ],
                      onAddClicked: () {
                        Get.toNamed(
                          SippoRoutesPages.skillsaddedit,
                          arguments: {skillsListArg: profileController.skills},
                        );
                      },
                    ),
                  ),
                  SizedBox(height: height / 46),
                  Obx(
                    () => AddInfoProfileCard(
                      title: "Language",
                      noInfoProfile: profileController.languages.isEmpty,
                      leading: Image.asset(
                        JobstopPngImg.language,
                        height: height / 40,
                        color: Jobstopcolor.primarycolor,
                        colorBlendMode: BlendMode.srcIn,
                      ),
                      iconAction: profileController.languages.isNotEmpty
                          ? Icon(
                              Icons.mode_edit_outline_outlined,
                              size: height / 36,
                              color: Jobstopcolor.primarycolor,
                            )
                          : null,
                      profileInfo: [
                        ExpandableItemList.wrapBuilder(
                          isExpandable: profileController.languages.length > 1,
                          more: profileController.showAllLangs,
                          titleExpandColor: Jobstopcolor.primarycolor,
                          spacing: height / 220,
                          itemCount: profileController.showAllLangs
                              ? profileController.languages.length
                              : 1,
                          itemBuilder: (BuildContext context, int index) {
                            final item = profileController.languages[index];
                            return _buildChips(
                              context,
                              item.languageName ?? "",
                            );
                          },
                          onExpandClicked: () {
                            profileController.showAllLangs =
                                !profileController.showAllLangs;
                          },
                        ),
                      ],
                      onAddClicked: () {
                        Get.toNamed(
                          SippoRoutesPages.languageeditadd,
                          arguments: {
                            langListArg: profileController.languages
                                .map((e) => e.toJson())
                                .toList()
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: height / 46,
                  ),
                  Obx(
                    () => AddInfoProfileCard(
                      title: "Appreciation",
                      noInfoProfile: profileController.appreciations.isEmpty,
                      leading: Image.asset(
                        JobstopPngImg.appreciation,
                        height: height / 40,
                        color: Jobstopcolor.primarycolor,
                        colorBlendMode: BlendMode.srcIn,
                      ),
                      profileInfo: [
                        ExpandableItemList(
                          isExpandable:
                              profileController.appreciations.length > 1,
                          more: profileController.showAllAppreciations,
                          titleExpandColor: Jobstopcolor.primarycolor,
                          spacing: height / 64,
                          itemCount: profileController.showAllAppreciations
                              ? profileController.appreciations.length
                              : 1,
                          itemBuilder: (BuildContext context, int index) {
                            final item = profileController.appreciations[index];
                            return _buildAppreciationInfo(
                              context,
                              item,
                              onEdit: () {
                                Get.toNamed(
                                  SippoRoutesPages.appreciationaddedit,
                                  arguments: {appreciationArg: item.toJson()},
                                );
                              },
                            );
                          },
                          onExpandClicked: () {
                            profileController.showAllAppreciations =
                                !profileController.showAllAppreciations;
                          },
                        ),
                      ],
                      onAddClicked: () {
                        Get.toNamed(
                          SippoRoutesPages.appreciationaddedit,
                          arguments: {appreciationArg: null},
                        );
                      },
                    ),
                  ),
                  SizedBox(height: height / 46),
                  AddInfoProfileCard(
                    title: "Resume",
                    leading: Image.asset(
                      JobstopPngImg.resume,
                      height: height / 40,
                      color: Jobstopcolor.primarycolor,
                      colorBlendMode: BlendMode.srcIn,
                    ),
                    onAddClicked: () async {
                      Get.toNamed(SippoRoutesPages.uploadresume);
                      print(profileController.resumeFiles);
                    },
                    noInfoProfile: false,
                    profileInfo: [ResumeCardWidget()],
                  ),
                  SizedBox(height: height / 46),
                ],
              ),
            )
          ],
        ),
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

  Widget _buildWorkExperienceInfo(
      BuildContext context, WorkExperienceInfoCardModel? wei,
      {required VoidCallback onEdit}) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          Text(
            wei?.position ?? "",
            style: dmsbold.copyWith(
                fontSize: 14, color: Jobstopcolor.primarycolor),
          ),
          const Spacer(),
          InkWell(
              onTap: onEdit,
              child: Image.asset(
                JobstopPngImg.edit,
                height: height / 36,
                color: Jobstopcolor.primarycolor,
                colorBlendMode: BlendMode.srcIn,
              )),
        ],
      ),
      SizedBox(
        height: height / 100,
      ),
      Text(
        wei?.company ?? "",
        style: dmsregular.copyWith(fontSize: 12, color: Jobstopcolor.darkgrey),
      ),
      SizedBox(
        height: height / 150,
      ),
      Text(
        wei?.periodic ?? "",
        style: dmsregular.copyWith(fontSize: 12, color: Jobstopcolor.darkgrey),
      ),
    ]);
  }

  Widget _buildEductionInfo(BuildContext context, EducationInfoCardModel? edui,
      {required VoidCallback onEdit}) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          SizedBox(
            width: width / 2,
            child: Text(
              edui?.level ?? "",
              style: dmsbold.copyWith(
                  fontSize: 14, color: Jobstopcolor.primarycolor),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Spacer(),
          InkWell(
              onTap: onEdit,
              child: Image.asset(
                JobstopPngImg.edit,
                height: height / 36,
                color: Jobstopcolor.primarycolor,
                colorBlendMode: BlendMode.srcIn,
              )),
        ],
      ),
      SizedBox(
        height: height / 100,
      ),
      Text(
        edui?.university ?? "",
        style: dmsregular.copyWith(fontSize: 12, color: Jobstopcolor.darkgrey),
      ),
      SizedBox(
        height: height / 150,
      ),
      Text(
        edui?.periodic ?? "",
        style: dmsregular.copyWith(fontSize: 12, color: Jobstopcolor.darkgrey),
      ),
    ]);
  }

  Widget _buildAppreciationInfo(
      BuildContext context, AppreciationInfoCardModel? apper,
      {required VoidCallback onEdit}) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: width / 2,
              child: Text(
                apper?.awardName ?? "",
                style: dmsbold.copyWith(
                    fontSize: 14, color: Jobstopcolor.primarycolor),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Spacer(),
            InkWell(
                onTap: onEdit,
                child: Image.asset(
                  JobstopPngImg.edit,
                  height: height / 36,
                  color: Jobstopcolor.primarycolor,
                  colorBlendMode: BlendMode.srcIn,
                )),
          ],
        ),
        SizedBox(
          height: height / 100,
        ),
        Text(
          apper?.categoryAchieve ?? "",
          style:
              dmsregular.copyWith(fontSize: 12, color: Jobstopcolor.darkgrey),
        ),
        SizedBox(
          height: height / 150,
        ),
        Text(
          apper?.year ?? "",
          style:
              dmsregular.copyWith(fontSize: 12, color: Jobstopcolor.darkgrey),
        ),
      ],
    );
  }

  Widget _buildHeaderInfoProfile() {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Jobstopcolor.primarycolor,
        image: DecorationImage(
          image: AssetImage(JobstopPngImg.backgroundProf),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: width / 26, vertical: height / 26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(JobstopPngImg.photo),
                ),
                SizedBox(
                  width: width / 2,
                ),
                Image.asset(
                  JobstopPngImg.union,
                  height: height / 36,
                  color: Jobstopcolor.white,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(SippoRoutesPages.sippoprofilesetting);
                  },
                  child: Image.asset(
                    JobstopPngImg.setting,
                    height: height / 36,
                    color: Jobstopcolor.white,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height / 46,
            ),
            Text(
              "Orlando Diggs",
              style:
                  dmsmedium.copyWith(fontSize: 14, color: Jobstopcolor.white),
            ),
            SizedBox(
              height: height / 100,
            ),
            Text(
              "California, USA",
              style:
                  dmsregular.copyWith(fontSize: 12, color: Jobstopcolor.white),
            ),
            SizedBox(
              height: height / 36,
            ),
            Row(
              children: [
                Spacer(),
                InkWell(
                  onTap: () => Get.toNamed(SippoRoutesPages.edituserprofile),
                  child: Row(
                    children: [
                      Text(
                        "Edit profile ",
                        style: dmsregular.copyWith(
                            fontSize: 12, color: Jobstopcolor.white),
                      ),
                      Image.asset(
                        JobstopPngImg.edit,
                        height: height / 36,
                        color: Jobstopcolor.white,
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
