import 'dart:io';

import 'package:get/get_connect/http/src/request/request.dart';
import 'package:jobspot/core/resource.dart';
import 'package:jobspot/core/status_response_code_checker.dart';
import 'package:jobspot/sippo_data/model/custom_file_model/custom_file_model.dart';

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
    void Function(List<int>)? onData,
    void Function()? onDone,
    void Function(dynamic e, dynamic s)? onError,
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

  void close() {
    _client.close();
  }
}
