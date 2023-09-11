import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/JopController/user_profile_controller/profile_user_controller.dart';
import 'package:jobspot/utils/file_picker_service.dart';

import '../../JobGlobalclass/sippo_customstyle.dart';
import '../../sippo_custom_widget/file_upload_widget.dart';
import '../../sippo_data/model/profile_model/profile_widget_model/jobstop_resume_file_info.dart';
import '../../sippo_themes/themecontroller.dart';

class SippoUploadCV extends StatefulWidget {
  const SippoUploadCV({Key? key}) : super(key: key);

  @override
  State<SippoUploadCV> createState() => _SippoUploadCVState();
}

class _SippoUploadCVState extends State<SippoUploadCV> {
  final themedata = Get.put(JobstopThemecontroler());
  final ProfileUserController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: context.fromHeight(CustomStyle.s),
              vertical: context.fromHeight(CustomStyle.huge2)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                "Add Resume",
                style: dmsbold.copyWith(
                  fontSize: FontSize.title3(context),
                  color: themedata.isdark
                      ? Jobstopcolor.white
                      : Jobstopcolor.primarycolor,
                ),
              ),
              SizedBox(
                height: context.fromHeight(CustomStyle.spaceBetween),
              ),
              Obx(
                () => FileUploadWidget(
                  title: 'Upload your CV'.tr,
                  onUploadTapped: () async {
                    profileController.profileState.resumeFiles =
                        await FilePickerService.uploadResume();
                  },
                  onDeletedFile: () {
                    profileController.profileState.resumeFiles = ResumeFileInfo.getNull();
                  },
                  isUploaded: profileController.profileState.resumeFiles != null,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Jobstopcolor.backgroudHome,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.save),
      ),
    );
  }
}
