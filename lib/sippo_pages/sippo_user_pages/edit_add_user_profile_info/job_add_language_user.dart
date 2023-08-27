import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';

import '../../../JobGlobalclass/jobstopcolor.dart';
import '../../../JopController/ProfileController/language_edit_add_controller.dart';
import '../../../sippo_custom_widget/SearchDelegteImpl.dart';
import '../../../sippo_themes/themecontroller.dart';

class LanguageUserAdd extends StatefulWidget {
  @override
  _LanguageUserAddState createState() => _LanguageUserAddState();

  const LanguageUserAdd();
}

class _LanguageUserAddState extends State<LanguageUserAdd> {
  final themedata = Get.put(JobstopThemecontroler());
  final LanguageEditAddController langEAController =
      Get.put(LanguageEditAddController());
  final flagList = [
    {"English": JobstopPngImg.english},
    {"Arabic": JobstopPngImg.arabic},
    {"English": JobstopPngImg.english},
    {"Arabic": JobstopPngImg.arabic},
    {"English": JobstopPngImg.english},
    {"Arabic": JobstopPngImg.arabic},
    {"English": JobstopPngImg.english},
    {"Arabic": JobstopPngImg.arabic},
    {"English": JobstopPngImg.english},
    {"Arabic": JobstopPngImg.arabic},
    {"English": JobstopPngImg.english},
    {"Arabic": JobstopPngImg.arabic},
    {"English": JobstopPngImg.english},
    {"Arabic": JobstopPngImg.arabic},
    {"English": JobstopPngImg.english},
    {"Arabic": JobstopPngImg.arabic},
    {"English": JobstopPngImg.english},
    {"Arabic": JobstopPngImg.arabic},
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: width / 26, vertical: height / 96),
        child: Column(
          children: [
            SizedBox(
              width: width,
              child: Text(
                "add_language".tr,
                style: dmsbold.copyWith(
                  fontSize: height / 42,
                  color: Jobstopcolor.primarycolor,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: height / 58),
            Container(
              padding: EdgeInsets.all(height / 52),
              decoration: BoxDecoration(
                  color: Jobstopcolor.white,
                  borderRadius: BorderRadius.circular(height / 32)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNewLanguage(),
                  Divider(
                    color: Jobstopcolor.black,
                    height: height / 28,
                  ),
                  ListTile(
                    title: Text(
                      "first_language".tr,
                      style: dmsbold.copyWith(fontSize: height / 42),
                    ),
                    trailing: Obx(
                      () => Checkbox(
                        value: langEAController.languageInfo.firstLanguage ??
                            false,
                        onChanged: (bool? value) {
                          langEAController.setLanguageInfo(
                              firstLanguage: value);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height / 58),
            Container(
              padding: EdgeInsets.all(height / 52),
              decoration: BoxDecoration(
                  color: Jobstopcolor.white,
                  borderRadius: BorderRadius.circular(height / 32)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      "talking".tr,
                      style: dmsbold.copyWith(fontSize: height / 42),
                    ),
                    subtitle: Obx(
                      () => Text(
                          langEAController.languageInfo.talkingLevel ?? ""),
                    ),
                    onTap: () {
                      openLevelTalkingDialog();
                    },
                  ),
                  Divider(
                    color: Jobstopcolor.black,
                    height: height / 28,
                  ),
                  ListTile(
                    title: Text(
                      "Written",
                      style: dmsbold.copyWith(fontSize: height / 42),
                    ),
                    subtitle: Obx(
                      () => Text(
                        langEAController.languageInfo.writtenLevel ?? "",
                      ),
                    ),
                    onTap: () {
                      openLevelWrittenDialog();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveLanguageData,
        child: Icon(Icons.save),
      ),
    );
  }

  void openLevelTalkingDialog() {
    Get.dialog(
      Obx(
        () => LanguageSkillLevelDialog(
          onSkillLevelDone: (value) {
            langEAController.setLanguageInfo(
              talkingLevel: value,
            );
            langEAController.selectedLevel = "no level";
          },
          onLevelChange: (value) {
            langEAController.selectedLevel = value ?? "no level";
          },
          levelSelect: langEAController.selectedLevel,
        ),
      ),
    );
  }

  void openLevelWrittenDialog() {
    Get.dialog(
      Obx(
        () => LanguageSkillLevelDialog(
          onSkillLevelDone: (value) {
            langEAController.setLanguageInfo(
              writtenLevel: value,
            );
            langEAController.selectedLevel = "no level";
          },
          onLevelChange: (value) {
            langEAController.selectedLevel = value ?? "no level";
          },
          levelSelect: langEAController.selectedLevel,
        ),
      ),
    );
  }

  InkWell _buildNewLanguage() {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return InkWell(
      onTap: _showAddLanguageDialog,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: height / 68),
        child: Obx(() => Row(
              children: [
                Text(
                  "language".tr,
                  style: dmsbold.copyWith(fontSize: height / 42),
                ),
                Spacer(),
                ClipOval(
                  child: Image.asset(
                    langEAController.languageInfo.countryFlag ??
                        JobstopPngImg.language,
                    height: height / 18,
                    color: langEAController.languageInfo.countryFlag == null
                        ? Jobstopcolor.primarycolor
                        : null,
                  ),
                ),
                SizedBox(width: width / 25),
                Text(langEAController.languageInfo.languageName ?? "")
              ],
            )),
      ),
    );
  }

  // void _showLevelLanguageDialog() {}

  void _showAddLanguageDialog() {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    showSearch(
      context: context,
      delegate: CustomSearchDelegate(
          pageTitle: "search_language".tr,
          suggestions: flagList,
          spaceBetween: height / 38,
          onSelectedSearch: (lang) {
            langEAController.setLanguageInfo(
              languageName: lang?.keys.first,
              countryFlag: lang?.values.first,
            );
          },
          onSelectedSuggestions: (sug, lang) {
            return sug == lang?.keys.first;
          },
          buildResultSearch: (context, index, lang) {
            return ListTile(
              contentPadding: EdgeInsets.all(height / 64),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(height / 32),
              ),
              tileColor: Jobstopcolor.white,
              title: Text(
                lang?.keys.first ?? "",
                style: dmsregular.copyWith(fontSize: height / 38),
              ),
              leading: ClipOval(
                child: Image.asset(
                  lang?.values.first ?? "",
                  height: height / 18,
                ),
              ),
            );
          },
          selectedSuggestion: (lang) {
            return lang?.keys.first ?? "";
          },
          buildSuggestionsText: (lang) {
            return lang?.keys.first ?? "";
          },
          onFilteredSuggestions: (query, langList) {
            return langList.where((lang) {
              final result = lang?.keys.first.toLowerCase() ?? "";
              final input = query.toLowerCase();
              return result.contains(input);
            }).toList();
          }),
    );
  }

  void _saveLanguageData() {
    // Implement the logic to save the language data here
    // For example, you could save it to a database or a file.
    print('Saving language data: ');
  }
}

class LanguageSkillLevelDialog extends StatefulWidget {
  final void Function(String skillLevel)? onSkillLevelDone;
  final void Function(String? skillLevel) onLevelChange;
  final String levelSelect;

  const LanguageSkillLevelDialog({
    this.onSkillLevelDone,
    required this.onLevelChange,
    required this.levelSelect,
    Key? key,
  }) : super(key: key);

  @override
  State<LanguageSkillLevelDialog> createState() =>
      _LanguageSkillLevelDialogState();
}

class _LanguageSkillLevelDialogState extends State<LanguageSkillLevelDialog> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    // double height = size.height;
    final double _dPadding = width / 16;

    return AlertDialog(
      actionsPadding: EdgeInsets.only(
        left: _dPadding,
        right: _dPadding,
        bottom: _dPadding,
      ),
      titlePadding:
          EdgeInsets.only(left: _dPadding, right: _dPadding, top: _dPadding),
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(width / 25),
      ),
      title: AutoSizeText(
        'select_language_skill_Level'.tr,
        style: dmsbold.copyWith(
          fontSize: FontSize.title4(context),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text("Beginner"),
            trailing: Radio(
              value: "beginner".tr,
              groupValue: widget.levelSelect,
              onChanged: (value) => widget.onLevelChange(value),
            ),
          ),
          ListTile(
            title: Text("intermediate".tr),
            trailing: Radio(
              value: "Intermediate",
              groupValue: widget.levelSelect,
              onChanged: (value) => widget.onLevelChange(value),
            ),
          ),
          ListTile(
            title: Text("advanced".tr),
            trailing: Radio(
              value: "Advanced",
              groupValue: widget.levelSelect,
              onChanged: (value) => widget.onLevelChange(value),
            ),
          ),
        ],
      ),
      actions: [
        CustomButton(
            text: "Done",
            onTappeed: () {
              if (widget.onSkillLevelDone != null)
                widget.onSkillLevelDone!(widget.levelSelect);
              Navigator.pop(context);
            })
      ],
    );
  }
}
