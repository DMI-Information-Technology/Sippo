import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopprefname.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';

import '../../../JopController/ProfileController/edit_add_skills_controller.dart';
import '../../../sippo_custom_widget/SearchDelegteImpl.dart';
import '../../../sippo_custom_widget/confirmation_bottom_sheet.dart';
import '../../../sippo_custom_widget/container_bottom_sheet_widget.dart';
import '../../../sippo_themes/themecontroller.dart';

class JobSkillsAddEdit extends StatefulWidget {
  const JobSkillsAddEdit({Key? key}) : super(key: key);

  @override
  State<JobSkillsAddEdit> createState() => _JobJobSkillsAddEditState();
}

class _JobJobSkillsAddEditState extends State<JobSkillsAddEdit> {
  bool check = true;
  final themedata = Get.put(JobstopThemecontroler());
  List<String>? skillsList;

  @override
  void initState() {
    skillsList = Get.arguments[skillsListArg] ?? [];
    super.initState();
  }

  EditAddSkillsController editAddSkillsController =
      Get.put(EditAddSkillsController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(),
      body: BodyWidget(
        isScrollable: true,
        paddingContent: EdgeInsets.symmetric(horizontal: width / 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Text(
                !editAddSkillsController.isChangeSkills
                    ? "Skills(${skillsList?.length ?? 0})"
                    : "Add skills",
                style: dmsbold.copyWith(
                    fontSize: 16, color: Jobstopcolor.primarycolor),
              ),
            ),
            SizedBox(height: height / 36),
            Obx(
              () => editAddSkillsController.isChangeSkills
                  ? InputBorderedField(
                      readOnly: true,
                      height: height / 13.5,
                      hintText: "search skills",
                      fontSize: height / 68,
                      prefixIcon: Icon(Icons.search),
                      onTap: () {
                        showSearch(
                          context: context,
                          delegate: MySearchDelegate(
                            hintText: "search skills",
                            textFieldStyle: TextStyle(fontSize: height / 58),
                            pageTitle: "Skills",
                            suggestions: [],
                            onSelectedSearch: (value) {},
                            buildResultSearch: (context, i, value) {
                              return ListTile(title: Text(value));
                            },
                          ),
                        );
                      },
                    )
                  : const SizedBox.shrink(),
            ),
            SizedBox(height: height / 36),
            _buildSkillsChipsWrapper(context),
          ],
        ),
        paddingBottom: EdgeInsets.all(width / 32),
        bottomScreen: _buildBottomButtonRow(),
      ),
    );
  }

  SizedBox _buildSkillsChipsWrapper(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // double height = size.height;
    double width = size.width;
    return SizedBox(
      width: width,
      child: Wrap(
        runSpacing: width / 32,
        alignment: WrapAlignment.start,
        spacing: width / 32,
        children: skillsList != null
            ? skillsList!
                .map((e) => Obx(
                      () => Chip(
                        padding: EdgeInsets.all(
                          width / 36,
                        ),
                        label: Text(e),
                        deleteIcon: Icon(Icons.cancel_outlined),
                        onDeleted: editAddSkillsController.isChangeSkills
                            ? () {}
                            : null,
                      ),
                    ))
                .toList()
            : [],
      ),
    );
  }

  Row _buildBottomButtonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(() => CustomButton(
              onTappeed: () async {
                if (editAddSkillsController.isChangeSkills) await _showundo();
                editAddSkillsController.isChangeSkills =
                    !editAddSkillsController.isChangeSkills;
              },
              text:
                  editAddSkillsController.isChangeSkills ? "SAVE" : "CHANGE".tr,
              backgroundColor: Jobstopcolor.primarycolor,
            )),
      ],
    );
  }

  Future<void> _showundo() async {
    await Get.bottomSheet(
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
            onConfirm: () {},
            onUndo: () {},
          )
        ],
      ),
    );
  }
  //
  // void _showremove() {
  //   Get.bottomSheet(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(
  //         top: Radius.circular(25),
  //       ),
  //     ),
  //     backgroundColor: Colors.white,
  //     isScrollControlled: true,
  //     ContainerBottomSheetWidget(
  //       notchColor: Jobstopcolor.primarycolor,
  //       children: [
  //         ConfirmationBottomSheet(
  //           title: "Remove Appreciation ?",
  //           description: "Are you sure you want to change what you entered?",
  //           onConfirm: () {},
  //           onUndo: () {},
  //         )
  //       ],
  //     ),
  //   );
  // }
}
