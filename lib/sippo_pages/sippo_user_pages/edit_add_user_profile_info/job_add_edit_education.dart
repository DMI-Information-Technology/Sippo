import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/sippo_controller/user_profile_controller/edit_add_education_controller.dart';
import 'package:jobspot/sippo_custom_widget/SearchDelegteImpl.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/confirmation_bottom_sheet.dart';
import 'package:jobspot/sippo_custom_widget/container_bottom_sheet_widget.dart';
import 'package:jobspot/sippo_custom_widget/loading_view_widgets/loading_scaffold.dart';
import 'package:jobspot/sippo_custom_widget/success_message_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/utils/helper.dart' as helper;
import 'package:jobspot/utils/validating_input.dart';

class JobEducationAddEdit extends StatefulWidget {
  const JobEducationAddEdit({Key? key}) : super(key: key);

  @override
  State<JobEducationAddEdit> createState() => _JobEducationAddEditState();
}

class _JobEducationAddEditState extends State<JobEducationAddEdit> {
  final _controller = EditAddEducationController.instance;

  @override
  Widget build(BuildContext context) {
    return LoadingScaffold(
      controller: _controller.loadingOverly,
      appBar: AppBar(),
      body: BodyWidget(
        isScrollable: true,
        paddingContent: EdgeInsets.symmetric(
            horizontal: context.fromWidth(CustomStyle.paddingValue)),
        child: Form(
          key: _controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => AutoSizeText(
                  "${_controller.isEditing ? "change".tr : "add".tr} ${'education'.tr}",
                  style: dmsbold.copyWith(
                      fontSize: FontSize.title3(context),
                      color: SippoColor.primarycolor),
                ),
              ),
              SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
              _buildWarningMessage(),
              _buildLabelText(context, "title_level_education".tr),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              _buildLevelInput(context),
              SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
              _buildLabelText(context, "title_institution_name".tr),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              _buildInstitutionInput(context),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              _buildLabelText(context, "title_field_study".tr),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              _buildFieldStudyInput(context),
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
              _buildIsCurrentCheckBox(context),
              SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
              _buildLabelText(context, "description".tr),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              _buildDescriptionInput(context),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
            ],
          ),
        ),
        paddingBottom:
            EdgeInsets.all(context.fromWidth(CustomStyle.paddingValue)),
        bottomScreen: _buildBottomButtons(context),
      ),
    );
  }

  Widget _buildIsCurrentCheckBox(BuildContext context) {
    final eduState = _controller.eduState;

    return Row(
      children: [
        InkWell(
          onTap: () => eduState.isCurrent = !eduState.isCurrent,
          child: Container(
            height: context.height / 30,
            width: context.height / 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: SippoColor.white,
              boxShadow: const [
                BoxShadow(color: SippoColor.shedo, blurRadius: 5)
              ],
            ),
            child: Obx(
              () => Icon(
                Icons.check,
                size: 15,
                color: eduState.isCurrent
                    ? SippoColor.primarycolor
                    : SippoColor.transparent,
              ),
            ),
          ),
        ),
        SizedBox(
          width: context.fromWidth(CustomStyle.xs),
        ),
        AutoSizeText(
          "my_education_now_label".tr,
          style: dmsregular.copyWith(
            fontSize: FontSize.paragraph3(context),
            color: SippoColor.darkgrey,
          ),
        )
      ],
    );
  }

  Widget _buildEndDateInput(BuildContext context) {
    final eduState = _controller.eduState;

    return InputBorderedField(
      onTap: () {
        helper.showMyDatePicker(context, (date) {
          _controller.eduState.endDate.controller.text =
              helper.customDateFormatter(
            date.toString(),
            "yyyy-MM-dd",
          );
        });
      },
      readOnly: true,
      height: context.fromHeight(CustomStyle.inputBorderedSize),
      fontSize: FontSize.label(context),
      width: context.width / 2.3,
      controller: eduState.endDate.controller,
      suffixIcon: const Icon(
        Icons.date_range_outlined,
        color: SippoColor.primarycolor,
      ),
    );
  }

  Widget _buildStartDateInput(BuildContext context) {
    final eduState = _controller.eduState;

    return InputBorderedField(
      onTap: () {
        helper.showMyDatePicker(context, (date) {
          eduState.startDate.controller.text =
              helper.customDateFormatter(date.toString(), "yyyy-MM-dd");
        });
      },
      readOnly: true,
      height: context.fromHeight(CustomStyle.inputBorderedSize),
      fontSize: FontSize.label(context),
      width: context.width / 2.3,
      gController: eduState.startDate,
      suffixIcon: const Icon(
        Icons.date_range_outlined,
        color: SippoColor.primarycolor,
      ),
    );
  }

  Widget _buildFieldStudyInput(BuildContext context) {
    final eduState = _controller.eduState;
    return InputBorderedField(
      height: context.fromHeight(CustomStyle.inputBorderedSize),
      fontSize: FontSize.label(context),
      gController: eduState.fieldStudy,
      readOnly: true,
      maxLength: 70,
      onTap: () {
        showSearch(
          context: context,
          delegate: MySearchDelegate(
            hintText: "hint_text_search_field_study".tr,
            textFieldStyle: TextStyle(fontSize: FontSize.title6(context)),
            pageTitle: "title_field_study".tr,
            suggestions: eduState.data,
            onSelectedSearch: (value) {
              eduState.fieldStudy.controller.text = value;
            },
            buildResultSearch: (context, i, value) {
              return ListTile(title: Text(value));
            },
          ),
        );
      },
    );
  }

  Widget _buildInstitutionInput(BuildContext context) {
    final eduState = _controller.eduState;

    return InputBorderedField(
      height: context.fromHeight(CustomStyle.inputBorderedSize),
      fontSize: FontSize.label(context),
      gController: eduState.institution,
      maxLength: 70,
      readOnly: true,
      onTap: () {
        showSearch(
          context: context,
          delegate: MySearchDelegate(
            hintText: "hint_text_search_institution_name".tr,
            textFieldStyle: dmsmedium.copyWith(
              fontSize: FontSize.title6(context),
            ),
            pageTitle: "title_institution_name".tr,
            suggestions: eduState.data,
            onSelectedSearch: (value) =>
                eduState.institution.controller.text = value,
            buildResultSearch: (context, i, value) {
              return ListTile(title: Text(value));
            },
          ),
        );
      },
    );
  }

  Widget _buildLevelInput(BuildContext context) {
    final eduState = _controller.eduState;
    return InputBorderedField(
      readOnly: true,
      maxLength: 70,
      height: context.fromHeight(CustomStyle.inputBorderedSize),
      fontSize: FontSize.label(context),
      gController: eduState.level,
      onTap: () {
        showSearch(
          context: context,
          delegate: MySearchDelegate(
            hintText: "hint_text_search_level_education".tr,
            textFieldStyle: TextStyle(fontSize: FontSize.title6(context)),
            pageTitle: "title_level_education".tr,
            suggestions: eduState.data,
            onSelectedSearch: (value) {
              eduState.level.controller.text = value;
            },
            buildResultSearch: (context, i, value) {
              return ListTile(title: Text(value));
            },
          ),
        );
      },
    );
  }

  Widget _buildDescriptionInput(BuildContext context) {
    final eduState = _controller.eduState;

    return InputBorderedField(
      textInputAction: TextInputAction.newline,
      maxLength: 256,
      showCounter: true,
      gController: eduState.description,
      height: context.height / 7,
      hintText: "hint_text_write_information".tr,
      fontSize: FontSize.paragraph3(context),
      hintStyle: dmsregular.copyWith(
        fontSize: FontSize.label(context),
        color: SippoColor.grey,
      ),
      keyboardType: TextInputType.multiline,
      maxLine: 5,
      verticalPaddingValue: context.height / 36,
      validator: (value) => ValidatingInput.validateDescription(value?.trim()),
    );
  }

  AutoSizeText _buildLabelText(BuildContext context, String text) {
    return AutoSizeText(
      text,
      style: dmsbold.copyWith(
        fontSize: FontSize.label(context),
        color: SippoColor.primarycolor,
      ),
    );
  }

  Widget _buildWarningMessage() {
    final controller = EditAddEducationController.instance;
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

  Widget _buildBottomButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (_controller.isEditing)
          SizedBox(
            width: context.width / 2.3,
            child: CustomButton(
              onTapped: () {
                _showRemove();
              },
              text: "remove".tr,
              backgroundColor: SippoColor.lightprimary,
            ),
          ),
        SizedBox(
          width: _controller.isEditing ? context.width / 2.3 : null,
          child: CustomButton(
            onTapped: () {
              _showSaveBottomSheet();
            },
            text: "save".tr,
            backgroundColor: SippoColor.primarycolor,
          ),
        ),
      ],
    );
  }

  void _showSaveBottomSheet() async {
    await Get.bottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      ContainerBottomSheetWidget(
        notchColor: SippoColor.primarycolor,
        children: [
          ConfirmationBottomSheet(
            title: "title_dialog_save_new_education".tr,
            description: "ask_dialog_confirm_entered_change".tr,
            confirmTitle: 'yes'.tr,
            undoTitle: 'undo'.tr,
            onConfirm: () async {
              Get.back();
              if (_controller.formKey.currentState?.validate() == true) {
                await _controller.onSavedSubmitted().then((_) {
                  if (_controller.states.isSuccess) {
                    if (Get.isOverlaysOpen) Get.back();
                    Get.back();
                  }
                });
              }
            },
            onUndo: () {
              if (Get.isOverlaysOpen) Get.back();
            },
          )
        ],
      ),
    );
  }

  void _showRemove() {
    Get.bottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      ContainerBottomSheetWidget(
        notchColor: SippoColor.primarycolor,
        children: [
          ConfirmationBottomSheet(
            title: "title_dialog_remove_education".tr,
            description: "ask_dialog_remove".tr,
            confirmTitle: 'yes'.tr,
            undoTitle: 'undo'.tr,
            onConfirm: () async {
              Get.back();
              await _controller.onDeleteSubmitted();
              if (_controller.states.isSuccess) {
                if (Get.isOverlaysOpen) Get.back();
                Get.back();
              }
            },
            onUndo: () {
              if (Get.isOverlaysOpen) Get.back();
            },
          )
        ],
      ),
    );
  }
}
