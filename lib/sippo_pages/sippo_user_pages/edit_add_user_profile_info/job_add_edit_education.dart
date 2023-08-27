import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/sippo_custom_widget/body_widget.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';

import '../../../JobGlobalclass/sippo_customstyle.dart';
import '../../../JopController/ProfileController/edit_add_education_controller.dart';
import '../../../sippo_custom_widget/SearchDelegteImpl.dart';
import '../../../sippo_custom_widget/confirmation_bottom_sheet.dart';
import '../../../sippo_custom_widget/container_bottom_sheet_widget.dart';

class JobEducationAddEdit extends StatefulWidget {
  const JobEducationAddEdit({Key? key}) : super(key: key);

  @override
  State<JobEducationAddEdit> createState() => _JobEducationAddEditState();
}

class _JobEducationAddEditState extends State<JobEducationAddEdit> {
  final _controller = EditAddEducationController.instance;
  final data = [
    "Associate's Degree",
    "Bachelor's Degree",
    "Master's Degree",
    "Doctorate (Ph.D.)",
    "Doctor of Education (Ed.D.)",
    "Doctor of Philosophy in Education (Ph.D. in Education)",
    "Bachelor of Arts in Education (B.A.Ed.)",
    "Bachelor of Science in Education (B.S.Ed.)",
    "Master of Arts in Teaching (M.A.T.)",
    "Master of Education (M.Ed.)",
    "Master of Science in Education (M.S.Ed.)",
    "Education Specialist (Ed.S.)",
    "Postgraduate Certificate in Education (PGCE)",
    "Certificate in Education (Cert.Ed.)",
    "Professional Development Programs"
  ];

  @override
  void initState() {
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
              "${_controller.isEditing ? "Change" : "Add"} Education",
              style: dmsbold.copyWith(
                  fontSize: FontSize.title3(context),
                  color: Jobstopcolor.primarycolor),
            ),
            SizedBox(
              height: context.fromHeight(CustomStyle.spaceBetween),
            ),
            AutoSizeText(
              "Level of education",
              style: dmsbold.copyWith(
                  fontSize: FontSize.label(context),
                  color: Jobstopcolor.primarycolor),
            ),
            SizedBox(
              height: context.fromHeight(CustomStyle.xxxl),
            ),
            InputBorderedField(
              readOnly: true,
              height: context.fromHeight(CustomStyle.inputBorderedSize),
              fontSize: FontSize.label(context),
              controller: _controller.levelEduCon,
              onTap: () {
                showSearch(
                  context: context,
                  delegate: MySearchDelegate(
                    hintText: "search on level of education",
                    textFieldStyle:
                        TextStyle(fontSize: FontSize.title6(context)),
                    pageTitle: "Level of education",
                    suggestions: data,
                    onSelectedSearch: (value) {
                      _controller.levelEduCon.text = value;
                    },
                    buildResultSearch: (context, i, value) {
                      return ListTile(title: Text(value));
                    },
                  ),
                );
              },
            ),
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
            AutoSizeText(
              "Institution name",
              style: dmsbold.copyWith(
                  fontSize: FontSize.label(context),
                  color: Jobstopcolor.primarycolor),
            ),
            SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
            InputBorderedField(
                height: context.fromHeight(CustomStyle.inputBorderedSize),
                fontSize: FontSize.label(context),
                controller: _controller.institutionCon,
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
                      suggestions: data,
                      onSelectedSearch: (value) =>
                          _controller.institutionCon.text = value,
                      buildResultSearch: (context, i, value) {
                        return ListTile(title: Text(value));
                      },
                    ),
                  );
                }),
            SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
            AutoSizeText(
              "Field of study",
              style: dmsbold.copyWith(
                  fontSize: FontSize.label(context),
                  color: Jobstopcolor.primarycolor),
            ),
            SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
            InputBorderedField(
                height: context.fromHeight(CustomStyle.inputBorderedSize),
                fontSize: FontSize.label(context),
                controller: _controller.fieldStudyCon,
                readOnly: true,
                onTap: () {
                  showSearch(
                    context: context,
                    delegate: MySearchDelegate(
                      hintText: "search on field of study",
                      textFieldStyle:
                          TextStyle(fontSize: FontSize.title6(context)),
                      pageTitle: "Field of study",
                      suggestions: data,
                      onSelectedSearch: (value) {
                        _controller.fieldStudyCon.text = value;
                      },
                      buildResultSearch: (context, i, value) {
                        return ListTile(title: Text(value));
                      },
                    ),
                  );
                }),
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      "Start date",
                      style: dmsbold.copyWith(
                        fontSize: FontSize.label(context),
                        color: Jobstopcolor.primarycolor,
                      ),
                    ),
                    SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
                    InputBorderedField(
                      height: context.fromHeight(CustomStyle.inputBorderedSize),
                      fontSize: FontSize.label(context),
                      width: width / 2.3,
                      controller: _controller.startDateCon,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      "End date",
                      style: dmsbold.copyWith(
                          fontSize: FontSize.label(context),
                          color: Jobstopcolor.primarycolor),
                    ),
                    SizedBox(height: context.fromHeight(CustomStyle.xxxl)),
                    InputBorderedField(
                      height: context.fromHeight(CustomStyle.inputBorderedSize),
                      fontSize: FontSize.label(context),
                      width: width / 2.3,
                      controller: _controller.endDateCon,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    _controller.isMyLastDegree = !_controller.isMyLastDegree;
                  },
                  child: Container(
                    height: height / 30,
                    width: height / 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Jobstopcolor.white,
                        boxShadow: const [
                          BoxShadow(color: Jobstopcolor.shedo, blurRadius: 5)
                        ]),
                    child: Obx(
                      () => Icon(
                        Icons.check,
                        size: 15,
                        color: _controller.isMyLastDegree
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
                  "This is my position now",
                  style: dmsregular.copyWith(
                    fontSize: FontSize.paragraph3(context),
                    color: Jobstopcolor.darkgrey,
                  ),
                )
              ],
            ),
            SizedBox(
              height: context.fromHeight(CustomStyle.spaceBetween),
            ),
            AutoSizeText(
              "Description",
              style: dmsbold.copyWith(
                fontSize: FontSize.label(context),
                color: Jobstopcolor.primarycolor,
              ),
            ),
            SizedBox(
              height: context.fromHeight(CustomStyle.xxxl),
            ),
            InputBorderedField(
              controller: _controller.description,
              height: height / 6,
              hintText: "Write additional information here",
              hintStyle: dmsregular.copyWith(
                fontSize: 12,
                color: Jobstopcolor.grey,
              ),
              keyboardType: TextInputType.multiline,
              maxLine: 3,
            ),
          ],
        ),
        paddingBottom:
            EdgeInsets.all(context.fromWidth(CustomStyle.paddingValue)),
        bottomScreen: _buildBottomButtons(context),
      ),
    );
  }

  Row _buildBottomButtons(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // double height = size.height;
    double width = size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (_controller.isEditing)
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
          width: _controller.isEditing ? width / 2.3 : null,
          child: CustomButton(
            onTappeed: () {
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
