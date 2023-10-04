import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jobspot/core/api_endpoints.dart' as endpoints;
import 'package:jobspot/core/resource.dart';
import 'package:jobspot/core/status_response_code_checker.dart';

import '../model/specializations_model/specializations_model.dart';

class SpecializationRepo {
  static Future<List<SpecializationModel>?> fetchSpecializations() async {
    try {
      final response = await http.get(
        Uri.parse("${endpoints.baseUrl}/${endpoints.specializationEndpoint}"),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body) as List<dynamic>;
        print(responseData);
        return responseData
            .map((item) => SpecializationModel.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to fetch specializations');
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<Resource<List<SpecializationModel>?, dynamic>?>
      fetchSpecializationsResource() async {
    try {
      final response = await http.get(
        Uri.parse("${endpoints.baseUrl}/${endpoints.specializationEndpoint}"),
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
              .map((e) => SpecializationModel.fromJson(e))
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
