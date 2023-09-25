import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopprefname.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';

import '../../../JobGlobalclass/sippo_customstyle.dart';
import '../../../sippo_custom_widget/body_widget.dart';
import '../../../sippo_custom_widget/confirmation_bottom_sheet.dart';
import '../../../sippo_custom_widget/container_bottom_sheet_widget.dart';
import '../../../sippo_data/model/profile_model/profile_widget_model/jobstop_appreciation_info_card_model.dart';
import '../../../sippo_themes/themecontroller.dart';

class JobAppreciationAddEdit extends StatefulWidget {
  const JobAppreciationAddEdit({Key? key}) : super(key: key);

  @override
  State<JobAppreciationAddEdit> createState() => _JobAppreciationAddEditState();
}

class _JobAppreciationAddEditState extends State<JobAppreciationAddEdit> {
  bool check = true;
  final themedata = Get.put(JobstopThemecontroler());
  TextEditingController awardCon = TextEditingController();
  TextEditingController categoryAchieveCon = TextEditingController();
  TextEditingController endDateCon = TextEditingController();
  TextEditingController description = TextEditingController();
  AppreciationInfoCardModel? appreci;

  @override
  void initState() {
    final Map<String, dynamic>? arg = Get.arguments[appreciationArg];
    appreci = arg != null ? AppreciationInfoCardModel.fromJson(arg) : null;
    awardCon.text = arg != null ? appreci?.awardName ?? "" : "";
    categoryAchieveCon.text = arg != null ? appreci?.categoryAchieve ?? "" : "";
    endDateCon.text = arg != null ? appreci?.year ?? "" : "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(),
      body: BodyWidget(
        isScrollable: true,
        paddingContent: EdgeInsets.symmetric(
            horizontal: context.fromWidth(CustomStyle.paddingValue)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              "${appreci != null ? "edit".tr : "edd".tr}" + "Appreciation".tr,
              style: dmsbold.copyWith(
                  fontSize: FontSize.title3(context),
                  color: Jobstopcolor.primarycolor),
            ),
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
            AutoSizeText(
              "award_name".tr,
              style: dmsbold.copyWith(
                  fontSize: FontSize.label(context),
                  color: Jobstopcolor.primarycolor),
            ),
            SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
            InputBorderedField(
              height: context.fromHeight(CustomStyle.inputBorderedSize),
              fontSize: FontSize.label(context),
              controller: awardCon,
            ),
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
            AutoSizeText(
              "category_achievement_achieved".tr,
              style: dmsbold.copyWith(
                  fontSize: FontSize.label(context),
                  color: themedata.isdark
                      ? Jobstopcolor.white
                      : Jobstopcolor.primarycolor),
            ),
            SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
            InputBorderedField(
              height: context.fromHeight(CustomStyle.inputBorderedSize),
              fontSize: FontSize.label(context),
              controller: categoryAchieveCon,
            ),
            SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
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
                  height: context.fromHeight(CustomStyle.inputBorderedSize),
                  fontSize: context.fromHeight(CustomStyle.xxxl),
                  width: width / 2.3,
                  controller: endDateCon,
                ),
              ],
            ),
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      check == false ? check = true : check = false;
                    });
                  },
                  child: Container(
                    height: context.fromHeight(CustomStyle.m),
                    width: context.fromHeight(CustomStyle.m),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Jobstopcolor.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Jobstopcolor.shedo,
                            blurRadius: 5,
                          )
                        ]),
                    child: Icon(
                      Icons.check,
                      size: 15,
                      color: check == true
                          ? Jobstopcolor.primarycolor
                          : Jobstopcolor.transparent,
                    ),
                  ),
                ),
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
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
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
              controller: description,
              height: height / 5,
              hintText: "additional_information".tr,
              hintStyle: dmsregular.copyWith(
                fontSize: FontSize.label(context),
                color: Jobstopcolor.grey,
              ),
              keyboardType: TextInputType.multiline,
              maxLine: 5,
            ),
          ],
        ),
        paddingBottom:
            EdgeInsets.all(context.fromWidth(CustomStyle.paddingValue)),
        bottomScreen: _buildBottomButtons(context),
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (appreci != null)
          SizedBox(
            width: width / 2.3,
            child: CustomButton(
              onTapped: () {
                _showremove();
              },
              text: "REMOVE".tr,
              backgroundColor: Jobstopcolor.lightprimary,
            ),
          ),
        SizedBox(
          width: appreci != null ? width / 2.3 : null,
          child: CustomButton(
            onTapped: () {
              _showundo();
            },
            text: "SAVE".tr,
            backgroundColor: Jobstopcolor.primarycolor,
          ),
        ),
      ],
    );
  }

  void _showundo() {
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
            onConfirm: () {},
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
            title: "Remove Appreciation ?",
            description: "Are you sure you want to change what you entered?",
            onConfirm: () {},
            onUndo: () {},
          )
        ],
      ),
    );
  }
}
