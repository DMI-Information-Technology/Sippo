import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:jobspot/utils/file_downloader_service.dart';
import 'package:jobspot/utils/helper.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class StoragePermissionsService {
  static Future<PermissionStatus> _androidRequester(
    AndroidDeviceInfo androidInfo,
  ) async {
    final sdkInt = androidInfo.version.sdkInt;
    final releaseString = androidInfo.version.release.split('.').first.trim();
    print("release String:  $releaseString");
    late final releaseNumber;
    if (releaseString.isNumericOnly) {
      releaseNumber = int.parse(releaseString);
    } else {
      return PermissionStatus.denied;
    }
    late final PermissionStatus androidStatus;
    if (sdkInt >= 30 || releaseNumber >= 11) {
      androidStatus = await Permission.manageExternalStorage.status;
      if (androidStatus.isGranted) return PermissionStatus.granted;
      return await Permission.manageExternalStorage.request();
    } else {
      androidStatus = await Permission.storage.status;
      if (androidStatus.isGranted) return PermissionStatus.granted;
      return await Permission.storage.request();
    }
  }

  static Future<PermissionStatus> _iosRequester(
    IosDeviceInfo iosInfo,
  ) async {
    final iosStatus = await Permission.storage.status;
    if (iosStatus.isGranted) return PermissionStatus.granted;
    return await Permission.storage.request();
  }

  static Future<bool> storageRequested(DeviceInfoPlugin deviceInfo) async {
    late final PermissionStatus status;
    if (Platform.isAndroid) {
      status = await _androidRequester(await deviceInfo.androidInfo);
    } else if (Platform.isIOS) {
      status = await _iosRequester(await deviceInfo.iosInfo);
    }
    return status.isGranted;
  }

  static Future<void> openFile(String fileUrl,
      {String? size, void Function(bool value)? fn}) async {
    fn?.call(true);
    final hasPermission = await StoragePermissionsService.storageRequested(
      DeviceInfoPlugin(),
    );
    if (!hasPermission) {
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
    if (savedFile.existsSync()) {
      OpenFile.open(savedFile.path);
      fn?.call(false);
      return;
    }
    final fileSize = convertStringFileSize(size);
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
}
