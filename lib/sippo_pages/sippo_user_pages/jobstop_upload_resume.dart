import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/JopController/ProfileController/profile_user_controller.dart';
import 'package:jobspot/JopCustomWidget/file_upload_widget.dart';
import 'package:jobspot/utils/file_picker_service.dart';

import '../../JobThemes/themecontroller.dart';
import '../../sippo_data/model/profile_model/jobstop_resume_file_info.dart';

class JobUploadResume extends StatefulWidget {
  const JobUploadResume({Key? key}) : super(key: key);

  @override
  State<JobUploadResume> createState() => _JobUploadResumeState();
}

class _JobUploadResumeState extends State<JobUploadResume> {
  final themedata = Get.put(JobstopThemecontroler());
  final ProfileUserController profileController = Get.find();

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
              horizontal: width / 24, vertical: height / 96),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Resume",
                style: dmsbold.copyWith(
                  fontSize: FontSize.titleFontSize3(context),
                  color: themedata.isdark
                      ? Jobstopcolor.white
                      : Jobstopcolor.primarycolor,
                ),
              ),
              SizedBox(
                height: height / 36,
              ),
              Obx(
                () => FileUploadWidget(
                  title: 'Upload your CV',
                  onUploadTapped: () async {
                    profileController.resumeFiles =
                        await FilePickerService.uploadResume();
                  },
                  onDeletedFile: () {
                    profileController.resumeFiles = ResumeFileInfo.getNull();
                  },
                  isUploaded: profileController.resumeFiles != null,
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

