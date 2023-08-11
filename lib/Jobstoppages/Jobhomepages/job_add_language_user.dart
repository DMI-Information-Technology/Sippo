import 'package:flutter/material.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:get/get.dart';
import 'package:jobspot/JopCustomWidget/widgets.dart';
import '../../JobGlobalclass/jobstopcolor.dart';
import '../../JobGlobalclass/jobstopfontstyle.dart';
import '../../JobThemes/themecontroller.dart';
import '../../JopController/ProfileController/language_edit_add_controller.dart';
import '../../JopCustomWidget/SearchDelegteImpl.dart';

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
                "Add Language",
                style: dmsbold.copyWith(
                    fontSize: height / 42,
                    color: themedata.isdark
                        ? Jobstopcolor.white
                        : Jobstopcolor.primarycolor),
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
                      "First Language",
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
                      "Talking",
                      style: dmsbold.copyWith(fontSize: height / 42),
                    ),
                    subtitle: Text("advance"),
                    onTap: () {
                      Get.dialog(
                        LanguageSkillLevelDialog(
                          onSkillLevelSelected: (value) {
                            langEAController.setLanguageInfo(
                              talkingLevel: value,
                            );
                          },
                        ),
                      );
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
                    subtitle: Text("advance"),
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
                  "Language",
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
          pageTitle: "Search Language",
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
  final Function(String skillLevel) onSkillLevelSelected;

  const LanguageSkillLevelDialog({
    required this.onSkillLevelSelected,
    Key? key,
  }) : super(key: key);

  @override
  State<LanguageSkillLevelDialog> createState() =>
      _LanguageSkillLevelDialogState();
}

class _LanguageSkillLevelDialogState extends State<LanguageSkillLevelDialog> {
  String? _selectedSkillLevel;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    return AlertDialog(
      title: Text(
        'Select Language Skill Level',
        style: dmsbold.copyWith(
          fontSize: height / 52,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile(
            value: 'Beginner',
            groupValue: _selectedSkillLevel,
            onChanged: (value) {
              setState(() {
                _selectedSkillLevel = value;
              });
            },
            title: const Text('Beginner'),
          ),
          RadioListTile(
            value: 'Intermediate',
            groupValue: _selectedSkillLevel,
            onChanged: (value) {
              setState(() {
                _selectedSkillLevel = value;
              });
            },
            title: const Text('Intermediate'),
          ),
          RadioListTile(
            value: 'Advanced',
            groupValue: _selectedSkillLevel,
            onChanged: (value) {
              setState(() {
                _selectedSkillLevel = value;
              });
            },
            title: const Text('Advanced'),
          ),
        ],
      ),
      actions: [
        CustomButton(
            text: "Done",
            onTappeed: () {
              widget.onSkillLevelSelected(_selectedSkillLevel!);
              Navigator.pop(context);
            })
      ],
    );
  }
}
