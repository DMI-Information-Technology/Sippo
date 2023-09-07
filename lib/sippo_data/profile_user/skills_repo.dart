import 'dart:convert';

import 'package:jobspot/core/header_api.dart';

import '../../JopController/HttpClientController/http_client_controller.dart';
import '../../core/api_endpoints.dart' as endpoints;
import '../../core/resource.dart';
import '../../core/status_response_code_checker.dart';
import '../model/profile_model/profile_resource_model/skills_model.dart';
import '../model/profile_model/profile_resource_model/validate_property_skills.dart';
import '../model/status_message_model/status_message_model.dart';

class SkillsRepo {
  static Future<Resource<StatusMessageModel, ValidatePropSkillsModel?>?>
      addSkills(
    SkillsModel skills,
  ) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.post(
        endpoints.userSkillsEndpoint,
        data: skills.toJson(),
      );
      print(
        "SkillsRepo.addSkills: response data before decode = ${response.body}",
      );
      Map<String, dynamic> responseData = jsonDecode(response.body);
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => StatusMessageModel.fromJson(data),
        (errors) => ValidatePropSkillsModel.fromJson(errors),
      );
    } catch (e) {
      print("SkillsRepo.addSkills error: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<Resource<List<String>, ValidatePropSkillsModel?>?> fetchSkills({
    bool isUser = false,
  }) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.get(
        isUser ? endpoints.userSkillsEndpoint : endpoints.skillsEndpoint,
        headers: !isUser ? Header.defaultHeader : null,
      );
      print(
        "SkillsRepo.fetchSkills: response data before decode = ${response.body}",
      );
      print(
        "SkillsRepo.fetchSkills: response status code = ${response.statusCode}",
      );
      late final Map<String, dynamic> responseDataWrapper;
      final responseData = jsonDecode(response.body);
      print(
        "SkillsRepo.fetchSkills: response run time type after decode = ${responseData.runtimeType}",
      );
      if (responseData.runtimeType == List) {
        responseDataWrapper = {'skills': responseData};
      } else {
        responseDataWrapper = responseData;
      }
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseDataWrapper,
        response.statusCode,
        (data) {
          return List<Map<String, dynamic>>.from(data['skills'] ?? [])
              .map((e) => e['skill'])
              .toList()
              .cast<String>();
        },
        (errors) => ValidatePropSkillsModel.fromJson(errors),
      );
    }  catch (e) {
      print(e.runtimeType);
      print("SkillsRepo.fetchSkills Exception: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }
}
