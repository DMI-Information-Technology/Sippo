import 'package:flutter/material.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JopCustomWidget/language_card_info_view.dart';
import 'package:get/get.dart';
import '../../JobGlobalclass/jobstopcolor.dart';
import '../../JobGlobalclass/jobstopfontstyle.dart';
import '../../JobThemes/themecontroller.dart';
import '../../Jopstobdata/model/profile_model/jobstop_language_info_card_model.dart';
import 'job_add_language_user.dart';

class LanguageEditAdd extends StatefulWidget {
  @override
  _LanguageEditAddState createState() => _LanguageEditAddState();

  const LanguageEditAdd();
}

class _LanguageEditAddState extends State<LanguageEditAdd> {
  List<LanguageInfoCardModel> languageData = [
    LanguageInfoCardModel(
      countryFlag: JobstopPngImg.arabic,
      languageName: "arabic",
      talkingLevel: "Advanced",
      writtenLevel: "Advanced",
    ),
    LanguageInfoCardModel(
      countryFlag: JobstopPngImg.arabic,
      languageName: "arabic",
      talkingLevel: "Advanced",
      writtenLevel: "Advanced",
    ),
  ];
  final themedata = Get.put(JobstopThemecontroler());

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Language Skills",
                  style: dmsbold.copyWith(
                      fontSize: height / 42,
                      color: themedata.isdark
                          ? Jobstopcolor.white
                          : Jobstopcolor.primarycolor),
                ),
                SizedBox(
                  height: height / 36,
                ),
                IconButton(
                  icon: CircleAvatar(
                    radius: height / 32,
                    backgroundColor: Jobstopcolor.lightprimary2,
                    child: Icon(
                      Icons.add,
                      size: height / 32,
                      color: Jobstopcolor.primarycolor,
                    ),
                  ),
                  onPressed: () {
                    _showAddLanguageDialog();
                  },
                ),
              ],
            ),
            SizedBox(height: height / 64),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                  height: height / 48,
                ),
                itemCount: languageData.length,
                itemBuilder: (context, index) {
                  return LanguageCardInfoView(
                    licm: languageData[index],
                    onDelete: () {},
                  );
                },
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

  void _showAddLanguageDialog() {
    // Size size = MediaQuery.of(context).size;
    // double height = size.height;
    // showSearch(
    //   context: context,
    //   delegate: MySearchDelegate(
    //     hintText: "search Language",
    //     textFieldStyle: TextStyle(fontSize: height / 58),
    //     pageTitle: "Add Language",
    //     onSelectedSearch: (value) {},
    //     buildResultSearch: (context, i, value) {
    //       return ListTile(title: Text(value));
    //     },
    //   ),
    // );
    Get.to(LanguageUserAdd());
  }

  void _saveLanguageData() {
    // Implement the logic to save the language data here
    // For example, you could save it to a database or a file.
    print('Saving language data: $languageData');
  }
}
