import 'dart:convert';

import 'package:jobspot/sippo_controller/HttpClientController/http_client_controller.dart';
import 'package:jobspot/core/api_endpoints.dart' as endpoints;
import 'package:jobspot/core/resource.dart';
import 'package:jobspot/core/status_response_code_checker.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/validate_property_work_experiences_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/work_experiences_model.dart';

class WorkExperiencesRepo {
  static Future<
          Resource<WorkExperiencesModel, ValidatePropWorkExperiencesModel?>?>
      addWorkExperiences(WorkExperiencesModel workEx) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.post(
        endpoints.workExperiencesEndpoint,
        data: workEx.toJsonNonId(),
      );
      print(
        "WorkExperiencesRepo.addWorkExperiences: response data before decode = ${response.body}",
      );
      Map<String, dynamic> responseData = jsonDecode(response.body);
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => WorkExperiencesModel.fromJson(data),
        (errors) => ValidatePropWorkExperiencesModel.fromJson(errors),
      );
    } catch (e) {
      print("WorkExperiencesRepo.addWorkExperiences error: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<
          Resource<WorkExperiencesModel, ValidatePropWorkExperiencesModel?>?>
      updateWorkExperiencesById(
          WorkExperiencesModel workEx, int? workExId) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.put(
        endpoints.workExperiencesEndpoint,
        resourceId: workExId.toString(),
        data: workEx.toJsonNonId(),
      );
      print(
        "WorkExperiencesRepo.updateWorkExperiences: response data before decode = ${response.body}",
      );
      Map<String, dynamic> responseData = jsonDecode(response.body);
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => WorkExperiencesModel.fromJson(data),
        (errors) => ValidatePropWorkExperiencesModel.fromJson(errors),
      );
    } catch (e) {
      print("WorkExperiencesRepo.updateWorkExperiences error: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<
      Resource<List<WorkExperiencesModel>,
          ValidatePropWorkExperiencesModel?>?> fetchWorkExperiences() async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.get(
        endpoints.workExperiencesEndpoint,
      );
      print(
        "WorkExperiencesRepo.fetchWorkExperiences: response data before decode = ${response.body}",
      );
      print(
        "WorkExperiencesRepo.fetchWorkExperiences: response status code = ${response.statusCode}",
      );
      late final Map<String, dynamic> responseDataWrapper;
      final responseData = jsonDecode(response.body);
      print(
        "WorkExperiencesRepo.fetchWorkExperiences: response run time type after decode = ${responseData.runtimeType}",
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
              .map((e) => WorkExperiencesModel.fromJson(e))
              .toList();
        },
        (errors) => ValidatePropWorkExperiencesModel.fromJson(errors),
      );
    } catch (e) {
      print(e.runtimeType);
      print("WorkExperiencesRepo.fetchWorkExperiences Exception: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<
          Resource<WorkExperiencesModel, ValidatePropWorkExperiencesModel?>?>
      getWorkExperiencesById(int id) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.get(
        endpoints.workExperiencesEndpoint,
        resourceId: id.toString(),
      );
      print(
        "WorkExperiencesRepo.getWorkExperiencesById: response data before decode = ${response.body}",
      );
      print(
        "WorkExperiencesRepo.getWorkExperiencesById: response status code = ${response.statusCode}",
      );
      final responseData = jsonDecode(response.body);
      print(
        "WorkExperiencesRepo.getWorkExperiencesById: response run time type after decode = ${responseData.runtimeType}",
      );

      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) {
          return WorkExperiencesModel.fromJson(data);
        },
        (errors) => ValidatePropWorkExperiencesModel.fromJson(errors),
      );
    } catch (e) {
      print(e.runtimeType);
      print("WorkExperiencesRepo.getWorkExperiencesById Exception: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<Resource<bool, ValidatePropWorkExperiencesModel?>?>
      deleteWorkExperiencesById(int? id) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.delete(
        endpoints.workExperiencesEndpoint,
        resourceId: id.toString(),
      );
      print(
        "WorkExperiencesRepo.deleteWorkExperiencesById: response data before decode = ${response.body}",
      );
      print(
        "WorkExperiencesRepo.deleteWorkExperiencesById: response status code = ${response.statusCode}",
      );
      late final Map<String, dynamic> responseData;
      if (response.body.isNotEmpty) {
        responseData = jsonDecode(response.body);
      } else {
        responseData = {};
      }
      print(
        "WorkExperiencesRepo.deleteWorkExperiencesById: response run time type after decode = ${responseData.runtimeType}",
      );

      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => true,
        (errors) => null,
      );
    } catch (e) {
      print(e.runtimeType);
      print("WorkExperiencesRepo.deleteWorkExperiencesById Exception: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }
}
