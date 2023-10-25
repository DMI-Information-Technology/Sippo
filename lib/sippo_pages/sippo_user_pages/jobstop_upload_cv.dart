import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';
import 'package:jobspot/JobGlobalclass/sippo_customstyle.dart';
import 'package:jobspot/JobGlobalclass/text_font_size.dart';
import 'package:jobspot/JopController/user_profile_controller/upload_cv_controller.dart';
import 'package:jobspot/sippo_custom_widget/ConditionalWidget.dart';
import 'package:jobspot/sippo_custom_widget/file_upload_widget.dart';
import 'package:jobspot/sippo_custom_widget/resume_card_widget.dart';

class SippoUploadCV extends StatefulWidget {
  const SippoUploadCV({Key? key}) : super(key: key);

  @override
  State<SippoUploadCV> createState() => _SippoUploadCVState();
}

class _SippoUploadCVState extends State<SippoUploadCV> {
  final _controller = UploadCvController.instance;

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
                  color: Jobstopcolor.primarycolor,
                ),
              ),
              SizedBox(
                height: context.fromHeight(CustomStyle.spaceBetween),
              ),
              Obx(
                () => FileUploadWidget(
                  cvCardWidget: ConditionalWidget(
                    _controller.user.cv != null,
                    data: _controller.user.cv,
                    guaranteedBuilder: (_, data) => CvCardWidget.fromRemote(
                      remoteCv: data,
                    ),
                    avoidBuilder: (__, _) => CvCardWidget(
                      fileCv: _controller.profileState.cvFile,
                    ),
                  ),
                  title: 'Upload your CV'.tr,
                  onUploadTapped: () {
                    _controller.uploadFileCvFromStorage();
                  },
                  onDeletedFile: () {
                    _controller.removeCvFile();
                  },
                  isUploaded: _controller.user.cv != null ||
                      !_controller.profileState.cvFile.isFileNull,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Jobstopcolor.backgroudHome,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _controller.uploadCvFile();
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
