import 'dart:convert';

import 'package:jobspot/core/api_endpoints.dart' as endpoints;
import 'package:jobspot/core/header_api.dart';
import 'package:jobspot/core/resource.dart';
import 'package:jobspot/core/status_response_code_checker.dart';

import 'package:jobspot/sippo_controller/HttpClientController/http_client_controller.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/language_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/validate_property_language.dart';

class LanguageRepo {
  static Future<Resource<LanguageModel, ValidatePropLanguageModel?>?>
      addNewLanguage(LanguageModel language) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.post(
        endpoints.userLanguageEndpoint,
        data: language.toCustomJson(),
      );
      print(
        "LanguageRepo.addLanguage: response data before decode = ${response.body}",
      );
      Map<String, dynamic> responseData = jsonDecode(response.body);
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => LanguageModel.fromJson(data),
        (errors) => ValidatePropLanguageModel.fromJson(errors),
      );
    } catch (e) {
      print("LanguageRepo.addLanguage error: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<Resource<List<LanguageModel>, ValidatePropLanguageModel?>?>
      fetchLanguages({bool isUser = false}) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.get(
        isUser ? endpoints.userLanguageEndpoint : endpoints.languageEndpoint,
        headers: !isUser ? Header.defaultHeader : null,
      );
      print(
        "LanguageRepo.fetchLanguages: response data before decode = ${response.body}",
      );
      late final Map<String, dynamic> responseDataWrapper;
      final responseData = jsonDecode(response.body);
      print(
        "LanguageRepo.fetchLanguages: response run time type after decode = ${responseData.runtimeType}",
      );
      if (responseData is List) {
        responseDataWrapper = {'list': responseData};
      } else {
        responseDataWrapper = responseData;
      }
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseDataWrapper,
        response.statusCode,
        (data) {
          return List<Map<String, dynamic>>.from(data['list'])
              .map((e) => LanguageModel.fromJson(e))
              .toList()
              .cast<LanguageModel>();
        },
        (errors) => ValidatePropLanguageModel.fromJson(errors),
      );
    } catch (e) {
      print(e.runtimeType);
      print("LanguageRepo.fetchLanguages Exception: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<Resource<bool, ValidatePropLanguageModel?>?> deleteLanguageById(
      int? id) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.delete(
        endpoints.userLanguageEndpoint,
        resourceId: id.toString(),
      );
      print(
        "LanguageRepo.deleteLanguageById: response data before decode = ${response.body}",
      );

      late final Map<String, dynamic> responseData;
      if (response.body.isNotEmpty) {
        responseData = jsonDecode(response.body);
      } else {
        responseData = {};
      }
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => true,
        (errors) => null,
      );
    } catch (e) {
      print("LanguageRepo.deleteLanguageById error: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }
}
