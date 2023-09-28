import 'package:file_picker/file_picker.dart';
import 'package:jobspot/sippo_data/model/custom_file_model/custom_file_model.dart';

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
      allowedExtensions: ['jpg', 'pdf', 'png'],
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

  static Future<CustomFileModel?> uploadFileCv(
      {void Function(FilePickerStatus status)? onFileUploading}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'png'],
      onFileLoading: (status) {
        if (onFileUploading != null) onFileUploading(status);
      },
    );
    try {
      if (result != null) {
        final pf = result.files.single;
        final bytes = pf.bytes;
        if (bytes != null) {
          return CustomFileModel.fromBytes(
            fileField: 'cv',
            name: pf.name,
            bytes: bytes,
            type: checkFileType(
              type: pf.extension,
              neededTypes: ['png', 'jpg', 'jpeg'],
              inTrue: 'image',
              inFalse: 'application',
            ),
            size: pf.size,
            uploadDate: DateTime.now(),
            subtype: checkFileType(
              type: pf.extension,
              neededTypes: ['png', 'jpg', 'jpeg'],
              inTrue: pf.extension,
              inFalse: 'pdf',
            ),
          );
        } else {
          return null;
        }
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static String? checkFileType({
    String? type,
    required List<String> neededTypes,
    String? inFalse,
    String? inTrue,
  }) {
    return neededTypes.any((e) => type == e) ? inTrue : inFalse;
  }
}
