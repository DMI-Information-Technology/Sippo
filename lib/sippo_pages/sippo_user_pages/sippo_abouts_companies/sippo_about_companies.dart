import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/sippo_custom_widget/ConditionalWidget.dart';
import 'package:jobspot/sippo_custom_widget/rounded_border_radius_card_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/sippo_pages/sippo_user_pages/sippo_abouts_companies/show_about_companies_details.dart';
import 'package:jobspot/sippo_pages/sippo_user_pages/sippo_abouts_companies/show_about_companies_jobs.dart';
import 'package:jobspot/sippo_pages/sippo_user_pages/sippo_abouts_companies/show_about_companies_posts.dart';

import '../../../JobGlobalclass/global_storage.dart';
import '../../../JobGlobalclass/jobstopcolor.dart';
import '../../../JobGlobalclass/jobstopfontstyle.dart';
import '../../../JobGlobalclass/text_font_size.dart';
import '../../../JopController/user_community_controller/user_about_companies_controllers.dart';
import '../../../sippo_custom_widget/top_job_details_header.dart';
import '../../../utils/app_use.dart';
import '../sippo_job_description/sippo_job_description.dart';

class SippoAboutCompanies extends StatefulWidget {
  const SippoAboutCompanies({Key? key}) : super(key: key);

  @override
  State<SippoAboutCompanies> createState() => _SippoAboutCompaniesState();
}

class _SippoAboutCompaniesState extends State<SippoAboutCompanies> {
  final steps = ["about_us".tr, "posts".tr, "jobs".tr];

  final _controller = UserAboutCompaniesController.instance;
  late final List<Widget> _taps;

  @override
  void initState() {
    _taps = [
      SliverToBoxAdapter(
        child: ShowAboutCompaniesDetails(
          company: _controller.aboutState.company,
        ),
      ),
      const ShowAboutCompaniesPostsList(),
      const ShowAboutCompaniesJobsList()
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Jobstopcolor.backgroudHome,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: CustomSliverAppBarDelegate(
              expandedHeight: (context.height / 3.5),
              onLeadingTap: () => Get.back(),
            ),
            pinned: true,
          ),
          SliverToBoxAdapter(child: SizedBox(height: context.height / 32)),
          SliverToBoxAdapter(
            child: _buildTopHeaderCompanyInfo(context),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: context.height / 36),
          ),
          _buildTopHeaderButtons(context),
          Obx(
            () => SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: context.fromWidth(
                  CustomStyle.paddingValue,
                ),
              ),
              sliver: _taps[_controller.aboutState.selectedTaps],
            ),
          ),
        ],
      ),
      bottomNavigationBar: GlobalStorageService.appUse == AppUsingType.user
          ? _buildApplyBottomButton(context)
          : null,
    );
  }

  Widget _buildApplyBottomButton(BuildContext context) {
    return Obx(() => ConditionalWidget(
          _controller.aboutState.selectedTaps == 0,
          guaranteedBuilder: (context, _) => Padding(
            padding: EdgeInsets.all(
              context.fromWidth(CustomStyle.paddingValue),
            ),
            child: CustomButton(
              onTapped: () {
                Get.toNamed(SippoRoutes.sippoUserApplyCompany);
              },
              text: "apply",
            ),
          ),
        ));
  }

  SliverList _buildTopHeaderButtons(BuildContext context) {
    return SliverList.list(children: [
      _buildConnectionsButtonsCompany(context),
      SizedBox(
        height: context.height / 32,
      ),
      _buildPageTapBarButtons(context),
      SizedBox(
        height: context.height / 32,
      ),
    ]);
  }

  Widget _buildPageTapBarButtons(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.width / CustomStyle.paddingValue,
      ),
      width: context.width,
      child: RoundedBorderRadiusCardWidget(
        padding: EdgeInsets.all(context.fromWidth(CustomStyle.xxl)),
        child: Row(
          children: List.generate(steps.length, (i) {
            return Expanded(
              child: Obx(() => CustomButton(
                    onTapped: () {
                      _controller.aboutState.selectedTaps = i;
                    },
                    text: steps[i],
                    backgroundColor: _controller.aboutState.selectedTaps == i
                        ? Jobstopcolor.secondary
                        : Colors.white,
                    textColor: _controller.aboutState.selectedTaps == i
                        ? Colors.white
                        : Colors.black87,
                  )),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildConnectionsButtonsCompany(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.width / CustomStyle.paddingValue,
      ),
      width: context.width,
      child: Row(children: [
        Expanded(
          child: CustomButton(
            leadingIcon: Icon(
              Icons.open_in_new_rounded,
              color: Colors.red[300],
              size: context.height / CustomStyle.m,
            ),
            backgroundColor: Colors.red[100],
            onTapped: () {},
            text: "visit_website".tr,
            textColor: Colors.red[300],
          ),
        ),
        if (GlobalStorageService.appUse == AppUsingType.user) ...[
          SizedBox(width: context.width / 32),
          Expanded(
            child: Obx(() => CustomButton(
                  leadingIcon:
                      _controller.aboutState.company.isFollowed == false
                          ? Icon(
                              Icons.add_rounded,
                              color: Colors.red[300],
                              size: context.height / CustomStyle.m,
                            )
                          : null,
                  backgroundColor:
                      _controller.aboutState.company.isFollowed == true
                          ? Jobstopcolor.secondary.withOpacity(0.8)
                          : Colors.red[100],
                  onTapped: () async {
                    print("hello world");
                    _controller.onToggleSubmitted();
                  },
                  text: _controller.aboutState.company.isFollowed == true
                      ? "followed".tr
                      : "follow".tr,
                  textColor: _controller.aboutState.company.isFollowed == true
                      ? Colors.white
                      : Colors.red[300],
                )),
          )
        ]
      ]),
    );
  }

  Widget _buildTopHeaderCompanyInfo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: context.fromWidth(CustomStyle.paddingValue)),
      child: Column(
        children: [
          Obx(() => Text(
                _controller.aboutState.company.name ?? "",
                style: dmsbold.copyWith(
                  fontSize: FontSize.title2(context),
                  color: Jobstopcolor.primarycolor,
                ),
                overflow: TextOverflow.clip,
              )),
          SizedBox(height: context.fromHeight(CustomStyle.huge2)),
          _buildTopInfoJobText(
            context,
            'work_place'.tr,
            _controller.aboutState.company.locations
                    ?.map((e) => e.address)
                    .join(", ") ??
                "",
          ),
          SizedBox(height: context.fromHeight(CustomStyle.huge2)),
          _buildTopInfoJobText(
            context,
            'invented_date'.tr,
            _controller.aboutState.company.establishmentDate ?? "",
          ),
        ],
      ),
    );
  }

  Widget _buildTopInfoJobText(
    BuildContext context,
    String label,
    String content,
  ) {
    return content.trim().isNotEmpty
        ? SizedBox(
            width: context.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  label,
                  style: dmsregular.copyWith(
                    fontSize: FontSize.title5(context),
                    color: Jobstopcolor.primarycolor,
                  ),
                  overflow: TextOverflow.clip,
                ),
                SizedBox(width: context.fromWidth(CustomStyle.xxxl)),
                Expanded(
                  child: AutoSizeText(
                    content,
                    style: dmsmedium.copyWith(
                      fontSize: FontSize.title5(context),
                      color: Jobstopcolor.primarycolor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}

class CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final void Function()? onLeadingTap;
  final void Function()? onPopPubMenuTap;

  // final List<Widget> actions;

  CustomSliverAppBarDelegate({
    required this.expandedHeight,
    this.onLeadingTap,
    this.onPopPubMenuTap,
    // this.actions = const [],
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Stack(
      children: [
        TopJobDetailsHeader(
          coverHeight: expandedHeight,
          profileImageSize: context.height / 7,
          imageOffsetDivider: 1.5,
          shrinkOffset: shrinkOffset,
          backgroundImageColor: Colors.white,
          imageUrl: SippoJobDescription.imgUrl,
          // onLeadingTap: () => Get.back(),
        ),
        if (shrinkOffset > minExtent)
          Container(
            width: context.width,
            height: expandedHeight,
            color: Jobstopcolor.backgroudHome,
          ),
        Positioned(
          top: 0,
          child: SafeArea(
            top: shrinkOffset > minExtent,
            child: Container(
              color: shrinkOffset <= minExtent
                  ? Colors.transparent
                  : Jobstopcolor.backgroudHome,
              width: context.width,
              height: kToolbarHeight +
                  (shrinkOffset <= minExtent
                      ? MediaQuery.of(context).viewPadding.top
                      : 0.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: onLeadingTap,
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: shrinkOffset <= minExtent
                          ? Colors.white
                          : Colors.black87,
                    ),
                  ),
                  // if (actions.isNotEmpty) ...[
                  Spacer(),
                  IconButton(
                    onPressed: onPopPubMenuTap,
                    icon: Icon(
                      Icons.more_vert,
                      color: shrinkOffset <= minExtent
                          ? Colors.white
                          : Colors.black87,
                    ),
                  ),
                  // ...actions,
                  // ]
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight * 1.5;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) =>
      oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != minExtent;
}