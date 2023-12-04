import 'dart:convert';

import 'package:jobspot/core/api_endpoints.dart' as endpoints;
import 'package:jobspot/core/resource.dart';
import 'package:jobspot/core/status_response_code_checker.dart';
import 'package:jobspot/sippo_controller/HttpClientController/http_client_controller.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/profession_user_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/professions_user_model.dart';

class ProfessionsRepo {
  static Future<Resource<List<ProfessionUserModel>?, dynamic>?>
      fetchProfessions() async {
    try {
      final response = await HttpClientController.instance.client.get(
        endpoints.professionsEndpoint,
      );

      late final responseData;
      final responseBody = jsonDecode(response.body);
      if (responseBody is List) {
        responseData = {'data': responseBody};
      } else {
        responseData = responseBody;
      }
      print(responseData);
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) {
          return List.of(data['data'])
              .map((e) => ProfessionUserModel.fromJson(e))
              .toList();
        },
        (errors) => null,
      );
    } catch (e, s) {
      print(s);
      print(e);
      return Resource.error(
        errorMessage: 'Invalid Response',
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<Resource<List<ProfessionUserModel>?, dynamic>?>
      fetchUserProfessions() async {
    try {
      final response = await HttpClientController.instance.client.get(
        endpoints.userProfessionEndpoint,
      );

      late final responseData;
      final responseBody = jsonDecode(response.body);
      if (responseBody is List) {
        responseData = {'data': responseBody};
      } else {
        responseData = responseBody;
      }
      print(responseData);
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) {
          return List.of(data['data'])
              .map((e) => ProfessionUserModel.fromJson(e))
              .toList();
        },
        (errors) => null,
      );
    } catch (e, s) {
      print(s);
      print(e);
      return Resource.error(
        errorMessage: 'Invalid Response',
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<
      Resource<List<ProfessionUserModel>?,
          ValidatePropProfessionsUserModel?>> updateUserProfessions(
      ProfessionsUserModel professions) async {
    try {
      final response = await HttpClientController.instance.client.put(
        endpoints.userProfessionEndpoint,
        data: professions.toJson(),
      );

      late final responseData;
      final responseBody = jsonDecode(response.body);
      if (responseBody is List) {
        responseData = {'data': responseBody};
      } else {
        responseData = responseBody;
      }
      print(responseData);
      return await StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) {
          return List.of(data['data'])
              .map((e) => ProfessionUserModel.fromJson(e))
              .toList();
        },
        (errors) => ValidatePropProfessionsUserModel.fromJson(errors),
      );
    } catch (e, s) {
      print(s);
      print(e);
      return Resource.error(
        errorMessage: 'Invalid Response',
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }
}
