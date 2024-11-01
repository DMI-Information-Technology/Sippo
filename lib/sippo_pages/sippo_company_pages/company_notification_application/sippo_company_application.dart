import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/JobGlobalclass/jobstopimges.dart';
import 'package:sippo/JobGlobalclass/media_query_sizes.dart';
import 'package:sippo/JobGlobalclass/sippo_customstyle.dart';
import 'package:sippo/JobGlobalclass/text_font_size.dart';
import 'package:sippo/JobServices/shared_global_data_service.dart';
import 'package:sippo/sippo_controller/NotificationController/company_notification_application/company_application_controller.dart';
import 'package:sippo/sippo_custom_widget/company_post_widget.dart';
import 'package:sippo/sippo_custom_widget/container_bottom_sheet_widget.dart';
import 'package:sippo/sippo_custom_widget/error_messages_dialog_snackbar/error_messages.dart';
import 'package:sippo/sippo_custom_widget/setting_item_widget.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';
import 'package:sippo/sippo_data/model/application_model/application_job_company_model.dart';
import 'package:sippo/sippo_data/model/notification/job_application_model.dart';
import 'package:sippo/sippo_pages/sippo_message_pages/no_items_found_message.dart';
import 'package:lottie/lottie.dart';

class SippoCompanyApplication extends StatefulWidget {
  const SippoCompanyApplication({super.key});

  @override
  State<SippoCompanyApplication> createState() =>
      _SippoCompanyApplicationState();
}

class _SippoCompanyApplicationState extends State<SippoCompanyApplication> {
  final _controller = Get.put(CompanyApplicationController());

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => _controller.refreshPage(),
      child: PagedListView<int, ApplicationCompanyModel>.separated(
        padding: EdgeInsets.symmetric(
          vertical: context.fromHeight(CustomStyle.paddingValue),
          horizontal: context.fromWidth(CustomStyle.paddingValue),
        ),
        pagingController: _controller.pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          firstPageErrorIndicatorBuilder: (context) =>
              _buildErrorFirstLoad(context),
          newPageErrorIndicatorBuilder: (context) =>
              _buildErrorNewLoad(context),
          noItemsFoundIndicatorBuilder: (context) =>
              NoItemsFoundMessageWidget.application(),
          firstPageProgressIndicatorBuilder: (context) => Center(
            child: Lottie.asset(
              JobstopPngImg.loadingProgress,
              height: context.height / 6,
            ),
          ),
          itemBuilder: (context, item, index) {
            print(item.cv);
            final company =
                _controller.notificationApplicationController.company;
            return PostApplicationWidget(
                isSubscribed: company.isSubscribed == true,
                onProfileImageTap: () {
                  SharedGlobalDataService.onProfileViewTap(
                    profId: item.customer?.id,
                  );
                },
                company: company,
                application: item,
                timeAgo: item.createdAt,
                onActionButtonPresses: () {
                  _openBottomJobSheetOption(
                    context,
                    item.id,
                    item.status == "Pending",
                  );
                },
                onShowCvTap: (cvUrl, [size]) {
                  print(_controller.company.isNotSubscribed);
                  if (_controller.company.isNotSubscribed) {
                    showNotSubscriptionAlert('');
                    return;
                  }
                  if (cvUrl != null)
                    _controller.openFile(cvUrl, size);
                  else
                    showCustomSnackBar('no_cv_title'.tr, 'no_cv_message'.tr);
                });
          },
        ),
        separatorBuilder: (_, __) => SizedBox(
          height: context.fromHeight(CustomStyle.spaceBetween),
        ),
      ),
    );
  }

  Widget _buildErrorNewLoad(BuildContext context) {
    final notificationApplicationController =
        _controller.notificationApplicationController;
    return InkWell(
      onTap: () {
        notificationApplicationController.changeStates(
          isError: false,
          message: '',
        );
        _controller.retryLastFieldRequest();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${_controller.states.message}',
            textAlign: TextAlign.center,
            style: dmsregular.copyWith(
              fontSize: FontSize.paragraph3(context),
              color: SippoColor.primarycolor,
            ),
          ),
          Icon(
            Icons.refresh,
            color: SippoColor.primarycolor,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorFirstLoad(BuildContext context) {
    final notificationApplicationController =
        _controller.notificationApplicationController;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "error".tr,
          style: dmsbold.copyWith(
            color: SippoColor.primarycolor,
            fontSize: FontSize.title2(context),
          ),
        ),
        SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
        Text(
          _controller.states.message ?? 'something_wrong_happened'.tr,
          style: dmsregular.copyWith(
            fontSize: FontSize.paragraph3(context),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
        SizedBox(
          width: context.fromWidth(CustomStyle.overBy3),
          height: context.fromHeight(12),
          child: CustomButton(
            onTapped: () {
              _controller.refreshPage();
              notificationApplicationController.changeStates(
                isError: false,
                message: '',
              );
            },
            text: 'try_again'.tr,
          ),
        )
      ],
    );
  }

  void _openBottomJobSheetOption(
    BuildContext context,
    int? applicationId, [
    bool? isPending,
  ]) {
    Get.bottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      ContainerBottomSheetWidget.statefulBuilder(
        builder: (context, setState) => Column(
          children: [
            SettingItemWidget(
              title: 'application_status'.tr,
              icon: Icon(Icons.confirmation_number_outlined),
              onTap: () async {
                Get.back();
                if (isPending == true) {
                  _showConfirmDeleteDialog(context, applicationId);
                } else if (isPending == false) {
                  Get.snackbar(
                    'application_status'.tr,
                    'application_status_desc_dialog'.tr,
                    backgroundColor: SippoColor.backgroudHome,
                    boxShadows: [boxShadow],
                  );
                }
              },
              isHavingTrailingIcon: false,
              isBordered: false,
              contentPadding: context.fromWidth(CustomStyle.xs),
              isSelected: false,
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmDeleteDialog(BuildContext context, int? ApplicationId) {
    Get.dialog(
      CustomAlertDialog(
        title: 'application_status'.tr,
        description: 'application_ask_status_dialog'.tr,
        confirmBtnTitle: 'accepted'.tr,
        onConfirm: () async {
          Get.back();
          if (_controller.company.isNotSubscribed) {
            showNotSubscriptionAlert('');
            return;
          }
          await _controller.onUpdateStatusApplicationSubmitted(
            ApplicationStatusType.Accepted,
            ApplicationId,
          );
        },
        cancelBtnTitle: 'rejected'.tr,
        onCancel: () async {
          Get.back();
          await _controller.onUpdateStatusApplicationSubmitted(
            ApplicationStatusType.Rejected,
            ApplicationId,
          );
        },
      ),
    );
  }
}
