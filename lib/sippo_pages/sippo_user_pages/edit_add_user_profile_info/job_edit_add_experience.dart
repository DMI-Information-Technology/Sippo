import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/utils/validating_input.dart';

import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/sippo_controller/user_profile_controller/edit_add_work_experience_controller.dart';
import 'package:jobspot/sippo_custom_widget/confirmation_bottom_sheet.dart';
import 'package:jobspot/sippo_custom_widget/container_bottom_sheet_widget.dart';
import 'package:jobspot/sippo_custom_widget/loading_empty_feild_widget.dart';
import 'package:jobspot/sippo_custom_widget/success_message_widget.dart';
import 'package:jobspot/utils/helper.dart' as helper;

class JobExperiences extends StatelessWidget {
  const JobExperiences({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = EditAddWorkExperienceController.instance;
    return Scaffold(
      appBar: AppBar(),
      body: BodyWidget(
        isScrollable: true,
        paddingContent: EdgeInsets.symmetric(
          horizontal: context.fromWidth(CustomStyle.paddingValue),
        ),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => AutoSizeText(
                  "${controller.isEditing ? "change".tr : "Add".tr} " +
                      "work_experience".tr,
                  style: dmsbold.copyWith(
                    fontSize: FontSize.title3(context),
                    color: Jobstopcolor.primarycolor,
                  ),
                ),
              ),
              SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
              _buildSuccessMessage(), // All Success Messages Possible
              _buildWarningMessage(), // All Warning Messages Possible
              _buildLabelText(context, "job_title".tr),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              _buildJobTitleInput(context),
              SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
              _buildLabelText(context, "company".tr),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              _buildCompanyNameInput(context),
              SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabelText(context, "start_date".tr),
                      SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
                      _buildStartDateInput(context),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabelText(context, "end_date".tr),
                      SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
                      _buildEndDateInput(context),
                    ],
                  ),
                ],
              ),
              SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
              Row(
                children: [
                  _buildIsCurrentJobCheckBox(context),
                  SizedBox(width: context.fromWidth(CustomStyle.xs)),
                  AutoSizeText(
                    "this_is_my_pos".tr,
                    style: dmsregular.copyWith(
                      fontSize: FontSize.paragraph3(context),
                      color: Jobstopcolor.darkgrey,
                    ),
                  )
                ],
              ),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              _buildLabelText(context, "description".tr),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              _buildDescriptionInput(context),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
            ],
          ),
        ),
        paddingBottom:
            EdgeInsets.all(context.fromWidth(CustomStyle.paddingValue)),
        bottomScreen: _buildBottomButtonsRow(context),
      ),
    );
  }

  Widget _buildLabelText(BuildContext context, String text) {
    return AutoSizeText(
      text,
      style: dmsbold.copyWith(
        fontSize: FontSize.label(context),
        color: Jobstopcolor.primarycolor,
      ),
    );
  }

  Widget _buildSuccessMessage() {
    final controller = EditAddWorkExperienceController.instance;
    return Obx(
      () => controller.states.isSuccess
          ? CardNotifyMessage(
              controller.states.message ?? '',
              onCancelTap: () => controller.successState(false),
              messageType: MessageType.SUCCESS,
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildWarningMessage() {
    final controller = EditAddWorkExperienceController.instance;
    return Obx(
      () {
        return controller.states.isWarning
            ? CardNotifyMessage(
                controller.states.message ?? '',
                onCancelTap: () => controller.warningState(false),
                messageType: MessageType.WARNING,
              )
            : const SizedBox.shrink();
      },
    );
  }

  Widget _buildDescriptionInput(BuildContext context) {
    final controller = EditAddWorkExperienceController.instance;
    final workExState = controller.workExState;
    return InputBorderedField(
      verticalPaddingValue: context.fromHeight(
        CustomStyle.paddingValue,
      ),
      gController: workExState.description,
      height: context.height / 5,
      hintText: "additional_information".tr,
      hintStyle: dmsregular.copyWith(
        fontSize: FontSize.label(context),
        color: Jobstopcolor.grey,
      ),
      keyboardType: TextInputType.multiline,
      maxLine: 5,
      validator: (value) => ValidatingInput.validateDescription(value?.trim()),
    );
  }

  Widget _buildIsCurrentJobCheckBox(BuildContext context) {
    final controller = EditAddWorkExperienceController.instance;
    return Obx(
      () => InkWell(
        onTap: () {
          controller.workExState.isCurrentJob =
              !controller.workExState.isCurrentJob;
        },
        child: Container(
          height: context.height / 30,
          width: context.height / 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Jobstopcolor.white,
            boxShadow: const [
              BoxShadow(color: Jobstopcolor.shedo, blurRadius: 5)
            ],
          ),
          child: Icon(
            Icons.check,
            size: 15,
            color: controller.workExState.isCurrentJob
                ? Jobstopcolor.primarycolor
                : Jobstopcolor.transparent,
          ),
        ),
      ),
    );
  }

  Widget _buildEndDateInput(BuildContext context) {
    final controller = EditAddWorkExperienceController.instance;
    final workExState = controller.workExState;
    return InputBorderedField(
      onTap: () {
        helper.showMyDatePicker(context, (date) {
          workExState.endDate.controller.text = helper.customDateFormatter(
            date.toString(),
            "yyyy-MM-dd",
          );
        });
      },
      readOnly: true,
      height: context.fromHeight(CustomStyle.inputBorderedSize),
      fontSize: FontSize.label(context),
      width: context.width / 2.3,
      gController: workExState.endDate,
      suffixIcon: Obx(
        () => controller.isTextLoading(workExState.endDate.isTextEmpty)
            ? const LoadingInputField()
            : const Icon(
                Icons.date_range_outlined,
                color: Jobstopcolor.primarycolor,
              ),
      ),
      validator: (value) => ValidatingInput.validateEmptyField(value),
    );
  }

  Widget _buildStartDateInput(BuildContext context) {
    final controller = EditAddWorkExperienceController.instance;
    final workExState = controller.workExState;
    return InputBorderedField(
      onTap: () {
        helper.showMyDatePicker(context, (date) {
          controller.workExState.startDate.controller.text =
              helper.customDateFormatter(date.toString(), "yyyy-MM-dd");
        });
      },
      readOnly: true,
      height: context.fromHeight(CustomStyle.inputBorderedSize),
      fontSize: FontSize.label(context),
      width: context.width / 2.3,
      gController: workExState.startDate,
      suffixIcon: Obx(
        () => controller.isTextLoading(workExState.startDate.isTextEmpty)
            ? const LoadingInputField()
            : Icon(
                Icons.date_range_outlined,
                color: Jobstopcolor.primarycolor,
              ),
      ),
      validator: (value) => ValidatingInput.validateEmptyField(value),
    );
  }

  Widget _buildCompanyNameInput(BuildContext context) {
    final controller = EditAddWorkExperienceController.instance;
    final workExState = controller.workExState;
    return InputBorderedField(
      height: context.fromHeight(CustomStyle.inputBorderedSize),
      fontSize: FontSize.label(context),
      gController: workExState.company,
      suffixIcon: Obx(
        () => controller.isTextLoading(workExState.company.isTextEmpty)
            ? const LoadingInputField()
            : const SizedBox.shrink(),
      ),
      validator: (value) => ValidatingInput.validateEmptyField(value),
    );
  }

  Widget _buildJobTitleInput(BuildContext context) {
    final controller = EditAddWorkExperienceController.instance;
    final workExState = controller.workExState;
    return InputBorderedField(
      height: context.fromHeight(CustomStyle.inputBorderedSize),
      fontSize: FontSize.label(context),
      gController: workExState.title,
      suffixIcon: Obx(
        () => controller.isTextLoading(workExState.title.isTextEmpty)
            ? const LoadingInputField()
            : const SizedBox.shrink(),
      ),
      validator: (value) => ValidatingInput.validateEmptyField(value),
    );
  }

  Row _buildBottomButtonsRow(BuildContext context) {
    final controller = EditAddWorkExperienceController.instance;
    Size size = MediaQuery.of(context).size;
    // double height = size.height;
    double width = size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(
          () => controller.isEditing
              ? SizedBox(
                  width: width / 2.3,
                  child: CustomButton(
                    onTapped: () {
                      _showremove();
                    },
                    text: "REMOVE".tr,
                    backgroundColor: Jobstopcolor.lightprimary,
                  ),
                )
              : const SizedBox.shrink(),
        ),
        Obx(
          () => SizedBox(
            width: controller.isEditing ? width / 2.3 : null,
            child: CustomButton(
              onTapped: () {
                _showSave();
              },
              text: "SAVE".tr,
              backgroundColor: Jobstopcolor.primarycolor,
            ),
          ),
        ),
      ],
    );
  }

  void _showSave() {
    final controller = EditAddWorkExperienceController.instance;
    Get.bottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      ContainerBottomSheetWidget(
        notchColor: Jobstopcolor.primarycolor,
        children: [
          ConfirmationBottomSheet(
            title: "Save Work Experience ?",
            description: "Are you sure you want to change what you entered?",
            onConfirm: () async {
              if (controller.formKey.currentState?.validate() == true) {
                await controller.onSaveSubmitted();
                Get.back();
              }
            },
            onUndo: () => Get.back(),
          )
        ],
      ),
    );
  }

  void _showremove() {
    Get.bottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      ContainerBottomSheetWidget(
        notchColor: Jobstopcolor.primarycolor,
        children: [
          ConfirmationBottomSheet(
            title: "Remove Work Experience ?",
            description: "Are you sure you want to change what you entered?",
            onConfirm: () async {
              await EditAddWorkExperienceController.instance
                  .onDeleteSubmitted();
              Get.back();
            },
            onUndo: () => Get.back(),
          )
        ],
      ),
    );
  }
}
