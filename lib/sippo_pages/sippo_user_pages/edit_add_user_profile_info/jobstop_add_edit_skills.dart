import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/sippo_controller/user_profile_controller/edit_add_skills_controller.dart';
import 'package:sippo/sippo_custom_widget/ConditionalWidget.dart';
import 'package:sippo/sippo_custom_widget/SearchDelegteImpl.dart';
import 'package:sippo/sippo_custom_widget/body_widget.dart';
import 'package:sippo/sippo_custom_widget/confirmation_bottom_sheet.dart';
import 'package:sippo/sippo_custom_widget/container_bottom_sheet_widget.dart';
import 'package:sippo/sippo_custom_widget/loading_view_widgets/loading_scaffold.dart';
import 'package:sippo/sippo_custom_widget/success_message_widget.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';

class JobSkillsAddEdit extends StatefulWidget {
  const JobSkillsAddEdit({Key? key}) : super(key: key);

  @override
  State<JobSkillsAddEdit> createState() => _JobJobSkillsAddEditState();
}

class _JobJobSkillsAddEditState extends State<JobSkillsAddEdit> {
  final _controller = EditAddSkillsController.instance;

  @override
  Widget build(BuildContext context) {
    final skillsState = _controller.skillsState;
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return LoadingScaffold(
      controller: _controller.loadingController,
      appBar: AppBar(),
      body: BodyWidget(
        isScrollable: true,
        paddingContent: EdgeInsets.symmetric(horizontal: width / 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Text(
                !skillsState.isChangeSkills
                    ? "${'title_skills'.tr}(${skillsState.skillsList.length})"
                    : "label_add_skills".tr,
                style: dmsbold.copyWith(
                    fontSize: 16, color: SippoColor.primarycolor),
              ),
            ),
            SizedBox(height: height / 36),
            Obx(() => ConditionalWidget(
                  skillsState.isChangeSkills,
                  data: skillsState.suggestionsSkills,
                  guaranteedBuilder: (context, data) => InputBorderedField(
                    readOnly: true,
                    height: height / 13.5,
                    hintText: "hint_text_search_skills".tr,
                    fontSize: height / 68,
                    prefixIcon: Icon(Icons.search),
                    onTap: () {
                      showSearch(
                        context: context,
                        delegate: MySearchDelegate(
                          hintText: "hint_text_search_skills".tr,
                          textFieldStyle: TextStyle(fontSize: height / 58),
                          pageTitle: "title_skills".tr,
                          suggestions: data,
                          onSelectedSearch: (value) {
                            _controller.pushSkill(value);
                          },
                          buildResultSearch: (context, i, value) {
                            return ListTile(title: Text(value));
                          },
                        ),
                      );
                    },
                  ),
                )),
            SizedBox(height: height / 36),
            // _buildSuccessMessage(),
            _buildWarningMessage(),
            _buildSkillsChipsWrapper(context),
          ],
        ),
        paddingBottom: EdgeInsets.all(width / 32),
        bottomScreen: _buildBottomButtonRow(),
      ),
    );
  }

  SizedBox _buildSkillsChipsWrapper(BuildContext context) {
    final skillsState = _controller.skillsState;

    Size size = MediaQuery.of(context).size;
    // double height = size.height;
    double width = size.width;
    return SizedBox(
      width: width,
      child: Obx(() {
        final skills = skillsState.skillsList;

        return Wrap(
          runSpacing: width / 32,
          alignment: WrapAlignment.start,
          spacing: width / 32,
          children: [
            for (var i = 0; i < skills.length; i++)
              InkWell(
                onTap: () {
                  skillsState.selectedChip = i;
                },
                child: Chip(
                  padding: EdgeInsets.all(
                    width / 36,
                  ),
                  label: Text(
                    skills[i],
                    style: dmsregular.copyWith(
                      color:
                          skillsState.selectedChip == i ? Colors.white : null,
                    ),
                  ),
                  backgroundColor: skillsState.selectedChip == i
                      ? SippoColor.primarycolor
                      : null,
                  deleteIcon: Icon(
                    Icons.cancel_outlined,
                    color: skillsState.selectedChip == i ? Colors.white : null,
                  ),
                  onDeleted: skillsState.isChangeSkills
                      ? () => _controller.removeSkill(i)
                      : null,
                ),
              ),
          ],
        );
      }),
    );
  }

  Row _buildBottomButtonRow() {
    final skillsState = _controller.skillsState;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(
          () => CustomButton(
            onTapped: () async {
              if (skillsState.isChangeSkills) {
                await _showSaveChanged();
              } else {
                skillsState.isChangeSkills = !skillsState.isChangeSkills;
              }
            },
            text: (skillsState.isChangeSkills ? "save" : "change").tr,
            backgroundColor: SippoColor.primarycolor,
          ),
        ),
      ],
    );
  }

  Future<void> _showSaveChanged() async {
    final skillsState = _controller.skillsState;
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
            title: "title_dialog_save_skill".tr,
            description: "ask_dialog_confirm_entered_change".tr,
            onConfirm: () {
              Get.back();
              _controller.onSaveSubmitted().then((_) {
                skillsState.isChangeSkills = !skillsState.isChangeSkills;
                if (_controller.states.isSuccess) {
                  if (Get.isOverlaysOpen) Get.back();
                  Get.back();
                }
              });
            },
            onUndo: () {
              _controller.resetSkillsState();
              skillsState.isChangeSkills = !skillsState.isChangeSkills;
              Get.back();
            },
          )
        ],
      ),
    );
  }

  Widget _buildWarningMessage() {
    final controller = EditAddSkillsController.instance;

    return Obx(() => ConditionalWidget(
          controller.states.isWarning,
          data: controller.states,
          guaranteedBuilder: (context, data) => CardNotifyMessage.warning(
            state: data,
            onCancelTap: () => controller.warningState(false),
          ),
        ));
  }
}
