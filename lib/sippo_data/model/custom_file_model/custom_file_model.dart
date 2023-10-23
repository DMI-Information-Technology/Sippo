import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:jobspot/utils/helper.dart';
import 'package:path/path.dart';

class CustomFileModel {
  final String? fieldName;
  final String? type;
  final String? subtype;
  final File? file;
  final String? name;
  final Uint8List? bytes;
  final int? size;
  final DateTime? uploadDate;

  const CustomFileModel({
    this.file,
    this.fieldName,
    this.type,
    this.size,
    this.subtype,
    this.name,
    this.uploadDate,
  }) : bytes = null;

  const CustomFileModel.fromBytes({
    this.bytes,
    this.fieldName,
    this.type,
    this.size,
    this.subtype,
    this.name,
    this.uploadDate,
  }) : this.file = null;

  File? get bytesToFile {
    try {
      return bytes != null ? File.fromRawPath(bytes!) : null;
    } catch (e, s) {
      print(e);
      print(s);
      return null;
    }
  }

  List<int>? get bytesToList => bytes?.toList();

  Uint8List? get FileToBytes {
    try {
      return file?.readAsBytesSync();
    } catch (e, s) {
      print(e);
      print(s);
      return null;
    }
  }

  String? get filename => name ?? (file != null ? basename(file!.path) : null);

  bool get isFileNull => file == null && bytes == null;

  File? get asFile => file ?? bytesToFile;

  String get sizeToString => convertFileSize(size) ?? 'unknown file size';

  String get uploadDateToString =>
      dateTimeFormatter(uploadDate) ?? 'unknown upload file date';

  MultipartFile? toMultipartFile() {
    final currentFile = file;
    if (currentFile != null) {
      return MultipartFile(
        fieldName ?? 'file',
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
    final currentBytes = bytes;
    if (currentBytes != null) {
      return MultipartFile.fromBytes(
        fieldName ?? 'file',
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

  @override
  String toString() {
    return 'CustomFileModel{fileField: $fieldName, name: $name type: $type, subtype: $subtype, size: $size file: $file, bytes: $bytes,}';
  }

  CustomFileModel copyWithFile({
    String? fileField,
    String? type,
    String? subtype,
    File? file,
    String? name,
    int? size,
    DateTime? uploadDate,
  }) {
    return CustomFileModel(
      fieldName: fileField ?? this.fieldName,
      type: type ?? this.type,
      subtype: subtype ?? this.subtype,
      file: file ?? this.file,
      name: name ?? this.name,
      size: size ?? this.size,
      uploadDate: uploadDate ?? this.uploadDate,
    );
  }

  CustomFileModel copyWithBytes({
    String? fileField,
    String? type,
    String? subtype,
    String? name,
    Uint8List? bytes,
    int? size,
    DateTime? uploadDate,
  }) {
    return CustomFileModel.fromBytes(
      fieldName: fileField ?? this.fieldName,
      type: type ?? this.type,
      subtype: subtype ?? this.subtype,
      bytes: bytes ?? this.bytes,
      name: name ?? this.name,
      size: size ?? this.size,
      uploadDate: uploadDate ?? this.uploadDate,
    );
  }
}
