import 'dart:convert';

import 'package:jobspot/core/api_endpoints.dart' as endpoints;
import 'package:jobspot/sippo_data/model/custom_file_model/custom_file_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/cv_file_model.dart';
import 'package:jobspot/sippo_data/model/status_message_model/status_message_model.dart';

import 'package:jobspot/JopController/HttpClientController/http_client_controller.dart';
import 'package:jobspot/core/resource.dart';
import 'package:jobspot/core/status_response_code_checker.dart';
import '../model/profile_model/profile_resource_model/validate_property_cv_uploader_model.dart';

class CvUploaderRepo {
  static Future<Resource<CvModel?, dynamic>?> addCvFile(
      CustomFileModel cvFile) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.postMultipartRequest(
        endpoints.userCvEndpoint,
        multipartFile: cvFile.toMultipartFile(),
      );
      final responseString = await response.stream.bytesToString();
      print(
        "CvUploaderRepo.addCvFile: response data before decode = ${responseString}",
      );
      Map<String, dynamic> responseData = jsonDecode(responseString);
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => CvModel.fromJson(data),
        (errors) => ValidatePropCvUploaderModel.fromJson(errors),
      );
    } catch (e) {
      print("CvUploaderRepo.addCvFile error: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<Resource<StatusMessageModel?, dynamic>?>
      deleteCvFile() async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.delete(
        endpoints.userCvEndpoint,
      );
      print(
        "CvUploaderRepo.removeCvFile: response data before decode = ${response.body}",
      );
      Map<String, dynamic> responseData = jsonDecode(response.body);
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => StatusMessageModel.fromJson(data),
        (errors) => null,
      );
    } catch (e) {
      print("CvUploaderRepo.removeCvFile error: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }
}
