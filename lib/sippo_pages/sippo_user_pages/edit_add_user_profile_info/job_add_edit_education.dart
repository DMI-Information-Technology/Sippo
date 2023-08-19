import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopprefname.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/JopCustomWidget/widgets.dart';

import '../../../JobThemes/themecontroller.dart';
import '../../../JopCustomWidget/SearchDelegteImpl.dart';
import '../../../sippo_data/model/profile_model/jobstop_education_info_card_model.dart';

class JobEducationAddEdit extends StatefulWidget {
  const JobEducationAddEdit({Key? key}) : super(key: key);

  @override
  State<JobEducationAddEdit> createState() => _JobEducationAddEditState();
}

class _JobEducationAddEditState extends State<JobEducationAddEdit> {
  bool check = true;
  final themedata = Get.put(JobstopThemecontroler());
  TextEditingController levelEduCon = TextEditingController();
  TextEditingController institutionCon = TextEditingController();
  TextEditingController fieldStudyCon = TextEditingController();
  TextEditingController startDateCon = TextEditingController();
  TextEditingController endDateCon = TextEditingController();
  TextEditingController description = TextEditingController();
  EducationInfoCardModel? edui;
  final data = [
    "education 1",
    "education 2",
    "education 3",
    "education 4",
    "education 5",
    "education 6",
    "education 7",
  ];

  @override
  void initState() {
    final Map<String, dynamic>? arg = Get.arguments[educationArg];
    edui = arg != null ? EducationInfoCardModel.fromJson(arg) : null;
    levelEduCon.text = edui != null ? edui?.level ?? "" : "";
    fieldStudyCon.text = edui != null ? edui?.fieldStudy ?? "" : "";
    startDateCon.text = edui != null ? edui?.periodic?.split("-")[0] ?? "" : "";
    endDateCon.text = edui != null ? edui?.periodic?.split("-")[1] ?? "" : "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width / 26, vertical: height / 96),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${edui != null ? "Change" : "Add"} Education",
                style: dmsbold.copyWith(
                    fontSize: FontSize.titleFontSize3(context),
                    color: themedata.isdark
                        ? Jobstopcolor.white
                        : Jobstopcolor.primarycolor),
              ),
              SizedBox(
                height: height / 36,
              ),
              Text(
                "Level of education",
                style: dmsbold.copyWith(
                    fontSize: FontSize.labelFontSize(context),
                    color: themedata.isdark
                        ? Jobstopcolor.white
                        : Jobstopcolor.primarycolor),
              ),
              SizedBox(
                height: height / 64,
              ),
              InputBorderedField(
                readOnly: true,
                height: height / 12.5,
                fontSize: height / 68,
                controller: levelEduCon,
                onTap: () {
                  showSearch(
                    context: context,
                    delegate: MySearchDelegate(
                      hintText: "search on level of education",
                      textFieldStyle: TextStyle(fontSize: height / 58),
                      pageTitle: "Level of education",
                      suggestions: data,
                      onSelectedSearch: (value) => levelEduCon.text = value,
                      buildResultSearch: (context, i, value) {
                        return ListTile(title: Text(value));
                      },
                    ),
                  );
                },
              ),
              SizedBox(
                height: height / 36,
              ),
              Text(
                "Institution name",
                style: dmsbold.copyWith(
                    fontSize: FontSize.labelFontSize(context),
                    color: themedata.isdark
                        ? Jobstopcolor.white
                        : Jobstopcolor.primarycolor),
              ),
              SizedBox(
                height: height / 66,
              ),
              InputBorderedField(
                  height: height / 12.5,
                  fontSize: height / 68,
                  controller: institutionCon,
                  readOnly: true,
                  onTap: () {
                    showSearch(
                      context: context,
                      delegate: MySearchDelegate(
                        hintText: "search on institution name",
                        textFieldStyle: TextStyle(fontSize: height / 58),
                        pageTitle: "Institution name",
                        suggestions: data,
                        onSelectedSearch: (value) =>
                            institutionCon.text = value,
                        buildResultSearch: (context, i, value) {
                          return ListTile(title: Text(value));
                        },
                      ),
                    );
                  }),
              SizedBox(
                height: height / 66,
              ),
              Text(
                "Field of study",
                style: dmsbold.copyWith(
                    fontSize: FontSize.labelFontSize(context),
                    color: themedata.isdark
                        ? Jobstopcolor.white
                        : Jobstopcolor.primarycolor),
              ),
              SizedBox(
                height: height / 66,
              ),
              InputBorderedField(
                  height: height / 12.5,
                  fontSize: height / 68,
                  controller: fieldStudyCon,
                  readOnly: true,
                  onTap: () {
                    showSearch(
                      context: context,
                      delegate: MySearchDelegate(
                        hintText: "search on field of study",
                        textFieldStyle: TextStyle(fontSize: height / 58),
                        pageTitle: "Field of study",
                        suggestions: data,
                        onSelectedSearch: (value) => fieldStudyCon.text = value,
                        buildResultSearch: (context, i, value) {
                          return ListTile(title: Text(value));
                        },
                      ),
                    );
                  }),
              SizedBox(
                height: height / 36,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Start date",
                        style: dmsbold.copyWith(
                          fontSize: FontSize.labelFontSize(context),
                          color: themedata.isdark
                              ? Jobstopcolor.white
                              : Jobstopcolor.primarycolor,
                        ),
                      ),
                      SizedBox(
                        height: height / 66,
                      ),
                      InputBorderedField(
                        height: height / 12.5,
                        fontSize: height / 68,
                        width: width / 2.3,
                        controller: startDateCon,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "End date",
                        style: dmsbold.copyWith(
                            fontSize: FontSize.labelFontSize(context),
                            color: themedata.isdark
                                ? Jobstopcolor.white
                                : Jobstopcolor.primarycolor),
                      ),
                      SizedBox(
                        height: height / 66,
                      ),
                      InputBorderedField(
                        height: height / 12.5,
                        fontSize: height / 68,
                        width: width / 2.3,
                        controller: endDateCon,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: height / 36,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        check == false ? check = true : check = false;
                      });
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
                      child: Icon(Icons.check,
                          size: 15,
                          color: check == true
                              ? Jobstopcolor.primarycolor
                              : Jobstopcolor.transparent),
                    ),
                  ),
                  SizedBox(
                    width: width / 16,
                  ),
                  Text(
                    "This is my position now",
                    style: dmsregular.copyWith(
                        fontSize: FontSize.paragraphFontSize3(context), color: Jobstopcolor.darkgrey),
                  )
                ],
              ),
              SizedBox(
                height: height / 36,
              ),
              Text(
                "Description",
                style: dmsbold.copyWith(
                    fontSize: FontSize.labelFontSize(context),
                    color: themedata.isdark
                        ? Jobstopcolor.white
                        : Jobstopcolor.primarycolor),
              ),
              SizedBox(
                height: height / 66,
              ),
              InputBorderedField(
                controller: description,
                height: height / 5,
                hintText: "Write additional information here",
                hintStyle: dmsregular.copyWith(
                  fontSize: 12,
                  color: Jobstopcolor.grey,
                ),
                keyboardType: TextInputType.multiline,
                maxLine: 5,
              ),
              SizedBox(
                height: height / 36,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (edui != null)
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
                    width: edui != null ? width / 2.3 : null,
                    child: CustomButton(
                      onTappeed: () {
                        _showundo();
                      },
                      text: "SAVE".tr,
                      backgroundColor: Jobstopcolor.primarycolor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      backgroundColor: Jobstopcolor.backgroudHome,
    );
  }

  _showundo() {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    Get.bottomSheet(
      isScrollControlled: true,
      Container(
        height: height * 0.4,
        decoration: const BoxDecoration(
          color: Jobstopcolor.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), topLeft: Radius.circular(15)),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width / 26, vertical: height / 66),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: height / 500,
                  width: width / 8,
                  decoration: BoxDecoration(
                    color: Jobstopcolor.primarycolor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                SizedBox(
                  height: height / 26,
                ),
                Text(
                  "Undo Changes ?",
                  style: dmsbold.copyWith(
                      fontSize: 16, color: Jobstopcolor.primarycolor),
                ),
                SizedBox(
                  height: height / 100,
                ),
                Text(
                  "Are you sure you want to change what you entered?",
                  style: dmsregular.copyWith(
                      fontSize: 12, color: Jobstopcolor.darkgrey),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: height / 26,
                ),
                CustomButton(
                  onTappeed: () {},
                  text: "Continue Filling".tr,
                ),
                SizedBox(
                  height: height / 56,
                ),
                CustomButton(
                  onTappeed: () {},
                  text: "Undo Changes",
                  backgroundColor: Jobstopcolor.lightprimary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showremove() {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    showModalBottomSheet(
      context: context,
      backgroundColor: Jobstopcolor.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Jobstopcolor.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15)),
          ),
          height: height * 0.4,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width / 26, vertical: height / 66),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: height / 500,
                    width: width / 8,
                    decoration: BoxDecoration(
                      color: Jobstopcolor.primarycolor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  SizedBox(
                    height: height / 26,
                  ),
                  Text(
                    "Remove Education ?",
                    style: dmsbold.copyWith(
                        fontSize: 16, color: Jobstopcolor.primarycolor),
                  ),
                  SizedBox(
                    height: height / 100,
                  ),
                  Text(
                    "Are you sure you want to change what you entered?",
                    style: dmsregular.copyWith(
                        fontSize: 12, color: Jobstopcolor.darkgrey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: height / 26,
                  ),
                  CustomButton(
                    onTappeed: () {},
                    text: "Continue Filling".tr,
                  ),
                  SizedBox(
                    height: height / 56,
                  ),
                  CustomButton(
                    onTappeed: () {},
                    text: "Undo Changes",
                    backgroundColor: Jobstopcolor.lightprimary,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
