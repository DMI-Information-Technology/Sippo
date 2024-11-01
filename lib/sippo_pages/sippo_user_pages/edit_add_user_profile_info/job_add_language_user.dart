import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/JobGlobalclass/jobstopimges.dart';
import 'package:sippo/JobGlobalclass/media_query_sizes.dart';
import 'package:sippo/JobGlobalclass/sippo_customstyle.dart';
import 'package:sippo/JobGlobalclass/text_font_size.dart';
import 'package:sippo/sippo_controller/user_profile_controller/language_edit_add_controller.dart';
import 'package:sippo/sippo_custom_widget/SearchDelegteImpl.dart';
import 'package:sippo/sippo_custom_widget/body_widget.dart';
import 'package:sippo/sippo_custom_widget/loading_view_widgets/loading_scaffold.dart';
import 'package:sippo/sippo_custom_widget/success_message_widget.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';

class LanguageUserAdd extends StatefulWidget {
  @override
  _LanguageUserAddState createState() => _LanguageUserAddState();

  const LanguageUserAdd();
}

class _LanguageUserAddState extends State<LanguageUserAdd> {
  final _controller = LanguageEditAddController.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return LoadingScaffold(
      controller: _controller.loadingController,
      appBar: AppBar(),
      body: BodyWidget(
        isScrollable: true,
        paddingContent: EdgeInsets.symmetric(
          horizontal: context.width / 32,
        ),
        child: Column(
          children: [
            SizedBox(
              width: width,
              child: Text(
                "add_language".tr,
                style: dmsbold.copyWith(
                  fontSize: FontSize.title3(context),
                  color: SippoColor.primarycolor,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
            Obx(() => CardNotifyMessage.warning(
                  state: _controller.states,
                  onCancelTap: () => _controller.warningState(false),
                )),
            Container(
              padding: EdgeInsets.all(context.fromHeight(CustomStyle.xl)),
              decoration: BoxDecoration(
                color: SippoColor.white,
                borderRadius: BorderRadius.circular(height / 32),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNewLanguage(),
                  Divider(
                    color: SippoColor.black,
                    height: height / 28,
                  ),
                  ListTile(
                    title: _buildTitleText(context, "first_language".tr),
                    trailing: Obx(
                      () => Checkbox(
                        value: _controller.newLanguage.isNative,
                        onChanged: (bool? value) {
                          _controller.setNewLanguage(
                            isNative: value,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: context.fromHeight(CustomStyle.spaceBetween)),
            Container(
              padding: EdgeInsets.all(context.fromHeight(CustomStyle.xl)),
              decoration: BoxDecoration(
                  color: SippoColor.white,
                  borderRadius: BorderRadius.circular(height / 32)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: _buildTitleText(context, "Level".tr),
                    subtitle: Obx(
                      () => Text(
                        _controller.newLanguage.level ??
                            "hint_text_no_level".tr,
                      ),
                    ),
                    onTap: () {
                      openLevelDialog();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        paddingBottom: EdgeInsets.all(
          context.fromWidth(CustomStyle.paddingValue),
        ),
        bottomScreen: CustomButton(
          onTapped: () {
            _controller.onSavedSubmitted().then((_) {
              if (_controller.states.isSuccess) {
                Get.back();
              }
            });
          },
          text: "SAVE".tr,
        ),
      ),
    );
  }

  void openLevelDialog() {
    Get.dialog(
      Obx(
        () => LanguageSkillLevelDialog(
          onLevelChange: (value) {
            _controller.setNewLanguage(level: value);
          },
          levelSelect: _controller.newLanguage.level ?? "hint_text_no_level".tr,
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
        child: Obx(
          () => Row(
            children: [
              _buildTitleText(context, "language".tr),
              Spacer(),
              ClipOval(
                child: Image.asset(
                  JobstopPngImg.language,
                  height: height / 18,
                  color: SippoColor.primarycolor,
                ),
              ),
              SizedBox(width: width / 25),
              Text(_controller.newLanguage.name ?? "")
            ],
          ),
        ),
      ),
    );
  }

  Text _buildTitleText(BuildContext context, String text) {
    return Text(
      text,
      style: dmsmedium.copyWith(
        fontSize: FontSize.title4(context),
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
        suggestions: _controller.suggestionsLanguage,
        spaceBetween: context.fromHeight(CustomStyle.spaceBetween),
        onSelectedSearch: (lang) {
          _controller.setNewLanguage(id: lang?.id, name: lang?.name);
        },
        onSelectedSuggestions: (sug, lang) {
          return sug == lang?.name;
        },
        buildResultSearch: (context, index, lang) {
          return ListTile(
            contentPadding: EdgeInsets.all(height / 64),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(height / 32),
            ),
            tileColor: SippoColor.white,
            title: Text(
              lang?.name ?? "",
              style: dmsregular.copyWith(fontSize: height / 38),
            ),
            leading: ClipOval(
              child: Image.asset(
                JobstopPngImg.language,
                height: height / 18,
              ),
            ),
          );
        },
        selectedSuggestion: (lang) {
          return lang?.name ?? "";
        },
        buildSuggestionsText: (lang) {
          return lang?.name ?? "";
        },
        onFilteredSuggestions: (query, langList) {
          return langList.where((lang) {
            final result = lang?.name?.toLowerCase() ?? "";
            final input = query.toLowerCase();
            return result.contains(input);
          }).toList();
        },
      ),
    );
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

    return Dialog(
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(width / 25),
      ),
      child: Padding(
        padding: const EdgeInsets.all(26),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AutoSizeText(
              'select_language_skill_Level'.tr,
              style: dmsbold.copyWith(
                fontSize: FontSize.title4(context),
              ),
            ),
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
            CustomButton(
                text: "label_done".tr,
                onTapped: () {
                  if (widget.onSkillLevelDone != null)
                    widget.onSkillLevelDone!(widget.levelSelect);
                  Get.back();
                })
          ],
        ),
      ),
    );
  }
}
