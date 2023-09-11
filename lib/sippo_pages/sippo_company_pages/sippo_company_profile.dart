import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';

import '../../JobGlobalclass/jobstopcolor.dart';
import '../../JobGlobalclass/sippo_customstyle.dart';
import '../../JopController/company_profile_controller/profile_company_controller.dart';
import '../../sippo_custom_widget/ConditionalWidget.dart';
import '../../sippo_custom_widget/add_info_profile_card.dart';
import '../../sippo_custom_widget/body_widget.dart';
import '../../sippo_custom_widget/error_messages_dialog_snackbar/network_connnection_lost_widget.dart';
import '../../sippo_custom_widget/user_profile_header.dart';

class SippoCompanyProfile extends StatefulWidget {
  const SippoCompanyProfile({Key? key}) : super(key: key);

  @override
  State<SippoCompanyProfile> createState() => _SippoCompanyProfileState();
}

class _SippoCompanyProfileState extends State<SippoCompanyProfile> {
  final _controller = ProfileCompanyController.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.black87,
      ),
      body: BodyWidget(
        isTopScrollable: true,
        isScrollable: true,
        connectionStatusBar: Obx(() => ConditionalWidget(
              !_controller.netController.isConnected,
              guaranteedBuilder: (_, __) => NetworkStatusNonWidget(),
            )),
        topScreen: Obx(
          () => _buildUserProfileHeader(!_controller.netController.isConnected),
        ),
        paddingContent: EdgeInsets.symmetric(
          horizontal: context.fromWidth(CustomStyle.paddingValue),
        ),
        child: Column(
          children: [
            SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
            AddInfoProfileCard(
              title: 'Personal Info'.tr,
              noInfoProfile: true,
              leading: Image.asset(
                JobstopPngImg.companysignup,
                height: context.fromHeight(CustomStyle.l),
                color: Jobstopcolor.primarycolor,
                colorBlendMode: BlendMode.srcIn,
              ),
              onAddClicked: () {},
              profileInfo: [],
            ),
            SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
            AddInfoProfileCard(
              title: 'Work Places'.tr,
              noInfoProfile: true,
              leading: Image.asset(
                JobstopPngImg.aboutme,
                height: context.fromHeight(CustomStyle.l),
                color: Jobstopcolor.primarycolor,
                colorBlendMode: BlendMode.srcIn,
              ),
              onAddClicked: () {},
              profileInfo: [],
            ),
            SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
            AddInfoProfileCard(
              title: 'Website Company'.tr,
              noInfoProfile: true,
              leading: Image.asset(
                JobstopPngImg.aboutme,
                height: context.fromHeight(CustomStyle.l),
                color: Jobstopcolor.primarycolor,
                colorBlendMode: BlendMode.srcIn,
              ),
              onAddClicked: () {},
              profileInfo: [],
            ),
            SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
            AddInfoProfileCard(
              title: 'Company specializations'.tr,
              noInfoProfile: true,
              leading: Image.asset(
                JobstopPngImg.aboutme,
                height: context.fromHeight(CustomStyle.l),
                color: Jobstopcolor.primarycolor,
                colorBlendMode: BlendMode.srcIn,
              ),
              onAddClicked: () {},
              profileInfo: [],
            ),
            SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
            AddInfoProfileCard(
              title: 'Employee Count'.tr,
              noInfoProfile: true,
              leading: Image.asset(
                JobstopPngImg.aboutme,
                height: context.fromHeight(CustomStyle.l),
                color: Jobstopcolor.primarycolor,
                colorBlendMode: BlendMode.srcIn,
              ),
              onAddClicked: () {},
              profileInfo: [],
            ),
            SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
            AddInfoProfileCard(
              title: 'Establishment Date'.tr,
              noInfoProfile: true,
              leading: Image.asset(
                JobstopPngImg.aboutme,
                height: context.fromHeight(CustomStyle.l),
                color: Jobstopcolor.primarycolor,
                colorBlendMode: BlendMode.srcIn,
              ),
              onAddClicked: () {},
              profileInfo: [],
            ),
            SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfileHeader([bool isLostConnect = false]) {
    return UserProfileHeaderWidget(
      showConnectionLostBar: isLostConnect,
      profileInfo: _controller.company,
      onSettingsPressed: () => Get.toNamed(SippoRoutes.sippoprofilesetting),
      onEditProfilePressed: () => Get.toNamed(SippoRoutes.editCompanyProfile),
      profileImage: JobstopPngImg.photo,
    );
  }
}
