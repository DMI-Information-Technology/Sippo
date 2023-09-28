import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/JopController/user_core_functions/apply_company_controller.dart';
import 'package:jobspot/sippo_custom_widget/resume_card_widget.dart';
import 'package:jobspot/sippo_pages/sippo_user_pages/sippo_job_description/sippo_job_description.dart';

import '../../../JobGlobalclass/jobstopimges.dart';
import '../../../JobGlobalclass/routes.dart';
import '../../../JobGlobalclass/sippo_customstyle.dart';
import '../../../JopController/ConnectivityController/internet_connection_controller.dart';
import '../../../sippo_custom_widget/ConditionalWidget.dart';
import '../../../sippo_custom_widget/body_widget.dart';
import '../../../sippo_custom_widget/error_messages_dialog_snackbar/network_connnection_lost_widget.dart';
import '../../../sippo_custom_widget/file_upload_widget.dart';
import '../../../sippo_custom_widget/loading_view_widgets/loading_scaffold.dart';
import '../../../sippo_custom_widget/success_message_widget.dart';
import '../../../sippo_custom_widget/top_job_details_header.dart';
import '../../../sippo_custom_widget/widgets.dart';

class SippoApplyCompany extends StatefulWidget {
  const SippoApplyCompany({Key? key}) : super(key: key);

  @override
  State<SippoApplyCompany> createState() => _SippoApplyCompanyState();
}

class _SippoApplyCompanyState extends State<SippoApplyCompany> {
  // final _controller = ApplyJobsController.instance;
  final LoadingOverlayController loadingController = LoadingOverlayController();
  final _controller = ApplyCompanyController.instance;

  @override
  void dispose() {
    loadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScaffold(
      appBar: AppBar(
        backgroundColor: Jobstopcolor.backgroudHome,
      ),
      extendBodyBehindAppBar: true,
      controller: loadingController,
      body: BodyWidget(
        isScrollable: true,
        isTopScrollable: true,
        paddingContent: EdgeInsets.only(
          top: context.fromHeight(CustomStyle.xxl),
          right: context.fromWidth(CustomStyle.xs),
          left: context.fromWidth(CustomStyle.xs),
        ),
        connectionStatusBar: Obx(() => ConditionalWidget(
              !InternetConnectionController.instance.isConnected,
              guaranteedBuilder: (_, __) =>
                  NetworkStatusNonWidget(color: Colors.black54),
            )),
        topScreen: _buildTopJobDetailsHeader(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => ConditionalWidget(
                  _controller.states.isSuccess,
                  data: _controller.states,
                  guaranteedBuilder: (context, data) =>
                      CardNotifyMessage.success(
                    state: data,
                    onCancelTap: () => _controller.changeStates(
                      isSuccess: false,
                      message: '',
                    ),
                  ),
                )),
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
                  _controller.applyCompanyState.hasApplied,
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
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    return Obx(() => _controller.applyCompanyState.hasApplied
        ? Column(
            children: [
              CustomButton(
                onTapped: () {},
                text: "Find Another Job".tr,
                backgroundColor: Jobstopcolor.lightprimary,
                textColor: Jobstopcolor.primarycolor,
              ),
              SizedBox(height: height / CustomStyle.xxl),
              CustomButton(
                onTapped: () {
                  Get.until((route) {
                    return Get.currentRoute == SippoRoutes.userdashboard;
                  });
                },
                text: "Back to home".tr,
              ),
            ],
          )
        : CustomButton(
            onTapped: () {
              _controller.onApplySubmitted();
              // if (_controller.states.isSuccess) {
              //   Get.to(() => const JobSuccess());
              // }
            },
            text: 'Apply Now'.tr,
          ));
  }

  Widget _buildApplyFormData(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Upload CV".tr,
          style: dmsbold.copyWith(
            fontSize: FontSize.title5(context),
            color: Jobstopcolor.primarycolor,
          ),
        ),
        SizedBox(height: context.fromHeight(CustomStyle.huge)),
        Text(
          "Add your CV/Resume to apply for a job".tr,
          style: dmsregular.copyWith(
            fontSize: FontSize.paragraph3(context),
            color: Jobstopcolor.darkgrey,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: context.fromHeight(CustomStyle.xxl)),
        Obx(
          () => FileUploadWidget(
            // isJobApplied: true,
            cvCardWidget: CvCardWidget(fileCv: _controller.applyCompanyState.cvCompanyApply),
            title: 'Upload your CV',
            onUploadTapped: () async {
              loadingController.loading = true;
              await _controller.uploadCvFile();
              loadingController.loading = false;
            },
            onDeletedFile: () async {
              await _controller.removeCvFile();
            },
            isUploaded: !_controller.applyCompanyState.isCvCompanyApplyNull,
          ),
        ),
        SizedBox(height: context.fromHeight(CustomStyle.xxl)),
        Text(
          "Informations".tr,
          style: dmsbold.copyWith(fontSize: FontSize.title5(context)),
        ),
        SizedBox(height: context.fromHeight(CustomStyle.xxl)),
        InputBorderedField(
          controller: _controller.applyCompanyState.description,
          hintText: "Explain why you are the right person for this company".tr,
          maxLine: 5,
          verticalPaddingValue: context.fromWidth(
            CustomStyle.paddingValue,
          ),
        )
      ],
    );
  }

  Widget _buildHasAppliedJobsState(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          JobstopPngImg.done,
          height: height / 8,
        ),
        SizedBox(height: height / 36),
        Text(
          "You Applied has been sent".tr,
          style: dmsbold.copyWith(fontSize: 16, color: Jobstopcolor.darkgrey),
        ),
      ],
    );
  }

  Widget _buildTopJobDetailsHeader(BuildContext context) {
    return Obx(() => Column(
          children: [
            TopJobDetailsHeader(
              isConnectionLost:
                  !InternetConnectionController.instance.isConnected,
              coverHeight: context.height / 3.5,
              profileImageSize: context.height / 6,
              backgroundImageColor: Colors.white,
              imageUrl: SippoJobDescription.imgUrl,
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
                _controller.applyCompanyState.company.name ?? '',
                style: dmsbold.copyWith(
                  fontSize: FontSize.title2(context),
                  color: Jobstopcolor.primarycolor,
                ),
                overflow: TextOverflow.clip,
              )),
          Obx(() => _buildTopInfoJobText(
                context,
                'Work place',
                _controller.applyCompanyState.company.city ?? '',
              )),
          Obx(() => _buildTopInfoJobText(
                context,
                'Invented Date',
                _controller.applyCompanyState.company.establishmentDate ?? "",
              )),
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
                SizedBox(height: context.fromHeight(CustomStyle.huge2)),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
