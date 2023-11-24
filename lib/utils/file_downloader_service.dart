import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:jobspot/core/resource.dart';
import 'package:jobspot/core/status_response_code_checker.dart';
import 'package:jobspot/sippo_data/model/custom_file_model/custom_file_model.dart';
import 'package:jobspot/utils/helper.dart';
import 'package:jobspot/utils/storage_permission_service.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class FileDownloader {
  final _client = HttpClient();

  Future<void> downloadFileListener({
    required String url,
    void Function(List<int>)? onData,
    void Function()? onDone,
    void Function(dynamic e, dynamic s)? onError,
  }) async {
    try {
      final request = await _client.getUrl(Uri.parse(url));
      final response = await request.close();
      response.listen(
        onData,
        onDone: onDone,
        onError: onError,
      );
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<Resource<CustomFileModel, dynamic>?> downloadFile({
    String? fileName,
    required String url,
  }) async {
    try {
      print("Waiting...");
      final request = await _client.getUrl(Uri.parse(url));
      final response = await request.close();
      final responseData = await response.toBytes();
      print("Done!");
      return StatusResponseCodeChecker.checkStatusResponseCode(
          {'bytes': responseData},
          response.statusCode,
          (data) => CustomFileModel.fromBytes(
                bytes: data['bytes'],
                name: 'data',
              ),
          (errors) => null);
    } catch (e, s) {
      print(e);
      print(s);
      return Resource.error(
        errorMessage:
            'Something Wrong is Happened While Retrieving The Response.',
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<void> openFile(String fileUrl,
      {String? size, void Function(bool value)? fn}) async {
    fn?.call(true);
    final hasPermission = await StoragePermissionsService.storageRequested(
      DeviceInfoPlugin(),
    );
    if (!hasPermission) {
      print('no permission to open the file');
      fn?.call(false);
      return;
    }
    final String fileName = fileUrl.split('/').last;
    final downloadData = <int>[];
    Directory downloadDirectory;
    if (Platform.isIOS) {
      downloadDirectory = await getApplicationDocumentsDirectory();
    } else {
      downloadDirectory = Directory('/storage/emulated/0/Download');
      if (!downloadDirectory.existsSync())
        downloadDirectory = (await getExternalStorageDirectory())!;
    }
    final filePathName = "${downloadDirectory.path}/$fileName";
    final savedFile = File(filePathName);
    print('FileDownloader.openFile: created file');
    if (savedFile.existsSync()) {
      print('FileDownloader.openFile: saved file is already exists');
      print('FileDownloader.openFile: file path  = ${savedFile.path}');
      fn?.call(false);
      OpenFile.open(savedFile.path);
      return;
    }
    final fileSize = convertStringFileSizeToNumber(size);
    final fileDownloader = FileDownloader();
    fileDownloader.downloadFileListener(
      url: fileUrl,
      onData: (d) {
        print(calculateDownloadProgressFile(downloadData.length, fileSize));
        downloadData.addAll(d);
      },
      onDone: () {
        print(calculateDownloadProgressFile(downloadData.length, fileSize));
        final raf = savedFile.openSync(mode: FileMode.write);
        raf.writeFromSync(downloadData);
        raf.closeSync();
        fileDownloader.close();
        fn?.call(false);
        OpenFile.open(savedFile.path);
      },
      onError: (e, s) {
        print(e);
        print(s);
        fn?.call(false);
        fileDownloader.close();
      },
    );
  }

  void close() => _client.close();

// @override
// void onClose() {
//   close();
//   super.onClose();
// }
}
