import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';

import '../../JobGlobalclass/text_font_size.dart';
import '../../JopController/ProfileController/edit_add_work_experience_controller.dart';
import '../../sippo_custom_widget/confirmation_bottom_sheet.dart';
import '../../sippo_custom_widget/container_bottom_sheet_widget.dart';
import '../../utils/helper.dart' as helper;

class JobExperiences extends StatelessWidget {
  const JobExperiences({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = EditAddWorkExperienceController.instance;
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(),
      body: BodyWidget(
        isScrollable: true,
        paddingContent: EdgeInsets.symmetric(
          horizontal: context.fromWidth(CustomStyle.paddingValue),
        ),
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
            AutoSizeText(
              "job_title".tr,
              style: dmsbold.copyWith(
                  fontSize: FontSize.label(context),
                  color: Jobstopcolor.primarycolor),
            ),
            SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
            Obx(() => InputBorderedField(
                  height: context.fromHeight(CustomStyle.inputBorderedSize),
                  fontSize: FontSize.label(context),
                  initialValue: controller.title,
                  onTextChanged: (value) {
                    controller.title = value;
                  },
                )),
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
            AutoSizeText(
              "company".tr,
              style: dmsbold.copyWith(
                fontSize: FontSize.label(context),
                color: Jobstopcolor.primarycolor,
              ),
            ),
            SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
            Obx(() => InputBorderedField(
                  height: context.fromHeight(CustomStyle.inputBorderedSize),
                  fontSize: FontSize.label(context),
                  initialValue: controller.company,
                  onTextChanged: (value) {
                    controller.company = value;
                  },
                )),
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      "start_date.tr",
                      style: dmsbold.copyWith(
                        fontSize: FontSize.label(context),
                        color: Jobstopcolor.primarycolor,
                      ),
                    ),
                    SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
                    InputBorderedField(
                      onTap: () {
                        helper.showMyDatePicker(context, (date) {
                          controller.startDate.text =
                              helper.customDateFormatter(
                            date ?? DateTime.now(),
                            "yyyy-MM-dd",
                          );
                        });
                      },
                      readOnly: true,
                      height: context.fromHeight(CustomStyle.inputBorderedSize),
                      fontSize: FontSize.label(context),
                      width: width / 2.3,
                      controller: controller.startDate,
                      suffixIcon: Icon(
                        Icons.date_range_outlined,
                        color: Jobstopcolor.primarycolor,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      "end_date".tr,
                      style: dmsbold.copyWith(
                        fontSize: FontSize.label(context),
                        color: Jobstopcolor.primarycolor,
                      ),
                    ),
                    SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
                    InputBorderedField(
                      onTap: () {
                        helper.showMyDatePicker(context, (date) {
                          controller.endDate.text = helper.customDateFormatter(
                            date ?? DateTime.now(),
                            "yyyy-MM-dd",
                          );
                        });
                      },
                      readOnly: true,
                      height: context.fromHeight(CustomStyle.inputBorderedSize),
                      fontSize: FontSize.label(context),
                      width: width / 2.3,
                      controller: controller.endDate,
                      suffixIcon: Icon(
                        Icons.date_range_outlined,
                        color: Jobstopcolor.primarycolor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
            Row(
              children: [
                Obx(() => InkWell(
                      onTap: () {
                        controller.isCurrentJob = !controller.isCurrentJob;
                      },
                      child: Container(
                        height: height / 30,
                        width: height / 30,
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
                          color: controller.isCurrentJob
                              ? Jobstopcolor.primarycolor
                              : Jobstopcolor.transparent,
                        ),
                      ),
                    )),
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
            SizedBox(height: height / 36),
            AutoSizeText(
              "description".tr,
              style: dmsbold.copyWith(
                fontSize: FontSize.label(context),
                color: Jobstopcolor.primarycolor,
              ),
            ),
            SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
            Obx(() => InputBorderedField(
                  initialValue: controller.description,
                  height: height / 6,
                  hintText: "additional_information".tr,
                  hintStyle: dmsregular.copyWith(
                    fontSize: FontSize.label(context),
                    color: Jobstopcolor.grey,
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLine: 3,
                  onTextChanged: (value) {
                    controller.description = value;
                  },
                )),
          ],
        ),
        paddingBottom:
            EdgeInsets.all(context.fromWidth(CustomStyle.paddingValue)),
        bottomScreen: _buildBottomButtonsRow(context),
      ),
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
        if (controller.isEditing)
          SizedBox(
            width: width / 2.3,
            child: CustomButton(
              onTappeed: () {
                _showremove();
              },
              text: "REMOVE".tr,
              backgroundColor: Jobstopcolor.lightprimary,
            ),
          ),
        SizedBox(
          width: controller.isEditing ? width / 2.3 : null,
          child: CustomButton(
            onTappeed: () {
              _showSave();
            },
            text: "SAVE".tr,
            backgroundColor: Jobstopcolor.primarycolor,
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
              await controller.onSaveSubmitted();
            },
            onUndo: () {},
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
            onConfirm: () {},
            onUndo: () {},
          )
        ],
      ),
    );
  }
}
