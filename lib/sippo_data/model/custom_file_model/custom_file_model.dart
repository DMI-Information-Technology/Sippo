import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

import '../../../utils/helper.dart';

class CustomFileModel {
  final String? fileField;
  final String? type;
  final String? subtype;
  final File? file;
  final String? name;
  final Uint8List? bytes;
  final int? size;
  final DateTime? uploadDate;

  const CustomFileModel({
    this.file,
    this.fileField,
    this.type,
    this.size,
    this.subtype,
    this.name,
    this.uploadDate,
  }) : bytes = null;

  const CustomFileModel.fromBytes({
    this.bytes,
    this.fileField,
    this.type,
    this.size,
    this.subtype,
    this.name,
    this.uploadDate,
  }) : this.file = null;

  String? get filename => name ?? (file != null ? basename(file!.path) : null);

  bool get isFileNull => file == null && bytes == null;

  String get sizeToString => convertFileSize(size) ?? 'unknown file size';

  String get uploadDateToString =>
      dateTimeFormatter(uploadDate) ?? 'unknown upload file date';

  MultipartFile? toMultipartFile() {
    final currentFile = file;
    final currentBytes = bytes;
    if (currentFile != null)
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

    if (currentBytes != null) {
      return MultipartFile.fromBytes(
        fileField ?? 'file',
        currentBytes,
        filename: filename,
        contentType: type != null && subtype != null
            ? MediaType(
                type!,
                subtype!,
              )
            : null,
      );
    }
    return null;
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

  @override
  String toString() {
    return 'CustomFileModel{fileField: $fileField, name: $name type: $type, subtype: $subtype, size: $size file: $file, bytes: $bytes,}';
  }
}
