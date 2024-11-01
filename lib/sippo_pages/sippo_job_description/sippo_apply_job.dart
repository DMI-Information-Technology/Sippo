import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/JobGlobalclass/jobstopimges.dart';
import 'package:sippo/JobGlobalclass/media_query_sizes.dart';
import 'package:sippo/JobGlobalclass/routes.dart';
import 'package:sippo/JobGlobalclass/sippo_customstyle.dart';
import 'package:sippo/JobGlobalclass/text_font_size.dart';
import 'package:sippo/sippo_controller/user_core_functions/apply_jobs_controllers.dart';
import 'package:sippo/sippo_custom_widget/ConditionalWidget.dart';
import 'package:sippo/sippo_custom_widget/body_widget.dart';
import 'package:sippo/sippo_custom_widget/file_upload_widget.dart';
import 'package:sippo/sippo_custom_widget/loading_view_widgets/loading_scaffold.dart';
import 'package:sippo/sippo_custom_widget/resume_card_widget.dart';
import 'package:sippo/sippo_custom_widget/rounded_border_radius_card_widget.dart';
import 'package:sippo/sippo_custom_widget/success_message_widget.dart';
import 'package:sippo/sippo_custom_widget/top_description_info_company.dart';
import 'package:sippo/sippo_custom_widget/top_job_details_header.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';
import 'package:sippo/utils/helper.dart';
import 'package:sippo/utils/validating_input.dart';

class SippoApplyJob extends StatefulWidget {
  const SippoApplyJob({Key? key}) : super(key: key);

  @override
  State<SippoApplyJob> createState() => _SippoApplyJobState();
}

class _SippoApplyJobState extends State<SippoApplyJob> {
  final _controller = ApplyJobsController.instance;

  @override
  Widget build(BuildContext context) {
    return LoadingScaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Obx(() {
          final isHeightOverAppBar =
              _controller.applyJobsState.isHeightOverAppBar;
          return AppBar(
            // toolbarHeight: 0,
            notificationPredicate: (notification) {
              if (notification.metrics.pixels > kToolbarHeight) {
                _controller.applyJobsState.isHeightOverAppBar = true;
              } else {
                _controller.applyJobsState.isHeightOverAppBar = false;
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
      extendBodyBehindAppBar: true,
      controller: _controller.loadingController,
      body: BodyWidget(
        isScrollable: true,
        isTopScrollable: true,
        paddingContent: EdgeInsets.only(
          top: context.fromHeight(CustomStyle.xxl),
          right: context.fromWidth(CustomStyle.xs),
          left: context.fromWidth(CustomStyle.xs),
        ),
        topScreen: _buildTopJobDetailsHeader(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => ConditionalWidget(
                  _controller.states.isError,
                  data: _controller.states,
                  guaranteedBuilder: (_, data) => CardNotifyMessage.error(
                    state: data,
                    onCancelTap: () => _controller.changeStates(
                      isError: false,
                      message: '',
                    ),
                  ),
                )),
            Obx(() => ConditionalWidget(
                  _controller.states.isWarning,
                  data: _controller.states,
                  guaranteedBuilder: (context, data) =>
                      CardNotifyMessage.warning(
                    state: data,
                    onCancelTap: () =>
                        _controller.changeStates(isWarning: false, message: ''),
                  ),
                )),
            Obx(() => ConditionalWidget(
                  _controller.applyJobsState.hasApplied,
                  isLoading: _controller.states.isLoading,
                  guaranteedBuilder: (context, data) {
                    return _buildHasAppliedJobsState(context);
                  },
                  avoidBuilder: (context, data) {
                    return _buildApplyFormData(context);
                  },
                )),
          ],
        ),
        paddingBottom:
            EdgeInsets.all(context.fromWidth(CustomStyle.paddingValue)),
        bottomScreen: buildSubmissionButtons(context),
      ),
    );
  }

  Widget buildSubmissionButtons(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Obx(() => _controller.applyJobsState.hasApplied
        ? Column(
            children: [
              CustomButton(
                onTapped: () {
                  final id =
                      _controller.applyJobsState.jopDetails.specialization?.id;
                  Get.until((route) {
                    return Get.currentRoute == SippoRoutes.userDashboard;
                  });
                  Get.toNamed(SippoRoutes.sippoJobFilterSearch, arguments: {
                    'specialization_id': id,
                  });
                },
                text: "find_another_job".tr,
                backgroundColor: SippoColor.lightprimary,
                textColor: SippoColor.primarycolor,
              ),
              SizedBox(height: height / CustomStyle.xxl),
              CustomButton(
                onTapped: () {
                  Get.until((route) {
                    return Get.currentRoute == SippoRoutes.userDashboard;
                  });
                },
                text: "back_to_home".tr,
              ),
            ],
          )
        : CustomButton(
            onTapped: () {
              _controller.onApplySubmitted();
            },
            text: 'apply_now'.tr,
          ));
  }

  Widget _buildApplyFormData(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "upload_cv".tr,
          style: dmsbold.copyWith(
            fontSize: FontSize.title5(context),
            color: SippoColor.primarycolor,
          ),
        ),
        SizedBox(height: context.fromHeight(CustomStyle.huge)),
        Text(
          "add_cv_desc".tr,
          style: dmsregular.copyWith(
            fontSize: FontSize.paragraph3(context),
            color: SippoColor.darkgrey,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: context.fromHeight(CustomStyle.xxl)),
        Obx(
          () => FileUploadWidget(
            // isJobApplied: true,
            cvCardWidget: CvCardWidget(
              fileCv: _controller.applyJobsState.cvJobApply,
            ),
            title: 'upload_your_cv'.tr,
            onUploadTapped: _controller.uploadCvFile,
            onDeletedFile: () async {
              await _controller.removeCvFile();
            },
            isUploaded: !_controller.applyJobsState.isCvJobApplyNull,
          ),
        ),
        SizedBox(height: context.fromHeight(CustomStyle.xxl)),
        Text(
          "Informations".tr,
          style: dmsbold.copyWith(fontSize: FontSize.title5(context)),
        ),
        SizedBox(height: context.fromHeight(CustomStyle.xxl)),
        InputBorderedField(
          maxLength: 256,
          showCounter: true,
          controller: _controller.applyJobsState.description,
          hintText: "hint_text_application_description".tr,
          maxLine: 5,
          verticalPaddingValue: context.fromWidth(
            CustomStyle.paddingValue,
          ),
          validator: ValidatingInput.validateDescription,
        )
      ],
    );
  }

  Widget _buildHasAppliedJobsState(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RoundedBorderRadiusCardWidget(
          color: SippoColor.lightprimary4,
          child: CvCardWidget.fromRemote(
            remoteCv: _controller.applyJobsState.jopDetails.application?.cv,
            createAt:
                _controller.applyJobsState.jopDetails.application?.createdAt,
          ),
        ),
        Image.asset(
          JobstopPngImg.done,
          height: height / 8,
        ),
        SizedBox(height: height / 36),
        Text(
          "you_applied_sent".tr,
          style: dmsbold.copyWith(fontSize: 16, color: SippoColor.darkgrey),
        ),
      ],
    );
  }

  Widget _buildTopJobDetailsHeader(BuildContext context) {
    return Obx(() => Column(
          children: [
            TopJobDetailsHeader(
              coverHeight: context.height / 3.5,
              profileImageSize: context.height / 8,
              backgroundImageColor: Colors.white,
              imageUrl: _controller
                      .applyJobsState.jopDetails.company?.profileImage?.url ??
                  '',
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
            SizedBox(height: context.height / CustomStyle.spaceBetween),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.fromWidth(CustomStyle.paddingValue)),
              child: Divider(thickness: 2),
            ),
          ],
        ));
  }

  Widget _buildTopJobInfo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: context.fromWidth(CustomStyle.paddingValue)),
      child: Column(
        children: [
          Obx(() => Text(
                _controller.applyJobsState.jopDetails.title ?? '',
                style: dmsbold.copyWith(
                  fontSize: FontSize.title2(context),
                  color: SippoColor.secondary,
                ),
                overflow: TextOverflow.clip,
              )),
          SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
          Obx(() {
            final job = _controller.applyJobsState.jopDetails;
            return TopDescriptionInfoCompanyWidget(
              startText: job.company?.name,
              middleText: job.locationAddress?.name,
              endText: job.createdAt != null
                  ? calculateElapsedTimeFromStringDate(job.createdAt)
                  : null,
            );
          }),
        ],
      ),
    );
  }
}
