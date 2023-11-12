import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/global_storage.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/sippo_controller/JobDescriptionController/job_description_controller.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/list_item_text.dart';
import 'package:jobspot/sippo_custom_widget/top_description_info_company.dart';
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
  final gallery = const [JobstopPngImg.gallery1, JobstopPngImg.gallery2];
  final _controller = JobCompanyDetailsController.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Obx(() {
          final isHeightOverAppBar =
              _controller.jobDetailsState.isHeightOverAppBar;
          return AppBar(
            // toolbarHeight: 0,
            notificationPredicate: (notification) {
              if (notification.metrics.pixels > kToolbarHeight) {
                _controller.jobDetailsState.isHeightOverAppBar = true;
              } else {
                _controller.jobDetailsState.isHeightOverAppBar = false;
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
            backgroundColor: isHeightOverAppBar
                ? SippoColor.backgroudHome
                : Colors.transparent,
          );
        }),
      ),
      body: BodyWidget(
        isScrollable: true,
        isTopScrollable: true,
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
                () {
                  final isSaved =
                      _controller.jobDetailsState.jopDetails.isSaved == true;
                  return [
                    BottomCompanyDetailsButtons(
                      onApplyClicked: _controller.applyTapped,
                      onFavClicked: () => _controller.onToggleSavedJobs(),
                      isSaved: isSaved,
                    ),
                    CustomButton(
                      onTapped: _controller.applyTapped,
                      text: "apply_now".tr,
                    ),
                  ][_controller.jobDetailsState.selectedPageView];
                },
              )
            : null,
      ),
    );
  }

  Widget _buildTopJobDetailsHeader(BuildContext context) {
    return Obx(() => Column(
          children: [
            TopJobDetailsHeader(
              coverHeight: context.height / 4.5,
              profileImageSize: context.height / 8,
              backgroundImageColor: SippoColor.white,
              imageUrl: _controller
                  .jobDetailsState.jopDetails.company?.profileImage?.url,
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
                  color: SippoColor.secondary,
                ),
                overflow: TextOverflow.clip,
              )),
          SizedBox(
            height: context.fromHeight(CustomStyle.xxxl),
          ),
          Obx(() {
            final job = _controller.jobDetailsState.jopDetails;
            return TopDescriptionInfoCompanyWidget(
              startText: job.company?.name,
              middleText: job.locationAddress?.name,
              endText: job.createdAt != null
                  ? calculateElapsedTimeFromStringDate(job.createdAt ?? "")
                  : null,
            );
          }),
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
    final job = _controller.jobDetailsState.jopDetails;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Job_Description".tr,
          style: dmsbold.copyWith(fontSize: FontSize.title4(context)),
        ),
        SizedBox(height: height / 76),
        Text(
          job.description ?? '',
          style: dmsregular.copyWith(
            fontSize: FontSize.paragraph3(context),
            color: SippoColor.darkgrey,
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
          text: job.requirements,
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
          job.company?.city ?? "",
          style:
              dmsregular.copyWith(fontSize: 12, color: SippoColor.darkgrey),
        ),
        SizedBox(
          height: height / 256,
        ),
        InkWell(
          onTap: () {
            final lat = job.latitude;
            final lon = job.longitude;
            if (lat != null && lon != null) lunchMapWithLocation(lat, lon);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on_outlined,
                color: SippoColor.primarycolor,
                size: context.fromHeight(CustomStyle.xxl),
              ),
              AutoSizeText(
                job.locationAddress?.name ?? '',
                style: dmsmedium.copyWith(
                  color: SippoColor.primarycolor,
                  decoration: TextDecoration.underline,
                  decorationColor: SippoColor.primarycolor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: height / 36,
        ),
        AutoSizeText(
          "title_detailed_information".tr,
          style: dmsbold.copyWith(fontSize: FontSize.title4(context)),
        ),
        SizedBox(
          height: height / 64,
        ),
        TextBoldedLabelItem(
          label: "Specialization".tr,
          text: job.specialization?.name ?? "",
        ),
        TextBoldedLabelItem(
          label: "experienceLevels".tr,
          text: job.experienceLevel?.label ?? "",
        ),
        TextBoldedLabelItem(
          label: "employment_type_title".tr,
          text: job.employmentType ?? "",
        ),
        TextBoldedLabelItem(
          label: "title_workplace_type".tr,
          text: job.workplaceType ?? '',
        ),
        TextBoldedLabelItem(
          label: "Salary".tr,
          text: job.salaryRange.salaryStringFormat,
        ),
      ],
    );
  }
}

class TextBoldedLabelItem extends StatelessWidget {
  const TextBoldedLabelItem({
    super.key,
    required this.label,
    required this.text,
    this.padding,
    this.spacing,
  });

  final String label;
  final String text;
  final EdgeInsets? padding;
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          EdgeInsets.only(
            bottom: context.fromHeight(CustomStyle.xxxl),
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            label,
            style: dmsbold.copyWith(
              fontSize: FontSize.title5(context),
              color: SippoColor.primarycolor,
            ),
          ),
          SizedBox(
            height: spacing ?? context.fromHeight(CustomStyle.huge3),
          ),
          AutoSizeText(
            text,
            style: dmsmedium.copyWith(
              fontSize: FontSize.title6(context),
              color: SippoColor.darkgrey,
            ),
          ),
        ],
      ),
    );
  }
}

class BottomCompanyDetailsButtons extends StatelessWidget {
  const BottomCompanyDetailsButtons({
    super.key,
    this.onFavClicked,
    this.isSaved = false,
    required this.onApplyClicked,
  });

  final void Function()? onFavClicked;
  final void Function() onApplyClicked;
  final bool isSaved;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: onFavClicked,
          child: Padding(
            padding: EdgeInsets.all(
              context.fromWidth(CustomStyle.xxxl),
            ),
            child: Icon(
              isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
              color: isSaved ? Colors.yellow : SippoColor.secondary,
              size: height / 21,
            ),
          ),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            backgroundColor: Colors.white,
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
