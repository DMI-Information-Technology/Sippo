import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/routes.dart';
import 'package:sippo/sippo_custom_widget/language_card_info_view.dart';
import 'package:sippo/sippo_custom_widget/success_message_widget.dart';

import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/sippo_controller/user_profile_controller/language_edit_add_controller.dart';
import 'package:sippo/sippo_custom_widget/body_widget.dart';
import 'package:sippo/sippo_custom_widget/confirmation_bottom_sheet.dart';
import 'package:sippo/sippo_custom_widget/container_bottom_sheet_widget.dart';

class LanguageEditAdd extends StatefulWidget {
  @override
  _LanguageEditAddState createState() => _LanguageEditAddState();

  const LanguageEditAdd();
}

class _LanguageEditAddState extends State<LanguageEditAdd> {
  final _controller = Get.put(LanguageEditAddController());

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
                  color: SippoColor.primarycolor,
                ),
              ),
              SizedBox(
                height: height / 36,
              ),
              IconButton(
                icon: CircleAvatar(
                  radius: height / 32,
                  backgroundColor: SippoColor.lightprimary2,
                  child: Icon(
                    Icons.add,
                    size: height / 32,
                    color: SippoColor.primarycolor,
                  ),
                ),
                onPressed: _addLanguage,
              ),
            ],
          ),
          SizedBox(height: height / 64),
          Obx(() => CardNotifyMessage.warning(
                state: _controller.states,
                onCancelTap: () => _controller.warningState(false),
              )),
          Expanded(
            child: Obx(
              () => ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                  height: height / 48,
                ),
                itemCount: _controller.langProfileList.length,
                itemBuilder: (context, index) {
                  final lang = _controller.langProfileList[index];
                  return LanguageCardInfoView(
                    lang: lang,
                    onDelete: () async {
                      print("lang.id = ${lang.id}");
                      _showConfirmDeleteBottomSheet(lang.id, index);
                    },
                  );
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void _addLanguage() async {
    _controller.resetState();
    await Get.toNamed(SippoRoutes.languageUserAdd);
    _controller.resetNewLanguage();
    _controller.resetState();
  }

  void _showConfirmDeleteBottomSheet(int? langId, int index) {
    Get.bottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      ContainerBottomSheetWidget(
        notchColor: SippoColor.primarycolor,
        children: [
          ConfirmationBottomSheet(
            title: "title_dialog_remove_language".tr,
            description: "ask_dialog_remove".tr,
            onConfirm: () async {
              Get.back();
              await _controller.onDeletedSubmitted(langId, index);
            },
            onUndo: () => Get.back(),
          )
        ],
      ),
    );
  }
}
