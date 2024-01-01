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
import 'package:sippo/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:sippo/custom_app_controller/switch_status_controller.dart';
import 'package:sippo/sippo_controller/user_core_functions/apply_company_controller.dart';
import 'package:sippo/sippo_custom_widget/ConditionalWidget.dart';
import 'package:sippo/sippo_custom_widget/body_widget.dart';
import 'package:sippo/sippo_custom_widget/error_messages_dialog_snackbar/network_connnection_lost_widget.dart';
import 'package:sippo/sippo_custom_widget/file_upload_widget.dart';
import 'package:sippo/sippo_custom_widget/loading_view_widgets/loading_scaffold.dart';
import 'package:sippo/sippo_custom_widget/resume_card_widget.dart';
import 'package:sippo/sippo_custom_widget/success_message_widget.dart';
import 'package:sippo/sippo_custom_widget/top_job_details_header.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';
import 'package:sippo/utils/validating_input.dart';

class SippoApplyCompany extends StatefulWidget {
  const SippoApplyCompany({Key? key}) : super(key: key);

  @override
  State<SippoApplyCompany> createState() => _SippoApplyCompanyState();
}

class _SippoApplyCompanyState extends State<SippoApplyCompany> {
  // final _controller = ApplyJobsController.instance;
  final loadingController = SwitchStatusController();
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
        backgroundColor: SippoColor.backgroudHome,
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
              !InternetConnectionService.instance.isConnected,
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
              // if (_controller.states.isSuccess) {
              //   Get.to(() => const JobSuccess());
              // }
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
                fileCv: _controller.applyCompanyState.cvCompanyApply),
            title: 'upload_your_cv'.tr,
            onUploadTapped: () async {
              loadingController.status = true;
              await _controller.uploadCvFile();
              loadingController.status = false;
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
          maxLength: 256,
          showCounter: true,
          controller: _controller.applyCompanyState.description,
          hintText: "company_apply_desc".tr,
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
              isConnectionLost: !InternetConnectionService.instance.isConnected,
              coverHeight: context.height / 3.5,
              profileImageSize: context.height / 6,
              backgroundImageColor: Colors.white,
              imageUrl:
                  _controller.applyCompanyState.company.profileImage?.url ?? '',
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
                  color: SippoColor.primarycolor,
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
                'invented_date',
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
                    color: SippoColor.primarycolor,
                  ),
                  overflow: TextOverflow.clip,
                ),
                SizedBox(width: context.fromWidth(CustomStyle.xxxl)),
                Expanded(
                  child: AutoSizeText(
                    content,
                    style: dmsmedium.copyWith(
                      fontSize: FontSize.title5(context),
                      color: SippoColor.primarycolor,
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
