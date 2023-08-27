import 'package:file_picker/file_picker.dart';
import '../sippo_data/model/profile_model/profile_widget_model/jobstop_resume_file_info.dart';
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

  static Future<ResumeFileInfo?> uploadResume(
      {void Function(FilePickerStatus status)? onFileUploading}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      onFileLoading: (status) {
        if (onFileUploading != null) onFileUploading(status);
      },
    );
    try {
      if (result != null) {
        PlatformFile pf = result.files.single;
        return ResumeFileInfo(
          fileName: pf.name,
          fileSize: (pf.size / 1024.0).toString(),
          fileType: 'pdf',
          uploadDate: dateTimeFormatter(DateTime.now()),
          bytes: pf.bytes,
        );
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
