import 'dart:io';

import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

class CustomFileModel {
  final String? fileField;
  final String? type;
  final String? subtype;
  final File? file;

  CustomFileModel({
    this.file,
    this.fileField,
    this.type,
    this.subtype,
  });

  String? get filename => file != null ? basename(file!.path) : null;

  MultipartFile? toMultipartFile() {
    final currentFile = file;
    if (currentFile == null) return null;
    return MultipartFile(
      fileField ?? 'file',
      currentFile.readAsBytes().asStream(),
      currentFile.lengthSync(),
      filename: filename,
      contentType: type != null && subtype != null
          ? MediaType(
              type!,
              subtype!,
            )
          : null,
    );
  }

  CustomFileModel copyWith({
    String? fileField,
    String? type,
    String? subtype,
    File? file,
  }) {
    return CustomFileModel(
      fileField: fileField ?? this.fileField,
      type: type ?? this.type,
      subtype: subtype ?? this.subtype,
      file: file ?? this.file,
    );
  }
}
