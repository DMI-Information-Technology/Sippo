import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/global_storage.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/JopController/JobDescriptionController/job_description_controller.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/list_item_text.dart';
import 'package:jobspot/sippo_custom_widget/top_job_details_header.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/sippo_pages/sippo_abouts_companies/show_about_companies_details.dart';
import 'package:jobspot/utils/app_use.dart';
import 'package:jobspot/utils/helper.dart';

class SippoJobDescription extends StatefulWidget {
  const SippoJobDescription({Key? key}) : super(key: key);

  @override
  State<SippoJobDescription> createState() => _SippoJobDescriptionState();
}

class _SippoJobDescriptionState extends State<SippoJobDescription> {
  final gallery = [JobstopPngImg.gallery1, JobstopPngImg.gallery2];
  final _controller = JobCompanyDetailsController.instance;

  final bottomButtonScreen = [
    BottomCompanyDetailsButtons(
      onApplyClicked: () => Get.toNamed(SippoRoutes.userApplyJobs),
    ),
    CustomButton(
      onTapped: () => Get.toNamed(SippoRoutes.userApplyJobs),
      text: "Apply Now".tr,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: BodyWidget(
        isScrollable: true,
        isTopScrollable: true,
        // connectionStatusBar: Obx(() => ConditionalWidget(
        //       !InternetConnectionService.instance.isConnected,
        //       guaranteedBuilder: (_, __) => NetworkStatusNonWidget(
        //         color: Colors.black54,
        //       ),
        //     )),
        paddingContent: EdgeInsets.only(
          top: context.fromHeight(CustomStyle.paddingValue),
          right: context.fromWidth(CustomStyle.paddingValue),
          left: context.fromWidth(CustomStyle.paddingValue),
        ),
        topScreen: _buildTopJobDetailsHeader(context),
        child: Column(
          children: [
            _buildButtonTaps(context),
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
            Obx(
              () => _controller.jobDetailsState.selectedPageView == 0
                  ? _buildJobDetails(context)
                  : ShowAboutCompaniesDetails(
                      company: _controller.jobDetailsState.jopDetails.company,
                    ),
            ),
          ],
        ),
        paddingBottom:
            EdgeInsets.all(context.fromWidth(CustomStyle.paddingValue)),
        bottomScreen: GlobalStorageService.appUse == AppUsingType.user
            ? Obx(
                () => bottomButtonScreen[
                    _controller.jobDetailsState.selectedPageView],
              )
            : null,
      ),
    );
  }

  Widget _buildTopJobDetailsHeader(BuildContext context) {
    return Obx(() => Column(
          children: [
            TopJobDetailsHeader(
              // isConnectionLost: !InternetConnectionService.instance.isConnected,
              coverHeight: context.height / 4.5,
              profileImageSize: context.height / 8,
              backgroundImageColor: Jobstopcolor.white,
              imageUrl: _controller
                  .jobDetailsState.jopDetails.company?.profileImage?.url,
              // onLeadingTap: () => Get.back(),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: context.height / CustomStyle.spaceBetween),
            _buildTopJobInfo(context),
          ],
        ));
  }

  Widget _buildTopJobInfo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: context.fromWidth(CustomStyle.paddingValue)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() => Text(
                _controller.jobDetailsState.jopDetails.title ?? '',
                style: dmsbold.copyWith(
                  fontSize: FontSize.title2(context),
                  color: Jobstopcolor.secondary,
                ),
                overflow: TextOverflow.clip,
              )),
          SizedBox(
            height: context.fromHeight(CustomStyle.xxxl),
          ),
          FittedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //   SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
                Obx(() => _buildTopInfoJobText(
                      context,
                      //'Company name',
                      _controller.jobDetailsState.jopDetails.company?.name ??
                          '',
                    )),
                Container(
                  width: 10,
                  height: 10,
                  decoration: ShapeDecoration(
                    color: Jobstopcolor.primarycolor,
                    shape: OvalBorder(),
                  ),
                ),
                SizedBox(width: context.fromWidth(CustomStyle.xxxl)),
                Obx(() => _buildTopInfoJobText(
                      context,
                      //'Work place',
                      _controller.jobDetailsState.jopDetails.company?.city ??
                          '',
                    )),
                //  SizedBox(height: context.fromHeight(CustomStyle.huge2)),
                Container(
                  width: 10,
                  height: 10,
                  decoration: ShapeDecoration(
                    color: Jobstopcolor.primarycolor,
                    shape: OvalBorder(),
                  ),
                ),
                SizedBox(width: context.fromWidth(CustomStyle.xxxl)),
                Obx(() {
                  final createAt =
                      _controller.jobDetailsState.jopDetails.createdAt;
                  return createAt != null && createAt.isNotEmpty
                      ? _buildTopInfoJobText(
                          context,
                          // 'Publish time',
                          calculateElapsedTimeFromStringDate(
                                _controller
                                        .jobDetailsState.jopDetails.createdAt ??
                                    '',
                              ) ??
                              "",
                        )
                      : const SizedBox.shrink();
                }),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTopInfoJobText(
    BuildContext context,
    // String label,
    String content,
  ) {
    return SizedBox(
      width: context.width / 3,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // AutoSizeText(
          //   label,
          //   style: dmsregular.copyWith(
          //     fontSize: FontSize.title5(context),
          //     color: Jobstopcolor.primarycolor,
          //   ),
          //   overflow: TextOverflow.clip,
          // ),
          //SizedBox(width: context.fromWidth(CustomStyle.xxxl)),
          Expanded(
            child: AutoSizeText(
              content,
              style: dmsmedium.copyWith(
                fontSize: FontSize.title5(context),
                color: Jobstopcolor.secondary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonTaps(BuildContext) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(
          () => SizedBox(
            width: width / 2.3,
            child: CustomButton(
              borderRadiusValue: 12,
              onTapped: () {
                _controller.jobDetailsState.switchPageView();
              },
              text: "description".tr,
              backgroundColor:
                  _controller.jobDetailsState.changeDescriptionButtonColor(),
            ),
          ),
        ),
        Obx(
          () => SizedBox(
            width: width / 2.3,
            child: CustomButton(
              borderRadiusValue: 12,
              onTapped: () {
                _controller.jobDetailsState.switchPageView();
              },
              text: "company".tr,
              backgroundColor:
                  _controller.jobDetailsState.changeCompanyButtonColor(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildJobDetails(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Job_Description".tr,
          style: dmsbold.copyWith(fontSize: FontSize.title4(context)),
        ),
        SizedBox(height: height / 76),
        Text(
          _controller.jobDetailsState.jopDetails.description ?? '',
          style: dmsregular.copyWith(
            fontSize: FontSize.paragraph3(context),
            color: Jobstopcolor.darkgrey,
          ),
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: height / 36),
        Text(
          "Requirements".tr,
          style: dmsbold.copyWith(fontSize: FontSize.title4(context)),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: height / 66,
        ),
        ListTextItem(
          text: _controller.jobDetailsState.jopDetails.requirements,
          startCrossAlignment: true,
        ),
        SizedBox(
          height: height / 36,
        ),
        Text(
          "Location".tr,
          style: dmsbold.copyWith(fontSize: FontSize.title4(context)),
        ),
        Text(
          _controller.jobDetailsState.jopDetails.company?.city ?? "",
          style:
              dmsregular.copyWith(fontSize: 12, color: Jobstopcolor.darkgrey),
        ),
        SizedBox(
          height: height / 66,
        ),
        Container(
          height: height / 5,
          width: width / 1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Image.asset(
            JobstopPngImg.locationmap,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          height: height / 36,
        ),
        AutoSizeText(
          "Detailed Information".tr,
          style: dmsbold.copyWith(fontSize: FontSize.title4(context)),
        ),
        SizedBox(height: height / 46),
        AutoSizeText(
          "Specialization",
          style: dmsbold.copyWith(
            fontSize: FontSize.title5(context),
            color: Jobstopcolor.primarycolor,
          ),
        ),
        AutoSizeText(
          _controller.jobDetailsState.jopDetails.specialization?.name ?? "",
          style: dmsmedium.copyWith(
            fontSize: FontSize.title6(context),
            color: Jobstopcolor.darkgrey,
          ),
        ),
        SizedBox(height: height / 46),
        AutoSizeText(
          'Experience Level',
          style: dmsbold.copyWith(
            fontSize: FontSize.title5(context),
            color: Jobstopcolor.primarycolor,
          ),
        ),
        AutoSizeText(
          _controller.jobDetailsState.jopDetails.experienceLevel?.label ?? "",
          style: dmsmedium.copyWith(
            fontSize: FontSize.title6(context),
            color: Jobstopcolor.darkgrey,
          ),
        ),
        SizedBox(height: height / 46),
        AutoSizeText(
          "Employment Type",
          style: dmsbold.copyWith(
            fontSize: FontSize.title5(context),
            color: Jobstopcolor.primarycolor,
          ),
        ),
        AutoSizeText(
          _controller.jobDetailsState.jopDetails.employmentType ?? "",
          style: dmsmedium.copyWith(
            fontSize: FontSize.title6(context),
            color: Jobstopcolor.darkgrey,
          ),
        ),
        SizedBox(height: height / 46),
        AutoSizeText(
          "Workplace Type",
          style: dmsbold.copyWith(
            fontSize: FontSize.title5(context),
            color: Jobstopcolor.primarycolor,
          ),
        ),
        AutoSizeText(
          _controller.jobDetailsState.jopDetails.workplaceType ?? "",
          style: dmsmedium.copyWith(
            fontSize: FontSize.title6(context),
            color: Jobstopcolor.darkgrey,
          ),
        ),
        SizedBox(height: height / 46),
        AutoSizeText(
          "Salary",
          style: dmsbold.copyWith(
            fontSize: FontSize.title5(context),
            color: Jobstopcolor.primarycolor,
          ),
        ),
        AutoSizeText(
          _controller.jobDetailsState.jopDetails.salaryRange.salaryStringFormat,
          style: dmsmedium.copyWith(
            fontSize: FontSize.title6(context),
            color: Jobstopcolor.darkgrey,
          ),
        ),
      ],
    );
  }
}

class BottomCompanyDetailsButtons extends StatelessWidget {
  const BottomCompanyDetailsButtons({
    super.key,
    this.onFavClicked,
    required this.onApplyClicked,
  });

  final void Function()? onFavClicked;
  final void Function() onApplyClicked;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: height / 15,
          width: height / 15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Jobstopcolor.white,
            boxShadow: const [
              BoxShadow(
                blurRadius: 5,
                color: Jobstopcolor.shedo,
              )
            ],
          ),
          child: InkWell(
            onTap: onFavClicked,
            child: Padding(
              padding: EdgeInsets.all(width / 28),
              child: Image.asset(
                JobstopPngImg.order,
                color: Jobstopcolor.secondary,
              ),
            ),
          ),
        ),
        SizedBox(width: width / 36),
        Flexible(
          child: CustomButton(
            onTapped: () => onApplyClicked(),
            text: "Apply Now".tr,
          ),
        ),
      ],
    );
  }
}
