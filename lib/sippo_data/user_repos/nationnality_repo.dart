import 'dart:convert';

import 'package:sippo/core/api_endpoints.dart' as endpoints;
import 'package:sippo/core/resource.dart';
import 'package:sippo/core/status_response_code_checker.dart';
import 'package:sippo/sippo_controller/HttpClientController/http_client_controller.dart';
import 'package:sippo/sippo_data/model/profile_model/profile_resource_model/nationality_model.dart';

class NationalityRepo {
  static Future<Resource<List<NationalityModel>?, dynamic>>
      fetchNationality() async {
    try {
      final response = await HttpClientController.instance.client
          .get(endpoints.nationalitiesEndpoint);
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
              .map((e) => NationalityModel.fromJson(e))
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
}
