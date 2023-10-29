import 'dart:convert';

import 'package:jobspot/JopController/HttpClientController/http_client_controller.dart';
import 'package:jobspot/core/api_endpoints.dart' as endpoints;
import 'package:jobspot/core/resource.dart';
import 'package:jobspot/core/status_response_code_checker.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/validate_property_projects_model.dart';

import '../model/profile_model/profile_resource_model/user_projects_model.dart';

class UserProjectRepo {
  static Future<Resource<UserProjectsModel, ValidatePropertyProjectsModel?>?>
      addProject(UserProjectsModel project) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.post(
        endpoints.userProjectsEndpoint,
        data: project.toJson(),
      );
      print(
        "UserProjectRepo.addWorkProjects: response data before decode = ${response.body}",
      );
      Map<String, dynamic> responseData = jsonDecode(response.body);
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => UserProjectsModel.fromJson(data),
        (errors) => ValidatePropertyProjectsModel.fromJson(errors),
      );
    } catch (e) {
      print("UserProjectRepo.addWorkProjects error: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<Resource<UserProjectsModel, ValidatePropertyProjectsModel?>?>
      updateProjectsById(
    UserProjectsModel project,
    int? projectId,
  ) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.put(
        endpoints.userProjectsEndpoint,
        resourceId: projectId.toString(),
        data: project.toJson(),
      );
      print(
        "UserProjectRepo.updateProjectsById: response data before decode = ${response.body}",
      );
      Map<String, dynamic> responseData = jsonDecode(response.body);
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => UserProjectsModel.fromJson(data),
        (errors) => ValidatePropertyProjectsModel.fromJson(errors),
      );
    } catch (e) {
      print("UserProjectRepo.updateProjectsById error: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<Resource<List<UserProjectsModel>, dynamic>?>
      fetchProjects() async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.get(
        endpoints.userProjectsEndpoint,
      );
      print(
        "UserProjectRepo.fetchProjects: "
        "response data before decode = ${response.body}",
      );
      print(
        "UserProjectRepo.fetchProjects: response status code = ${response.statusCode}",
      );
      late final Map<String, dynamic> responseDataWrapper;
      final responseData = jsonDecode(response.body);
      print(
        "UserProjectRepo.fetchProjects: response run time type after decode = ${responseData.runtimeType}",
      );
      if (responseData.runtimeType == List) {
        responseDataWrapper = {'list': responseData};
      } else {
        responseDataWrapper = responseData;
      }
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseDataWrapper,
        response.statusCode,
        (data) => List.of(data['list'])
            .map((e) => UserProjectsModel.fromJson(e))
            .toList(),
        (errors) => null,
      );
    } catch (e) {
      print(e.runtimeType);
      print("UserProjectRepo.fetchProjects Exception: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<Resource<UserProjectsModel, dynamic>?> getProjectById(
      int id) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.get(
        endpoints.userProjectsEndpoint,
        resourceId: id.toString(),
      );
      print(
        "UserProjectRepo.getProjectById: response data before decode = ${response.body}",
      );
      print(
        "UserProjectRepo.getProjectById: response status code = ${response.statusCode}",
      );
      final responseData = jsonDecode(response.body);
      print(
        "UserProjectRepo.getProjectById: response run time type after decode = ${responseData.runtimeType}",
      );

      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) {
          return UserProjectsModel.fromJson(data);
        },
        (errors) => null,
      );
    } catch (e) {
      print(e.runtimeType);
      print("UserProjectRepo.getProjectById Exception: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<Resource<bool, dynamic>?> deleteProjectById(int? id) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.delete(
        endpoints.userProjectsEndpoint,
        resourceId: id.toString(),
      );
      print(
        "UserProjectRepo.deleteProjectById: response data before decode = ${response.body}",
      );
      print(
        "UserProjectRepo.deleteProjectById: response status code = ${response.statusCode}",
      );
      late final Map<String, dynamic> responseData;
      if (response.body.isNotEmpty) {
        responseData = jsonDecode(response.body);
      } else {
        responseData = {};
      }
      print(
        "UserProjectRepo.deleteProjectById: response run time type after decode = ${responseData.runtimeType}",
      );

      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => true,
        (errors) => null,
      );
    } catch (e) {
      print(e.runtimeType);
      print("UserProjectRepo.deleteProjectById Exception: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }
}
