import 'dart:convert';
import 'dart:io';
import 'package:jobspot/JopController/HttpClientController/http_client_controller.dart';
import 'package:jobspot/core/resource.dart';
import 'package:jobspot/core/status_response_code_checker.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/validate_property_work_experiences_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/work_experiences_model.dart';
import 'package:jobspot/core/api_endpoints.dart' as endpoints;

class WorkExperiencesRepo {
  static Future<
          Resource<WorkExperiencesModel, ValidatePropertyWorkExperiencesModel>?>
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
        (errors) => ValidatePropertyWorkExperiencesModel.fromJson(errors),
      );
    } on SocketException catch (e) {
      print(
        "WorkExperiencesRepo.addWorkExperiences SocketException: ${e.message}\n"
        "WorkExperiencesRepo.addWorkExperiences SocketException: ${e.osError}",
      );
      return null;
    } catch (e) {
      print("WorkExperiencesRepo.addWorkExperiences error: $e");
      return null;
    }
  }

  static Future<
          Resource<WorkExperiencesModel, ValidatePropertyWorkExperiencesModel>?>
      updateWorkExperiencesById(WorkExperiencesModel workEx,int? workExId) async {
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
        (errors) => ValidatePropertyWorkExperiencesModel.fromJson(errors),
      );
    } on SocketException catch (e) {
      print(
        "WorkExperiencesRepo.addWorkExperiences SocketException: ${e.message}\n"
        "WorkExperiencesRepo.addWorkExperiences SocketException: ${e.osError}",
      );
      return null;
    } catch (e) {
      print("WorkExperiencesRepo.addWorkExperiences error: $e");
      return null;
    }
  }

  static Future<
      Resource<List<WorkExperiencesModel>,
          ValidatePropertyWorkExperiencesModel>?> fetchWorkExperiences() async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.get(
        endpoints.workExperiencesEndpoint,
      );
      print(
        "WorkExperiencesRepo.addWorkExperiences: response data before decode = ${response.body}",
      );
      late final Map<String, dynamic> responseDataWrapper;
      final responseData = jsonDecode(response.body);
      print(
        "WorkExperiencesRepo.addWorkExperiences: response run time type after decode = ${responseData.runtimeType}",
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
        (errors) => ValidatePropertyWorkExperiencesModel.fromJson(errors),
      );
    } on SocketException catch (e) {
      print(
        "WorkExperiencesRepo.addWorkExperiences SocketException: ${e.message}\n"
        "WorkExperiencesRepo.addWorkExperiences SocketException: ${e.osError}",
      );
      return null;
    } catch (e) {
      print(e.runtimeType);
      print("WorkExperiencesRepo.addWorkExperiences Exception: $e");
      return null;
    }
  }
}
