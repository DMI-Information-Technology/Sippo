import 'dart:convert';

import 'package:jobspot/utils/api_endpoints.dart' as endpoints;

import 'package:http/http.dart' as http;

import '../model/specializations_model/specializations_model.dart';

class SpecializationRepo {
  static Future<List<SpecializationModel>?> fetchSpecializations() async {
    try {
      final response = await http.get(
        Uri.parse("${endpoints.baseUrl}/${endpoints.specializationEndpoint}"),
      );
      if (response.statusCode == 200) {
        final responseData =
            jsonDecode(response.body) as List<dynamic>;
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
}
