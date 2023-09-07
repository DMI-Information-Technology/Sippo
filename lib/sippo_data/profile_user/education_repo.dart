import 'dart:convert';

import 'package:jobspot/JopController/HttpClientController/http_client_controller.dart';
import 'package:jobspot/core/api_endpoints.dart' as endpoints;
import 'package:jobspot/core/resource.dart';
import 'package:jobspot/core/status_response_code_checker.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/education_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/validate_property_education.dart';

class EducationRepo {
  static Future<Resource<EducationModel?, ValidatePropEducationModel?>?>
      addEducation(EducationModel edu) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.post(
        endpoints.educationsEndpoint,
        data: edu.toJsonNonId(),
      );
      print(
        "EducationRepo.addEducation: response data before decode = ${response.body}",
      );
      Map<String, dynamic> responseData = jsonDecode(response.body);
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => EducationModel.fromJson(data),
        (errors) => ValidatePropEducationModel.fromJson(errors),
      );
    } catch (e) {
      print("EducationRepo.addEducation error: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<Resource<EducationModel?, ValidatePropEducationModel?>?>
      updateEducationById(EducationModel edu, int? eduId) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.put(
        endpoints.educationsEndpoint,
        resourceId: eduId.toString(),
        data: edu.toJsonNonId(),
      );
      print(
        "EducationRepo.updateEducationById: response data before decode = ${response.body}",
      );
      Map<String, dynamic> responseData = jsonDecode(response.body);
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => EducationModel.fromJson(data),
        (errors) => ValidatePropEducationModel.fromJson(errors),
      );
    } catch (e) {
      print("EducationRepo.updateEducationById error: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<Resource<List<EducationModel>?, ValidatePropEducationModel?>?>
      fetchEducations() async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.get(
        endpoints.educationsEndpoint,
      );
      print(
        "EducationRepo.fetchEducations: response data before decode = ${response.body}",
      );
      print(
        "EducationRepo.fetchEducations: response status code = ${response.statusCode}",
      );
      late final Map<String, dynamic> responseDataWrapper;
      final responseData = jsonDecode(response.body);
      print(
        "EducationRepo.fetchEducations: response run time type after decode = ${responseData.runtimeType}",
      );
      if (responseData.runtimeType == List) {
        responseDataWrapper = {'list': responseData};
      } else {
        responseDataWrapper = responseData;
      }
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseDataWrapper,
        response.statusCode,
        (data) {
          return List.of(data['list'])
              .map((e) => EducationModel.fromJson(e))
              .toList();
        },
        (errors) => ValidatePropEducationModel.fromJson(errors),
      );
    } catch (e) {
      print(e.runtimeType);
      print("EducationRepo.fetchEducations Exception: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<Resource<EducationModel?, ValidatePropEducationModel?>?>
      getEducationById(int id) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.get(
        endpoints.educationsEndpoint,
        resourceId: id.toString(),
      );
      print(
        "EducationRepo.getEducationById: response data before decode = ${response.body}",
      );
      print(
        "EducationRepo.getEducationById: response status code = ${response.statusCode}",
      );
      final responseData = jsonDecode(response.body);
      print(
        "EducationRepo.getEducationById: response run time type after decode = ${responseData.runtimeType}",
      );

      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) {
          return EducationModel.fromJson(data);
        },
        (errors) => ValidatePropEducationModel.fromJson(errors),
      );
    } catch (e) {
      print(e.runtimeType);
      print("EducationRepo.getEducationById: Exception: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<Resource<bool, ValidatePropEducationModel?>?>
      deleteEducationById(int? id) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.delete(
        endpoints.educationsEndpoint,
        resourceId: id.toString(),
      );
      print(
        "EducationRepo.deleteEducationById: response data before decode = ${response.body}",
      );
      print(
        "EducationRepo.deleteEducationById: response status code = ${response.statusCode}",
      );
      late final Map<String, dynamic> responseData;
      if (response.body.isNotEmpty) {
        responseData = jsonDecode(response.body);
      } else {
        responseData = {};
      }
      print(
        "EducationRepo.deleteEducationById: response run time type after decode = ${responseData.runtimeType}",
      );

      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => true,
        (errors) => null,
      );
    } catch (e) {
      print(e.runtimeType);
      print("EducationRepo.deleteEducationById Exception: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }
}
