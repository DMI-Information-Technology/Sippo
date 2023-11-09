import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/jobstopprefname.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/sippo_controller/user_profile_controller/profile_user_controller.dart';
import 'package:jobspot/sippo_custom_widget/ConditionalWidget.dart';
import 'package:jobspot/sippo_custom_widget/add_info_profile_card.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/expandable_item_list_widget.dart';
import 'package:jobspot/sippo_custom_widget/loading_view_widgets/loading_scaffold.dart';
import 'package:jobspot/sippo_custom_widget/profile_completion_widget.dart';
import 'package:jobspot/sippo_custom_widget/resume_card_widget.dart';
import 'package:jobspot/sippo_custom_widget/user_profile_header.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/sippo_pages/sippo_user_pages/job_aboutme.dart';
import 'package:readmore/readmore.dart';

class SippoUserProfile extends StatefulWidget {
  const SippoUserProfile({Key? key}) : super(key: key);

  @override
  State<SippoUserProfile> createState() => _SippoUserProfileState();
}

class _SippoUserProfileState extends State<SippoUserProfile> {
  final _controller = ProfileUserController.instance;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(milliseconds: 2700),
      () {
        if (_controller.user.isEmailVerified == false)
          Get.dialog(CustomAlertDialog(
            imageAsset: JobstopPngImg.emailV,
            title: 'email_verification'.tr,
            description: 'check_email_verification_dialog_desc'.tr,
            onConfirm: () => Get.back(),
          ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScaffold(
      controller: _controller.loadingOverlayController,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Obx(() {
          final isHeightOverAppBar =
              _controller.profileState.isHeightOverAppBar;
          return AppBar(
            // toolbarHeight: 0,
            notificationPredicate: (notification) {
              if (notification.metrics.pixels > kToolbarHeight) {
                _controller.profileState.isHeightOverAppBar = true;
              } else {
                _controller.profileState.isHeightOverAppBar = false;
              }
              return false;
            },
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back_rounded,
                color: isHeightOverAppBar ? Colors.black : Colors.white,
              ),
            ),
            actions: [
              InkWell(
                onTap: () {
                  if (_controller.netController.isNotConnected) return;
                  Get.toNamed(SippoRoutes.sippoprofilesetting);
                },
                child: Padding(
                  padding: EdgeInsets.all(context.fromHeight(CustomStyle.xxl)),
                  child: Image.asset(
                    JobstopPngImg.setting,

                    color: isHeightOverAppBar
                        ? Colors.black
                        : Colors.white, // Change this to your desired color
                  ),
                ),
              ),
            ],
            backgroundColor: isHeightOverAppBar
                ? Jobstopcolor.backgroudHome
                : Colors.transparent,
          );
        }),
      ),
      body: BodyWidget(
        isTopScrollable: true,
        isScrollable: true,
        topScreen: _buildUserProfileHeader(),
        paddingContent: EdgeInsets.symmetric(
          horizontal: context.fromWidth(CustomStyle.paddingValue),
        ),
        child: Column(
          children: [
            SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
            _buildProfileCompletion(context),
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
            _buildProjectsInfo(context),
            SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
            _buildResumeInfo(context),
            SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCompletion(BuildContext context) {
    return Obx(
      () {
        final profileMessages =
            _controller.profileState.profileView.blankProfileMessages();
        return ConditionalWidget(
          isLoading: _controller.states.isLoading,
          profileMessages.isNotEmpty == true &&
              _controller.netController.isConnectedNorm,
          data: profileMessages,
          guaranteedBuilder: (context, data) {
            return ProfileCompletionWidget(
              controller: _controller.profileCompletionController,
              profile: profileMessages,
              onTap: (messages) {},
            );
          },
        );
      },
    );
  }

  Widget _buildUserProfileHeader() {
    return Obx(() => UserProfileHeaderWidget(
          profileInfo: _controller.user,
          onEditProfilePressed: () => Get.toNamed(SippoRoutes.editUserProfile),
          profileImage: _controller.user.profileImage?.url ?? "",
        ));
  }

  Widget _buildResumeInfo(BuildContext context) {
    return Obx(() => AddInfoProfileCard(
          title: 'resume'.tr,
          leading: Image.asset(
            JobstopPngImg.resume,
            height: context.fromHeight(CustomStyle.l),
            color: Jobstopcolor.primarycolor,
            colorBlendMode: BlendMode.srcIn,
          ),
          iconAction: _controller.user.cv != null
              ? Icon(
                  Icons.mode_edit_outline_outlined,
                  size: context.fromHeight(CustomStyle.l),
                  color: Jobstopcolor.primarycolor,
                )
              : null,
          onAddClicked: () async {
            Get.toNamed(SippoRoutes.uploadresume);
            print(_controller.profileState.cvFile);
          },
          hasNotInfoProfile: _controller.user.cv == null,
          profileInfo: [
            _buildResumeCardWidget(context),
          ],
        ));
  }

  Widget _buildResumeCardWidget(BuildContext context) {
    return Obx(
      () => ConditionalWidget(
        _controller.user.cv != null,
        guaranteedBuilder: (context, data) {
          return CvCardWidget.fromRemote(
            remoteCv: _controller.user.cv,
            onCvTapped: () async {
              _controller.loadingOverlayController.start();
              await _controller.openFile(_controller.user.cv?.url);
              _controller.loadingOverlayController.pause();
            },
          );
        },
        avoidBuilder: (context, data) {
          return CvCardWidget(
            fileCv: _controller.profileState.cvFile,
            onCvTapped: () {},
          );
        },
      ),
    );
  }

  Widget _buildProjectsInfo(BuildContext context) {
    return Obx(
      () => AddInfoProfileCard(
        title: 'projects'.tr,
        hasNotInfoProfile: _controller.profileState.projectsList.isEmpty,
        leading: Image.asset(
          JobstopPngImg.appreciation,
          height: context.fromHeight(CustomStyle.l),
          color: Jobstopcolor.primarycolor,
          colorBlendMode: BlendMode.srcIn,
        ),
        profileInfo: [
          ExpandableItemList(
            isExpandable: _controller.profileState.projectsList.length > 1,
            expandItems: _controller.profileState.showAllProjects,
            // spacing: context.fromHeight(CustomStyle.xxxl),
            itemCount: _controller.profileState.projectsList.length,
            itemBuilder: (BuildContext context, int index) {
              final item = _controller.profileState.projectsList[index];
              return _buildTextDescriptionInfo(
                context,
                item.name,
                '',
                item.date,
                onEdit: () {
                  _controller.editingId = item.id ?? -1;
                  Get.toNamed(
                    SippoRoutes.sippoEditAddUserProjects,
                    arguments: {'project': item},
                  )?.then((_) {
                    _controller.editingId = -1;
                  });
                },
              );
            },
            onExpandClicked: () {
              _controller.profileState.showAllProjects =
                  !_controller.profileState.showAllProjects;
            },
          ),
        ],
        onAddClicked: () {
          Get.toNamed(
            SippoRoutes.sippoEditAddUserProjects,
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
        hasNotInfoProfile: _controller.profileState.languages.isEmpty,
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
        hasNotInfoProfile: _controller.profileState.skillsList.isEmpty,
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
          hasNotInfoProfile: _controller.profileState.educationList.isEmpty,
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
        hasNotInfoProfile: _controller.profileState.workExList.isEmpty,
        leading: Image.asset(
          JobstopPngImg.bag,
          height: context.fromHeight(CustomStyle.l),
          color: Jobstopcolor.primarycolor,
          colorBlendMode: BlendMode.srcIn,
        ),
        onAddClicked: () {
          Get.toNamed(
            SippoRoutes.userWorkExperience,
            arguments: {workExperienceArg: null},
          );
        },
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
                onEdit: () {
                  _controller.editingId = item.id?.toInt() ?? -1;
                  Get.toNamed(SippoRoutes.userWorkExperience);
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
        hasNotInfoProfile: _controller.profileState.aboutMeText.isEmpty,
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
          Get.to(() => const SippoUserAbout());
        },
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
    String? periodic, {
    required VoidCallback onEdit,
  }) {
    return ListTile(
      style: ListTileStyle.drawer,
      contentPadding: EdgeInsets.zero,
      minVerticalPadding: 0.0,
      horizontalTitleGap: 0.0,
      title: Text(
        title ?? "",
        style: dmsbold.copyWith(
          color: Jobstopcolor.primarycolor,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (from != null && from.trim().isNotEmpty) ...[
            Text(
              from,
              style: dmsregular.copyWith(
                color: Jobstopcolor.darkgrey,
              ),
            ),
            SizedBox(
              height: context.fromHeight(CustomStyle.huge2),
            ),
          ],
          Text(
            periodic ?? "",
            style: dmsregular.copyWith(color: Jobstopcolor.darkgrey),
          ),
        ],
      ),
      trailing: InkWell(
        onTap: onEdit,
        child: Image.asset(
          JobstopPngImg.edit,
          height: context.fromHeight(CustomStyle.l),
          color: Jobstopcolor.primarycolor,
          colorBlendMode: BlendMode.srcIn,
        ),
      ),
    );
  }
}
