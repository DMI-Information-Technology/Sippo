import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/JobGlobalclass/media_query_sizes.dart';
import 'package:sippo/JobGlobalclass/sippo_customstyle.dart';
import 'package:sippo/JobGlobalclass/text_font_size.dart';
import 'package:sippo/sippo_controller/user_profile_controller/upload_cv_controller.dart';
import 'package:sippo/sippo_custom_widget/ConditionalWidget.dart';
import 'package:sippo/sippo_custom_widget/file_upload_widget.dart';
import 'package:sippo/sippo_custom_widget/loading_view_widgets/loading_scaffold.dart';
import 'package:sippo/sippo_custom_widget/resume_card_widget.dart';

class SippoUploadCV extends StatefulWidget {
  const SippoUploadCV({Key? key}) : super(key: key);

  @override
  State<SippoUploadCV> createState() => _SippoUploadCVState();
}

class _SippoUploadCVState extends State<SippoUploadCV> {
  final _controller = UploadCvController.instance;

  @override
  Widget build(BuildContext context) {
    return LoadingScaffold(
      controller: _controller.loadingController,
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
                "label_add_cv".tr,
                style: dmsbold.copyWith(
                  fontSize: FontSize.title3(context),
                  color: SippoColor.primarycolor,
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
                  title: 'title_upload_cv'.tr,
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
      backgroundColor: SippoColor.backgroudHome,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _controller.uploadCvFile().then((value) {
            Get.back();
          });
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
