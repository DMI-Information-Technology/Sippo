import 'dart:convert';

import 'package:sippo/core/api_endpoints.dart' as endpoints;
import 'package:sippo/core/resource.dart';
import 'package:sippo/core/status_response_code_checker.dart';
import 'package:sippo/sippo_controller/HttpClientController/http_client_controller.dart';
import 'package:sippo/sippo_data/model/status_message_model/status_message_model.dart';

class ReportRepo {
  static Future<Resource<StatusMessageModel, dynamic>> report(
      Map<String, dynamic> data) async {
    try {
      final httpController = HttpClientController.instance;

      final response = await httpController.client.post(
        endpoints.reportEndpoint,
      );

      final responseData = jsonDecode(response.body);

      return StatusResponseCodeChecker.checkStatusResponseCode(
          responseData,
          response.statusCode,
          (data) => StatusMessageModel.fromJson(data),
          (errors) => null);
    } catch (e, s) {
      print(e);
      print(s);
      return Resource.error(
        type: StatusType.INVALID_RESPONSE,
        errorMessage: 'invalid response',
      );
    }
  }
}
