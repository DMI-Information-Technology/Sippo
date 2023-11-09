import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/sippo_controller/user_profile_controller/edit_add_projects_controller.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/confirmation_bottom_sheet.dart';
import 'package:jobspot/sippo_custom_widget/container_bottom_sheet_widget.dart';
import 'package:jobspot/sippo_custom_widget/loading_view_widgets/loading_scaffold.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/user_projects_model.dart';
import 'package:jobspot/sippo_themes/themecontroller.dart';

import 'package:jobspot/sippo_custom_widget/success_message_widget.dart';
import 'package:jobspot/utils/helper.dart';

class SippoProjectsAddEdit extends StatefulWidget {
  const SippoProjectsAddEdit({Key? key}) : super(key: key);

  @override
  State<SippoProjectsAddEdit> createState() => _SippoProjectsAddEditState();
}

class _SippoProjectsAddEditState extends State<SippoProjectsAddEdit> {
  bool check = true;
  final themedata = Get.put(JobstopThemecontroler());

  final _controller = EditAddProjectsController.instance;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args != null &&
        args is Map<String, UserProjectsModel> &&
        args.containsKey('project')) {
      final proj = args['project'];
      _controller.projects.value = proj ?? _controller.projects.value;
      _controller.projectState.setAll(_controller.projects.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double height = size.height;
    return LoadingScaffold(
      controller: _controller.loadingOverly,
      appBar: AppBar(),
      body: BodyWidget(
        isScrollable: true,
        paddingContent: EdgeInsets.symmetric(
            horizontal: context.fromWidth(CustomStyle.paddingValue)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              "${_controller.isEditing ? "edit".tr : "edd".tr} ${"projects".tr}",
              style: dmsbold.copyWith(
                  fontSize: FontSize.title3(context),
                  color: Jobstopcolor.primarycolor),
            ),
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
            Obx(() => CardNotifyMessage.warning(
                  state: _controller.states,
                  onCancelTap: () => _controller.warningState(false),
                )),
            AutoSizeText(
              "name".tr,
              style: dmsbold.copyWith(
                  fontSize: FontSize.label(context),
                  color: Jobstopcolor.primarycolor),
            ),
            SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
            Form(
              key: _controller.formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputBorderedField(
                      height: context.fromHeight(CustomStyle.inputBorderedSize),
                      fontSize: FontSize.label(context),
                      gController: _controller.projectState.name,
                    ),
                    SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabelText(context, "label_date".tr),
                        SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
                        _buildDateInput(context),
                      ],
                    ),
                    SizedBox(
                        height: context.fromHeight(CustomStyle.spaceBetween)),
                    AutoSizeText(
                      "description".tr,
                      style: dmsbold.copyWith(
                          fontSize: FontSize.label(context),
                          color: themedata.isdark
                              ? Jobstopcolor.white
                              : Jobstopcolor.primarycolor),
                    ),
                    SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
                    InputBorderedField(
                      verticalPaddingValue:
                          context.fromHeight(CustomStyle.paddingValue),
                      gController: _controller.projectState.desc,
                      height: height / 5,
                      hintText: "additional_information".tr,
                      hintStyle: dmsregular.copyWith(
                        fontSize: FontSize.label(context),
                        color: Jobstopcolor.grey,
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLine: 5,
                    ),
                  ]),
            )
          ],
        ),
        paddingBottom:
            EdgeInsets.all(context.fromWidth(CustomStyle.paddingValue)),
        bottomScreen: _buildBottomButtons(context),
      ),
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

  Widget _buildBottomButtons(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (_controller.isEditing)
          SizedBox(
            width: width / 2.3,
            child: CustomButton(
              onTapped: () => _showRemove(context),
              text: "REMOVE".tr,
              backgroundColor: Jobstopcolor.lightprimary,
            ),
          ),
        SizedBox(
          width: _controller.isEditing ? width / 2.3 : null,
          child: CustomButton(
            onTapped: () => _showSave(context),
            text: "SAVE".tr,
            backgroundColor: Jobstopcolor.primarycolor,
          ),
        ),
      ],
    );
  }

  Widget _buildDateInput(BuildContext context) {
    final projectState = _controller.projectState;

    return InputBorderedField(
      onTap: () {
        showMyDatePicker(context, (date) {
          _controller.projectState.date.controller.text = customDateFormatter(
            date.toString(),
            "yyyy-MM-dd",
          );
        });
      },
      readOnly: true,
      height: context.fromHeight(CustomStyle.inputBorderedSize),
      fontSize: FontSize.label(context),
      width: context.width / 2.3,
      controller: projectState.date.controller,
      suffixIcon: const Icon(
        Icons.date_range_outlined,
        color: Jobstopcolor.primarycolor,
      ),
    );
  }

  void _showSave(BuildContext context) {

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
            title: "title_dialog_save_new_project".tr,
            description: "ask_dialog_confirm_entered_change".tr,
            onConfirm: () async {
              Navigator.pop(context);
              if (_controller.formKey.currentState?.validate() == true) {
                _controller.onSaveSubmitted().then((_) {
                  print("projects states: ${_controller.states.isSuccess}");
                  if (_controller.states.isSuccess) {
                    if (Get.isOverlaysOpen) Navigator.pop(context);
                    Navigator.pop(context);
                  }
                });
              }
            },
            onUndo: () => Get.isOverlaysOpen ? Navigator.pop(context) : null,
          )
        ],
      ),
    );

  }

  void _showRemove(BuildContext context) {
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
            title: "title_dialog_remove_project".tr,
            description: "ask_dialog_remove".tr,
            onConfirm: () {
              Navigator.pop(context);
              _controller.onDeleteSubmitted().then((_) {
                if (_controller.states.isSuccess) {
                  if (Get.isOverlaysOpen) Navigator.pop(context);
                  Navigator.pop(context);
                }
              });
            },
            onUndo: () => Get.isOverlaysOpen ? Navigator.pop(context) : null,
          )
        ],
      ),
    );
  }
}
