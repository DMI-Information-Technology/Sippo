import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/media_query_sizes.dart';
import 'package:sippo/JobGlobalclass/sippo_customstyle.dart';
import 'package:sippo/sippo_controller/user_community_controller/user_community_controller.dart';
import 'package:sippo/sippo_custom_widget/ConditionalWidget.dart';
import 'package:sippo/sippo_custom_widget/body_widget.dart';
import 'package:sippo/sippo_custom_widget/error_messages_dialog_snackbar/network_connnection_lost_widget.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';
import 'package:sippo/sippo_pages/sippo_user_pages/sippo_user_community/show_community_company_companies.dart';
import 'package:sippo/sippo_pages/sippo_user_pages/sippo_user_community/show_community_company_posts.dart';

class SippoUserCommunity extends StatefulWidget {
  const SippoUserCommunity({Key? key}) : super(key: key);
  @override
  State<SippoUserCommunity> createState() => _SippoUserCommunityState();
}

class _SippoUserCommunityState extends State<SippoUserCommunity> {
  final _controller = Get.put(UserCommunityController());
  final _taps = const [
    ShowCommunityCompanyPostsList(),
    ShowCommunityCompanyCompaniesList()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyWidget(
        isTopScrollable: true,
        topScreen: Column(
          children: [
            Obx(() => ConditionalWidget(
                  !_controller.isNetworkConnected,
                  guaranteedBuilder: (_, __) => NetworkStatusNonWidget(
                    isPositioned: false,
                    color: Colors.black54,
                  ),
                  avoidBuilder: (_, __) => SizedBox(
                    height: context.fromHeight(CustomStyle.spaceBetween),
                  ),
                )),
          ],
        ),
        paddingContent: EdgeInsets.symmetric(horizontal: context.width / 36),
        child: Obx(() => _taps[_controller.selected]),
        paddingBottom: EdgeInsets.all(
          context.fromWidth(CustomStyle.paddingValue),
        ),
        bottomScreen: _buildBottomControlButtons(context),
      ),
    );
  }

  Widget _buildBottomControlButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(() => SizedBox(
              width: context.width / 2.4,
              height: context.height / 18,
              child: CustomButton(
                onTapped: () {
                  _controller.switchSelectedTap(0);
                },
                text: "posts".tr,
                borderRadiusValue: 12,
                backgroundColor: _controller.selected == 0
                    ? SippoColor.primarycolor
                    : SippoColor.lightprimary,
                textColor: _controller.selected == 0
                    ? SippoColor.white
                    : SippoColor.white,
              ),
            )),
        Obx(() => SizedBox(
              width: context.width / 2.4,
              height: context.height / 18,
              child: CustomButton(
                onTapped: () {
                  _controller.resetStates();
                  _controller.switchSelectedTap(1);
                },
                text: "title_my_connections".tr,
                borderRadiusValue: 12,
                backgroundColor: _controller.selected == 1
                    ? SippoColor.primarycolor
                    : SippoColor.lightprimary,
                textColor: _controller.selected == 1
                    ? SippoColor.white
                    : SippoColor.white,
              ),
            )),
      ],
    );
  }
}
