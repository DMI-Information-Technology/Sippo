import 'dart:convert';

import 'package:sippo/core/api_endpoints.dart' as endpoints;
import 'package:sippo/core/resource.dart';
import 'package:sippo/core/status_response_code_checker.dart';
import 'package:sippo/sippo_controller/HttpClientController/http_client_controller.dart';
import 'package:sippo/sippo_data/model/profile_model/company_profile_resource_model/validate_property_work_location_model.dart';
import 'package:sippo/sippo_data/model/profile_model/company_profile_resource_model/work_location_model.dart';
import 'package:sippo/sippo_data/model/status_message_model/status_message_model.dart';

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

  static Future<Resource<StatusMessageModel?, dynamic>?> deleteWorkPlaceById(
      int? workLocationId) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.delete(
        endpoints.companyLocations,
        resourceId: workLocationId.toString(),
      );

      final responseString = response.body;
      print(
          "CompanyLocationsRepo.deleteWorkPlaceById: response data = $responseString");
      print(
        "CompanyLocationsRepo.deleteWorkPlaceById: response status code = ${response.statusCode}",
      );

      late final responseData;
      if (responseString.trim().isEmpty)
        responseData = {'message': 'the work place was deleted successfully.'};
      else
        responseData = jsonDecode(responseString);

      return await StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => StatusMessageModel.fromJson(data),
        (errors) => null,
      );
    } catch (e) {
      print("CompanyJobRepo.deleteWorkPlaceById error: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }
}
