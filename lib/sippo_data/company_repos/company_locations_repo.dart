import 'dart:convert';

import 'package:jobspot/sippo_controller/HttpClientController/http_client_controller.dart';
import 'package:jobspot/core/api_endpoints.dart' as endpoints;
import 'package:jobspot/core/resource.dart';
import 'package:jobspot/core/status_response_code_checker.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/validate_property_work_location_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/vlidate_property_company_job_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/work_location_model.dart';

class CompanyLocationsRepo {
  static Future<
          Resource<WorkLocationModel?, ValidatePropertyWorkLocationModel?>?>
      addNewWorkPlace(WorkLocationModel workLocation) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.post(
        endpoints.companyLocations,
        data: workLocation.toJson(),
      );

      print(
          "CompanyLocationsRepo.addCompanyWorkPlace: response data before decode = ${response.body}");

      Map<String, dynamic> responseData = jsonDecode(response.body);
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => WorkLocationModel.fromJson(data),
        (errors) => ValidatePropertyWorkLocationModel.fromJson(errors),
      );
    } catch (e) {
      print("CompanyLocationsRepo.addCompanyWorkPlace error: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<
          Resource<WorkLocationModel?, ValidatePropertyWorkLocationModel?>?>
      updateCompanyWorkPlace(
          WorkLocationModel workLocation, int? resourceId) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.put(
          endpoints.companyLocations,
          data: workLocation.toJson(),
          resourceId: resourceId.toString());

      print(
          "CompanyLocationsRepo.updateCompanyWorkPlace: response data before decode = ${response.body}");

      Map<String, dynamic> responseData = jsonDecode(response.body);
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => WorkLocationModel.fromJson(data),
        (errors) => ValidatePropertyWorkLocationModel.fromJson(errors),
      );
    } catch (e) {
      print("CompanyLocationsRepo.updateCompanyWorkPlace error: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<Resource<List<WorkLocationModel>?, dynamic>?>
      fetchWorkLocations(
    Map<String, String> query,
  ) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.get(
        endpoints.companyLocations,
        queryParameter: query,
      );
      final responseBody = response.body;

      print(
          "CompanyLocationsRepo.fetchWorkPlaces: response data = ${responseBody}");
      print(
        "CompanyLocationsRepo.fetchWorkPlaces: response status code = ${response.statusCode}",
      );
      late final responseData;
      if (responseBody is List) {
        responseData = {'data': responseBody};
      } else {
        responseData = responseBody;
      }
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => List.of(data['data'])
            .map((e) => WorkLocationModel.fromJson(e))
            .toList(),
        (errors) => null,
      );
    } catch (e) {
      print("CompanyLocationsRepo.fetchWorkPlaces error: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<Resource<WorkLocationModel?, dynamic>?> getWorkPlaceById(
      int? workLocationId) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.get(
        endpoints.companyLocations,
        resourceId: workLocationId.toString(),
      );

      final responseString = response.body;
      print(
          "CompanyLocationsRepo.getWorkPlaceById: response data = $responseString");
      print(
        "CompanyLocationsRepo.getWorkPlaceById: response status code = ${response.statusCode}",
      );

      final responseData = jsonDecode(responseString);
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => WorkLocationModel.fromJson(data),
        (errors) => null,
      );
    } catch (e) {
      print("CompanyJobRepo.getJobById error: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<Resource<List<String>?, ValidatePropCompanyJobModel?>?>
      fetchEmploymentTypes() async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.get(
        endpoints.employmentTypesEndpoint,
      );
      print(
          "CompanyJobRepo.fetchEmploymentTypes: response data = ${response.body}");
      print(
        "CompanyJobRepo.fetchEmploymentTypes: response status code = ${response.statusCode}",
      );

      final responseData = jsonDecode(response.body);
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => List<String>.from(data.values),
        (errors) => null,
      );
    } catch (e) {
      print("CompanyJobRepo.fetchEmploymentTypes error: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

// static Future<Resource<Map<int, String>?, ValidatePropCompanyJobModel?>?>
//     fetchEmploymentTypesMap() async {
//   final httpController = HttpClientController.instance;
//   try {
//     final response = await httpController.client.get(
//       endpoints.employmentTypesEndpoint,
//     );
//     print(
//         "CompanyJobRepo.fetchEmploymentTypes: response data = ${response.body}");
//     print(
//       "CompanyJobRepo.fetchEmploymentTypes: response status code = ${response.statusCode}",
//     );
//
//     final responseData = jsonDecode(response.body);
//     return StatusResponseCodeChecker.checkStatusResponseCode(
//       responseData,
//       response.statusCode,
//       (data) => data.map((key, value) {
//         if (key.isNumericOnly) return MapEntry(int.parse(key), value);
//         return MapEntry();
//       }),
//       (errors) => null,
//     );
//   } catch (e) {
//     print("CompanyJobRepo.fetchEmploymentTypes error: $e");
//     return Resource.error(
//       errorMessage: e.toString(),
//       type: StatusType.INVALID_RESPONSE,
//     );
//   }
// }
}
