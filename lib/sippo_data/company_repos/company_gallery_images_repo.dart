import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jobspot/sippo_controller/HttpClientController/http_client_controller.dart';
import 'package:jobspot/core/api_endpoints.dart' as endpoints;
import 'package:jobspot/core/resource.dart';
import 'package:jobspot/core/status_response_code_checker.dart';
import 'package:jobspot/sippo_data/model/custom_file_model/custom_file_model.dart';
import 'package:jobspot/sippo_data/model/image_resource_model/image_resource_model.dart';

import '../model/status_message_model/status_message_model.dart';

class CompanyGalleryImagesRepo {
  static Future<Resource<List<ImageResourceModel?>?, dynamic>>
      uploadCompanyImages(
    List<CustomFileModel?> images,
  ) async {
    try {
      final multipartFiles = <http.MultipartFile>[];
      for (final file in images) {
        final multipartFile = file?.toMultipartFile();
        // print(multipartFile?.length);
        if (multipartFile != null) multipartFiles.add(multipartFile);
      }
      final response = await HttpClientController.instance.client
          .postMultipartRequestFromList(
        endpoints.companyGalleryImagesEndpoint,
        multipartFiles: multipartFiles,
      );
      final responseString = await response.stream.bytesToString();
      print(
        "CompanyGalleryImagesRepo.sendCompanyImages: response data before decode = ${responseString}",
      );
      final responseBody = jsonDecode(responseString);
      late final responseData;
      if (responseBody is List) {
        responseData = {'data': responseBody};
      } else {
        responseData = responseBody;
      }
      return await StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => List.of(data['data'])
            .map((e) => ImageResourceModel.fromJson(e))
            .toList(),
        (errors) => null,
      );
    } catch (e, s) {
      print(e);
      print(s);
      return Resource.error(
        errorMessage: 'Invalid response',
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<Resource<StatusMessageModel, dynamic>> removeImageCompany(
    int? imageId,
  ) async {
    try {
      final response = await HttpClientController.instance.client.delete(
        endpoints.removeCompanyImageEndpoint,
        resourceId: imageId.toString(),
      );
      late final responseData;
      if (response.body.trim().isNotEmpty)
        responseData = jsonDecode(response.body);
      responseData = <String, dynamic>{};
      print(
        "CompanyGalleryImagesRepo.sendCompanyImages: response data before decode = ${responseData}",
      );

      return await StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => StatusMessageModel(message: 'Image removed successfully.'),
        (errors) => null,
      );
    } catch (e, s) {
      print(e);
      print(s);
      return Resource.error(
        errorMessage: 'Invalid response',
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }
}
