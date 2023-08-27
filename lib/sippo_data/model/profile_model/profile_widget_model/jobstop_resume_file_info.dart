import 'dart:typed_data';

class ResumeFileInfo {
  String? uploadDate;
  String? fileSize;
  String? fileType;
  String? filePath;
  String? fileName;
  Uint8List? bytes;

  static ResumeFileInfo? getNull() => null;

  ResumeFileInfo({
    this.uploadDate,
    this.fileSize,
    this.fileType,
    this.filePath,
    this.fileName,
    this.bytes,
  });

  factory ResumeFileInfo.fromJson(Map<String, dynamic> json) {
    return ResumeFileInfo(
      uploadDate: json["uploadDate"],
      fileSize: json["fileSize"],
      fileType: json["fileType"],
      filePath: json["filePath"],
      fileName: json["fileName"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uploadDate": this.uploadDate,
      "fileSize": this.fileSize,
      "fileType": this.fileType,
      "filePath": this.filePath,
      "fileName": this.fileName,
    };
  }

  @override
  String toString() {
    return 'ResumeFileInfo{uploadDate: $uploadDate, fileSize: $fileSize kB, fileType: $fileType, filePath: $filePath, fileName: $fileName}';
  }
//
}
