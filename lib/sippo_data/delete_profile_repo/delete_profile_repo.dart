import 'dart:convert';

import 'package:sippo/core/resource.dart';
import 'package:sippo/core/status_response_code_checker.dart';
import 'package:sippo/sippo_controller/HttpClientController/http_client_controller.dart';
import 'package:sippo/sippo_data/model/status_message_model/status_message_model.dart';

import 'validate_delete_profile.dart';

class DeleteProfileRepo {
  static Future<Resource<StatusMessageModel?, ValidatePropDeleteProfile?>>
      deleteProfile({required String endpoint, String? password}) async {
    try {
      final response = await HttpClientController.instance.client.delete(
        endpoint,
        data: {'password': password},
      );
      final responseData = jsonDecode(response.body);
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => StatusMessageModel.fromJson(data),
        (errors) => ValidatePropDeleteProfile.fromJson(errors),
      );
    } catch (e, s) {
      print(e);
      print(s);
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }
}
