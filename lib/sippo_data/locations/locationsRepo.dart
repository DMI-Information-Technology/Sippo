import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jobspot/core/api_endpoints.dart' as endpoints;
import 'package:jobspot/core/resource.dart';
import 'package:jobspot/core/status_response_code_checker.dart';
import 'package:jobspot/sippo_data/model/locations_model/location_address_model.dart';

abstract class LocationsRepo {
  static Future<Resource<List<LocationAddress>?, dynamic>?>
      fetchLocations() async {
    try {
      final response = await http.get(
        Uri.parse("${endpoints.baseUrl}/${endpoints.locationsEndpoint}"),
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
              .map((e) => LocationAddress.fromJson(e))
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
