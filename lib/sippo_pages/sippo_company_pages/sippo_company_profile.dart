import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/sippo_controller/company_profile_controller/profile_company_controller.dart';
import 'package:jobspot/sippo_custom_widget/ConditionalWidget.dart';
import 'package:jobspot/sippo_custom_widget/add_info_profile_card.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/expandable_item_list_widget.dart';
import 'package:jobspot/sippo_custom_widget/gallry_image_uploader_widget_view.dart';
import 'package:jobspot/sippo_custom_widget/profile_completion_widget.dart';
import 'package:jobspot/sippo_custom_widget/rounded_border_radius_card_widget.dart';
import 'package:jobspot/sippo_custom_widget/user_profile_header.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:readmore/readmore.dart';

import 'edit_add_specialization_company.dart';
import 'sippo_about_company.dart';

class SippoCompanyProfile extends StatefulWidget {
  const SippoCompanyProfile({Key? key}) : super(key: key);

  @override
  State<SippoCompanyProfile> createState() => _SippoCompanyProfileState();
}

class _SippoCompanyProfileState extends State<SippoCompanyProfile> {
  final _controller = ProfileCompanyController.instance;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(milliseconds: 2700),
      () {
        if (_controller.company.isEmailVerified == false)
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
    return Scaffold(
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
                color: _controller.profileState.isHeightOverAppBar
                    ? Colors.black
                    : Colors.white,
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

                    color: _controller.profileState.isHeightOverAppBar
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
            _buildAlbumImagesProfile(context),
            SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
            _buildBioCompanyProfile(context),
            SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
            _buildWorkPlacesCompany(context),
            SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
            _buildWebsiteCompanyLink(context),
            SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
            _buildCompanySpecializations(context),
            SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
            _buildEmployeeCompanyCount(context),
            SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
            _buildEstablishmentCompanyDate(context),
            SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
          ],
        ),
      ),
    );
  }

  void _showUploadGalleryImagesScreen() {
    // print(_controller.company.images);
    Get.to(
      () => GalleryImageScreenView(
        title: 'Company Album Images',
        imagesResource: _controller.company.images,
        onSaveTap: _controller.uploadCompanyImages,
        onRemoveImage: _controller.removeImageCompany,
      ),
    );
  }

  Widget _buildProfileCompletion(BuildContext context) {
    return Obx(
      () {
        final profileMessages = _controller.company.blankProfileMessages();
        return ConditionalWidget(
          isLoading: _controller.states.isLoading,
          profileMessages.isNotEmpty == true &&
              _controller.netController.isConnectedNorm,
          data: profileMessages,
          guaranteedBuilder: (context, data) {
            return ProfileCompletionWidget(
              controller: _controller.profileCompletionController,
              profile: data,
            );
          },
        );
      },
    );
  }

  Widget _buildEstablishmentCompanyDate(BuildContext context) {
    return Obx(() => AddInfoProfileCard(
          title: 'Establishment Date'.tr,
          hasNotInfoProfile:
              _controller.company.establishmentDate?.isEmpty == true ||
                  _controller.company.establishmentDate?.isEmpty == null,
          leading: Image.asset(
            JobstopPngImg.aboutme,
            height: context.fromHeight(CustomStyle.l),
            color: Jobstopcolor.primarycolor,
            colorBlendMode: BlendMode.srcIn,
          ),
          iconAction: _controller.company.establishmentDate != null
              ? Icon(
                  Icons.mode_edit_outline_outlined,
                  size: context.fromHeight(CustomStyle.l),
                  color: Jobstopcolor.primarycolor,
                )
              : null,
          onAddClicked: () {
            if (_controller.netController.isNotConnected) return;
            Get.toNamed(SippoRoutes.editCompanyProfile);
          },
          alignmentFromStart: true,
          profileInfo: [
            AutoSizeText(
              "Establishment in ${_controller.company.establishmentDate}",
              style: dmsregular,
            )
          ],
        ));
  }

  Widget _buildEmployeeCompanyCount(BuildContext context) {
    return Obx(() => AddInfoProfileCard(
          title: 'Employee Count'.tr,
          hasNotInfoProfile: _controller.company.employeesCount == null,
          leading: Image.asset(
            JobstopPngImg.aboutme,
            height: context.fromHeight(CustomStyle.l),
            color: Jobstopcolor.primarycolor,
            colorBlendMode: BlendMode.srcIn,
          ),
          iconAction: _controller.company.employeesCount != null
              ? Icon(
                  Icons.mode_edit_outline_outlined,
                  size: context.fromHeight(CustomStyle.l),
                  color: Jobstopcolor.primarycolor,
                )
              : null,
          alignmentFromStart: true,
          onAddClicked: () {
            if (_controller.netController.isNotConnected) return;
            Get.toNamed(SippoRoutes.editCompanyProfile);
          },
          profileInfo: [
            ConditionalWidget(
              (_controller.company.employeesCount ?? 0) > 0,
              data: _controller.company.employeesCount,
              guaranteedBuilder: (context, data) {
                return AutoSizeText(
                  "${data ?? 0} employee work in the company.",
                  style: dmsregular,
                );
              },
              avoidBuilder: (context, data) {
                return AutoSizeText(
                  "No employee yet in the company.",
                  style: dmsregular,
                );
              },
            )
          ],
        ));
  }

  Widget _buildCompanySpecializations(BuildContext context) {
    final profileState = _controller.profileState;

    return Obx(() => AddInfoProfileCard(
          title: 'Company specializations'.tr,
          hasNotInfoProfile:
              _controller.company.specializations?.isEmpty == true,
          leading: Image.asset(
            JobstopPngImg.aboutme,
            height: context.fromHeight(CustomStyle.l),
            color: Jobstopcolor.primarycolor,
            colorBlendMode: BlendMode.srcIn,
          ),
          iconAction: _controller.company.specializations?.isNotEmpty == true
              ? Icon(
                  Icons.mode_edit_outline_outlined,
                  size: context.fromHeight(CustomStyle.l),
                  color: Jobstopcolor.primarycolor,
                )
              : null,
          alignmentFromStart: true,
          onAddClicked: () {
            if (_controller.netController.isNotConnected) return;
            Get.to(() => const EditAddSpecializationCompany());
          },
          profileInfo: [
            ExpandableItemList.wrapBuilder(
              isExpandable:
                  (_controller.company.specializations?.length ?? 0) > 1,
              itemCount: _controller.company.specializations?.length ?? 0,
              expandItems: profileState.showAllSpecializations,
              spacing: context.fromHeight(CustomStyle.xxxl),
              alignmentFromStart: true,
              itemBuilder: (context, index) {
                final item = _controller.company.specializations?[index];
                return _buildChips(
                  context,
                  item?.name ?? 'unknown',
                );
              },
              onExpandClicked: () {
                profileState.switchShowAllSpecializations();
              },
            )
          ],
        ));
  }

  Widget _buildWebsiteCompanyLink(BuildContext context) {
    return Obx(() => AddInfoProfileCard(
          title: 'Website Company'.tr,
          hasNotInfoProfile: _controller.company.website?.isEmpty == true ||
              _controller.company.website?.isEmpty == null,
          leading: Image.asset(
            JobstopPngImg.aboutme,
            height: context.fromHeight(CustomStyle.l),
            color: Jobstopcolor.primarycolor,
            colorBlendMode: BlendMode.srcIn,
          ),
          onAddClicked: () {
            if (_controller.netController.isNotConnected) return;
            Get.toNamed(SippoRoutes.editCompanyProfile);
          },
          iconAction: _controller.company.website != null
              ? Icon(
                  Icons.mode_edit_outline_outlined,
                  size: context.fromHeight(CustomStyle.l),
                  color: Jobstopcolor.primarycolor,
                )
              : null,
          profileInfo: [
            InkWell(
              onTap: () {},
              child: AutoSizeText(
                _controller.company.website.toString(),
                style: dmsregular.copyWith(
                  color: Jobstopcolor.primarycolor,
                  decoration: TextDecoration.underline,
                  decorationColor: Jobstopcolor.primarycolor,
                ),
              ),
            )
          ],
        ));
  }

  Widget _buildWorkPlacesCompany(BuildContext context) {
    final profileState = _controller.profileState;

    return Obx(() {
      return AddInfoProfileCard(
        title: 'Work Places'.tr,
        hasNotInfoProfile: _controller.company.locations?.isEmpty == true ||
            _controller.company.locations?.isEmpty == null,
        leading: Image.asset(
          JobstopPngImg.aboutme,
          height: context.fromHeight(CustomStyle.l),
          color: Jobstopcolor.primarycolor,
          colorBlendMode: BlendMode.srcIn,
        ),
        onAddClicked: () {
          if (_controller.netController.isNotConnected) return;
          Get.toNamed(SippoRoutes.sippoOpenGoogleMapView);
        },
        profileInfo: [
          ExpandableItemList(
            isExpandable: (_controller.company.locations?.length ?? 0) > 1,
            itemCount: _controller.company.locations?.length ?? 0,
            expandItems: profileState.showAllLocations,
            spacing: context.fromHeight(CustomStyle.xxxl),
            alignmentFromStart: true,
            itemBuilder: (context, index) {
              final item = _controller.company.locations?[index];
              return AutoSizeText(
                item?.locationAddress?.name ?? '',
                style: dmsregular.copyWith(
                  color: Jobstopcolor.primarycolor,
                ),
              );
            },
            onExpandClicked: () {
              profileState.switchShowAllLocations();
            },
          ),
        ],
      );
    });
  }

  Widget _buildBioCompanyProfile(BuildContext context) {
    return Obx(() => AddInfoProfileCard(
          title: 'Personal Info'.tr,
          hasNotInfoProfile: _controller.company.bio?.isEmpty == true ||
              _controller.company.bio?.isEmpty == null,
          leading: Image.asset(
            JobstopPngImg.companysignup,
            height: context.fromHeight(CustomStyle.l),
            color: Jobstopcolor.primarycolor,
            colorBlendMode: BlendMode.srcIn,
          ),
          iconAction: _controller.company.bio != null
              ? Icon(
                  Icons.mode_edit_outline_outlined,
                  size: context.fromHeight(CustomStyle.l),
                  color: Jobstopcolor.primarycolor,
                )
              : null,
          onAddClicked: () {
            if (_controller.netController.isNotConnected) return;
            Get.to(() => const SippoAboutCompany());
          },
          profileInfo: [
            ReadMoreText(
              textAlign: TextAlign.start,
              _controller.company.bio.toString(),
              style: dmsregular,
            )
          ],
        ));
  }

  Widget _buildAlbumImagesProfile(BuildContext context) {
    return RoundedBorderRadiusCardWidget(
      paddingType: PaddingType.horizontal,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 0.0,
        leading: Icon(
          Icons.image,
          color: Jobstopcolor.primarycolor,
          size: context.fromHeight(CustomStyle.l),
        ),
        title: Text(
          'Album Images',
          style: dmsbold.copyWith(
            color: Jobstopcolor.primarycolor,
            fontSize: 14,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_sharp,
          color: Jobstopcolor.primarycolor,
        ),
        onTap: () {
          _showUploadGalleryImagesScreen();
        },
      ),
    );
  }

  Widget _buildUserProfileHeader() {
    return Obx(() => UserProfileHeaderWidget(
          profileInfo: _controller.company,
          onEditProfilePressed: () {
            if (_controller.netController.isNotConnected) return;
            Get.toNamed(SippoRoutes.editCompanyProfile);
          },
          profileImage: _controller.company.profileImage?.url ?? "",
        ));
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
}
