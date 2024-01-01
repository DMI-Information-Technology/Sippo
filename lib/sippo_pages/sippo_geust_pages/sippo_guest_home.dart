import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/JobGlobalclass/jobstopimges.dart';
import 'package:sippo/JobGlobalclass/media_query_sizes.dart';
import 'package:sippo/JobGlobalclass/routes.dart';
import 'package:sippo/JobGlobalclass/sippo_customstyle.dart';
import 'package:sippo/JobGlobalclass/text_font_size.dart';
import 'package:sippo/sippo_controller/home_controllers/job_home_view_controller.dart';
import 'package:sippo/sippo_controller/home_controllers/user_home_controllers.dart';
import 'package:sippo/sippo_custom_widget/body_widget.dart';
import 'package:sippo/sippo_custom_widget/find_yor_jop_dashboard_cards.dart';
import 'package:sippo/sippo_custom_widget/network_bordered_circular_image_widget.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';
import 'package:sippo/sippo_pages/ads_view/ads_view_widget.dart';
import 'package:sippo/sippo_pages/home_component_widget/job_home_view_widget.dart';

class SippoGuestHome extends StatefulWidget {
  const SippoGuestHome({Key? key}) : super(key: key);

  @override
  State<SippoGuestHome> createState() => _SippoGuestHomeState();
}

class _SippoGuestHomeState extends State<SippoGuestHome> {
  final _controller = GuestHomeController.instance;

  // final _controller = UserHomeController.instance;
  final jobsHomeView = const JobHomeViewWidget();
  final adsView = const AdsViewWidget();
  final jobStatisticBoard = const JobStatisticBoardViewWidget();

  @override
  void didUpdateWidget(covariant SippoGuestHome oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('_SippoUserHomeState.didUpdateWidget');
  }

  @override
  Widget build(BuildContext context) {
    print('_SippoUserHomeState.build');
    return Scaffold(
      appBar: _buildHomeAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          _controller.refreshPage();
        },
        child: BodyWidget(
          paddingContent: EdgeInsets.only(
            bottom: context.fromHeight(CustomStyle.paddingValue),
          ),
          isScrollable: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildShowAdsBoard(),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.fromWidth(CustomStyle.s),
                ),
                child: Text(
                  "Category".tr,
                  style: dmsbold.copyWith(fontSize: FontSize.title5(context)),
                ),
              ),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              _buildSpecialListView(context),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.fromWidth(CustomStyle.s),
                ),
                child: Text(
                  "Find_Your_Job".tr,
                  style: dmsbold.copyWith(fontSize: FontSize.title5(context)),
                ),
              ),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              _buildShowJobStatisticBoard(),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.fromWidth(CustomStyle.s),
                ),
                child: Text(
                  "Recent_Job_List".tr,
                  style: dmsbold.copyWith(fontSize: FontSize.title5(context)),
                ),
              ),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              // _buildShowHomeJobPagination(context),
              _buildShowHomeJobsList(),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
            ],
          ),
        ),
      ),
      backgroundColor: SippoColor.backgroudHome,
    );
  }

  Widget _buildShowHomeJobsList() => jobsHomeView;

  Widget _buildShowAdsBoard() => adsView;

  Widget _buildShowJobStatisticBoard() => jobStatisticBoard;

  SizedBox _buildSpecialListView(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double width = size.width;
    return SizedBox(
      height: context.fromHeight(CustomStyle.xs),
      child: Obx(() {
        final specializations = _controller.userHomeState.specializationList;
        return ListView.separated(
          padding: EdgeInsets.symmetric(
            horizontal: context.fromWidth(CustomStyle.s),
          ),
          scrollDirection: Axis.horizontal,
          itemCount: specializations.length,
          itemBuilder: (context, index) {
            return Obx(() {
              final special = specializations[index];
              return CustomChip(
                onTap: () {
                  _controller.userHomeState.selectedSpecialization = special;
                  if (Get.isRegistered<JobsHomeViewController>())
                    JobsHomeViewController.instance.refreshJobs(
                      _controller.userHomeState.selectedSpecialization,
                    );
                },
                child: AutoSizeText(
                  specializations[index].name ?? '',
                  style: dmsregular.copyWith(
                    color: _controller.userHomeState.selectedSpecialization ==
                            special
                        ? Colors.white
                        : SippoColor.black,
                    fontSize: FontSize.label(context),
                  ),
                ),
                backgroundColor:
                    _controller.userHomeState.selectedSpecialization == special
                        ? SippoColor.primarycolor
                        : SippoColor.grey2,
                borderRadius: width / 32,
                paddingValue: context.fromHeight(CustomStyle.xxxl),
              );
            });
          },
          separatorBuilder: (context, index) => SizedBox(
            width: context.fromWidth(CustomStyle.s),
          ),
        );
      }),
    );
  }

  AppBar _buildHomeAppBar() {
    Size size = MediaQuery.sizeOf(context);
    double height = size.height;
    double width = size.width;
    return AppBar(
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width / 28),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Get.toNamed(SippoRoutes.sippoGeneralSearchPage);
                },
                icon: Icon(
                  Icons.search,
                  size: height / 30,
                ),
              ),
              SizedBox(width: width / 52),
              InkWell(
                onTap: () {
                  Get.dialog(CustomAlertDialog.verticalButtons(
                    title: 'guest_action'.tr,
                    description: 'guest_action_message'.tr,
                    cancelBtnTitle: 'Login'.tr,
                    onCancel: () {
                      Get.offAllNamed(SippoRoutes.userLoginPage);
                    },
                    onConfirm: () {
                      Get.back();
                    },
                  ));
                },
                child: NetworkBorderedCircularImage(
                  imageUrl: '',
                  errorWidget: (___, __, _) => CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset(JobstopPngImg.signup),
                  ),
                  placeholder: (_, __) => CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset(JobstopPngImg.signup),
                  ),
                  size: context.fromHeight(24),
                  outerBorderColor: SippoColor.backgroudHome,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
