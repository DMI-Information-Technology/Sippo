import 'dart:io';
import 'package:file_picker/file_picker.dart';
import '../sippo_data/model/profile_model/jobstop_resume_file_info.dart';
import 'helper.dart';

class FilePickerService {
  static Future<String?> pickFileFromStoragePath() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    try {
      if (result != null) {
        PlatformFile pf = result.files.single;
        return pf.path;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<ResumeFileInfo?> uploadResume() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    try {
      if (result != null) {
        PlatformFile pf = result.files.single;
        File file = File(pf.path!);
        return ResumeFileInfo(
          fileName: pf.name,
          fileSize: (pf.size / 1000.0).toString(),
          fileType: pf.extension,
          uploadDate: dateTimeFormatter(DateTime.now()),
          bytes: file.readAsBytesSync(),
        );
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
