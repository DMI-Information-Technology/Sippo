import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/utils/helper.dart' as helper;
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JopController/user_profile_controller/edit_add_education_controller.dart';
import 'package:jobspot/sippo_custom_widget/SearchDelegteImpl.dart';
import 'package:jobspot/sippo_custom_widget/confirmation_bottom_sheet.dart';
import 'package:jobspot/sippo_custom_widget/container_bottom_sheet_widget.dart';
import 'package:jobspot/sippo_custom_widget/loading_empty_feild_widget.dart';
import 'package:jobspot/sippo_custom_widget/success_message_widget.dart';
import 'package:jobspot/utils/validating_input.dart';

class JobEducationAddEdit extends StatefulWidget {
  const JobEducationAddEdit({Key? key}) : super(key: key);

  @override
  State<JobEducationAddEdit> createState() => _JobEducationAddEditState();
}

class _JobEducationAddEditState extends State<JobEducationAddEdit> {
  final _controller = EditAddEducationController.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  "${_controller.isEditing ? "change".tr : "Add".tr} Education",
                  style: dmsbold.copyWith(
                      fontSize: FontSize.title3(context),
                      color: Jobstopcolor.primarycolor),
                ),
              ),
              SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
              _buildSuccessMessage(),
              _buildWarningMessage(),
              _buildLabelText(context, "Level of education"),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              _buildLevelInput(context),
              SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
              _buildLabelText(context, "Institution name"),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              _buildInstitutionInput(context),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              _buildLabelText(context, "Field of study"),
              SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
              _buildFieldStudyInput(context),
              SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabelText(context, "Start date"),
                      SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
                      _buildStartDateInput(context),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabelText(context, "End date"),
                      SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
                      _buildEndDateInput(context),
                    ],
                  ),
                ],
              ),
              SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
              _buildIsCurrentCheckBox(context),
              SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
              _buildLabelText(context, "Description"),
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
              color: Jobstopcolor.white,
              boxShadow: const [
                BoxShadow(color: Jobstopcolor.shedo, blurRadius: 5)
              ],
            ),
            child: Obx(
              () => Icon(
                Icons.check,
                size: 15,
                color: eduState.isCurrent
                    ? Jobstopcolor.primarycolor
                    : Jobstopcolor.transparent,
              ),
            ),
          ),
        ),
        SizedBox(
          width: context.fromWidth(CustomStyle.xs),
        ),
        AutoSizeText(
          "This is my education now",
          style: dmsregular.copyWith(
            fontSize: FontSize.paragraph3(context),
            color: Jobstopcolor.darkgrey,
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
      suffixIcon: Obx(
        () => _controller.isTextLoading(eduState.endDate.isTextEmpty)
            ? const LoadingInputField()
            : const Icon(
                Icons.date_range_outlined,
                color: Jobstopcolor.primarycolor,
              ),
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
      suffixIcon: Obx(
        () => _controller.isTextLoading(eduState.startDate.isTextEmpty)
            ? const LoadingInputField()
            : const Icon(
                Icons.date_range_outlined,
                color: Jobstopcolor.primarycolor,
              ),
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
      onTap: () {
        showSearch(
          context: context,
          delegate: MySearchDelegate(
            hintText: "search on field of study",
            textFieldStyle: TextStyle(fontSize: FontSize.title6(context)),
            pageTitle: "Field of study",
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
      suffixIcon: Obx(
        () => _controller.isTextLoading(eduState.fieldStudy.isTextEmpty)
            ? const LoadingInputField()
            : const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildInstitutionInput(BuildContext context) {
    final eduState = _controller.eduState;

    return InputBorderedField(
      height: context.fromHeight(CustomStyle.inputBorderedSize),
      fontSize: FontSize.label(context),
      gController: eduState.institution,
      readOnly: true,
      onTap: () {
        showSearch(
          context: context,
          delegate: MySearchDelegate(
            hintText: "search on institution name",
            textFieldStyle: dmsmedium.copyWith(
              fontSize: FontSize.title6(context),
            ),
            pageTitle: "Institution name",
            suggestions: eduState.data,
            onSelectedSearch: (value) =>
                eduState.institution.controller.text = value,
            buildResultSearch: (context, i, value) {
              return ListTile(title: Text(value));
            },
          ),
        );
      },
      suffixIcon: Obx(
        () => _controller.isTextLoading(eduState.institution.isTextEmpty)
            ? const LoadingInputField()
            : const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildLevelInput(BuildContext context) {
    final eduState = _controller.eduState;
    return InputBorderedField(
      readOnly: true,
      height: context.fromHeight(CustomStyle.inputBorderedSize),
      fontSize: FontSize.label(context),
      gController: eduState.level,
      onTap: () {
        showSearch(
          context: context,
          delegate: MySearchDelegate(
            hintText: "search on level of education",
            textFieldStyle: TextStyle(fontSize: FontSize.title6(context)),
            pageTitle: "Level of education",
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
      suffixIcon: Obx(
        () => _controller.isTextLoading(eduState.level.isTextEmpty)
            ? const LoadingInputField()
            : const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildDescriptionInput(BuildContext context) {
    final eduState = _controller.eduState;

    return InputBorderedField(
      textInputAction: TextInputAction.newline,
      gController: eduState.description,
      height: context.height / 7,
      hintText: "Write additional information here",
      fontSize: FontSize.paragraph3(context),
      hintStyle: dmsregular.copyWith(
        fontSize: FontSize.label(context),
        color: Jobstopcolor.grey,
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
        color: Jobstopcolor.primarycolor,
      ),
    );
  }

  Widget _buildSuccessMessage() {
    final controller = EditAddEducationController.instance;
    return Obx(
      () {
        return controller.states.isSuccess
            ? CardNotifyMessage(
                controller.states.message ?? '',
                onCancelTap: () => controller.successState(false),
                messageType: MessageType.SUCCESS,
              )
            : const SizedBox.shrink();
      },
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
              text: "REMOVE".tr,
              backgroundColor: Jobstopcolor.lightprimary,
            ),
          ),
        SizedBox(
          width: _controller.isEditing ? context.width / 2.3 : null,
          child: CustomButton(
            onTapped: () {
              _showSaveBottomSheet();
            },
            text: "SAVE".tr,
            backgroundColor: Jobstopcolor.primarycolor,
          ),
        ),
      ],
    );
  }

  void _showSaveBottomSheet() {
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
            title: "Are you sure you want to change what you entered?",
            description: "Are you sure you want to change what you entered?",
            onConfirm: () async {
              if (_controller.formKey.currentState?.validate() == true) {
                await _controller.onSavedSubmitted();
                Get.back();
              }
            },
            onUndo: () {},
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
        notchColor: Jobstopcolor.primarycolor,
        children: [
          ConfirmationBottomSheet(
            title: "Remove Appreciation ?",
            description: "Are you sure you want to change what you entered?",
            onConfirm: () async {
              await _controller.onDeleteSubmitted();
            },
            onUndo: () {},
          )
        ],
      ),
    );
  }
}
