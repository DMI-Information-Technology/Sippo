import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

import '../../JobGlobalclass/jobstopcolor.dart';
import '../../sippo_data/model/profile_model/profile_widget_model/jobstop_resume_file_info.dart';
import '../../utils/file_picker_service.dart';

class JobDescriptionController extends GetxController {
  final _cvJobApply = ResumeFileInfo.getNull().obs;
  final _selectedPageView = 0.obs;

  static JobDescriptionController get instance => Get.find();

  int get selectedPageView => _selectedPageView.toInt();

  Color changeDescriptionButtonColor() => selectedPageView == 0
      ? Jobstopcolor.primarycolor
      : Jobstopcolor.lightprimary;

  Color changeCompanyButtonColor() => selectedPageView == 1
      ? Jobstopcolor.primarycolor
      : Jobstopcolor.lightprimary;

  void set selectedPageView(int value) {
    _selectedPageView.value = value;
  }

  void switchPageView() => selectedPageView = selectedPageView == 0 ? 1 : 0;

  ResumeFileInfo? get cvJobApply => _cvJobApply.value;

  bool get isCvJobApplyNull => _cvJobApply.value == null;
  final _uploadFileStatus = false.obs;

  bool get uploadFileStatus => _uploadFileStatus.isTrue;

  void set uploadFileStatus(bool value) {
    _uploadFileStatus.value = value;
  }

  Future<void> uploadCvFile() async {
    _cvJobApply.value = await FilePickerService.uploadResume(
      onFileUploading: (status) =>
          _uploadFileStatus.value = status == FilePickerStatus.picking,
    );
  }

  Future<void> removeCvFile() async {
    _cvJobApply.value = ResumeFileInfo.getNull();
  }
}
