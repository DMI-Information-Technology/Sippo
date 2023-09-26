import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
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
}
