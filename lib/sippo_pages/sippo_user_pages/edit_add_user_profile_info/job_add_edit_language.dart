import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/sippo_custom_widget/language_card_info_view.dart';
import 'package:jobspot/sippo_custom_widget/widgets.dart';

import './job_add_language_user.dart';
import '../../../JobGlobalclass/jobstopcolor.dart';
import '../../../JobGlobalclass/jobstopfontstyle.dart';
import '../../../JobGlobalclass/jobstopprefname.dart';
import '../../../sippo_custom_widget/body_widget.dart';
import '../../../sippo_data/model/profile_model/profile_widget_model/jobstop_language_info_card_model.dart';
import '../../../sippo_themes/themecontroller.dart';

class LanguageEditAdd extends StatefulWidget {
  @override
  _LanguageEditAddState createState() => _LanguageEditAddState();

  const LanguageEditAdd();
}

class _LanguageEditAddState extends State<LanguageEditAdd> {
  List<LanguageInfoCardModel> languageData = [
    LanguageInfoCardModel(
      countryFlag: JobstopPngImg.english,
      languageName: "English",
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
  List<LanguageInfoCardModel>? langList;

  @override
  void initState() {
    final List<Map<String, dynamic>>? arg = Get.arguments[langListArg];
    langList = arg != null
        ? arg.map((e) => LanguageInfoCardModel.fromJson(e)).toList()
        : [];
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
        isScrollable: false,
        paddingContent: EdgeInsets.symmetric(horizontal: width / 32),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "language_kills".tr,
                style: dmsbold.copyWith(
                  fontSize: height / 42,
                  color: Jobstopcolor.primarycolor,
                ),
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
              itemCount: langList?.length ?? 0,
              itemBuilder: (context, index) {
                return LanguageCardInfoView(
                  licm: langList?[index],
                  onDelete: () {},
                );
              },
            ),
          ),
        ]),
        paddingBottom: EdgeInsets.all(width / 32),
        bottomScreen: CustomButton(
          onTappeed: () {},
          text: "save".tr,
        ),
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

  // void _saveLanguageData() {
  //   // Implement the logic to save the language data here
  //   // For example, you could save it to a database or a file.
  //   print('Saving language data: $languageData');
  // }
}
