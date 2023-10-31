import 'dart:convert';

import 'package:jobspot/core/api_endpoints.dart' as endpoints;

import 'package:jobspot/sippo_controller/HttpClientController/http_client_controller.dart';
import 'package:jobspot/core/resource.dart';
import 'package:jobspot/core/status_response_code_checker.dart';
import '../model/pagination_company_models/posts_pagination_model.dart';
import '../model/profile_model/company_profile_resource_model/company_user_profile_view_model.dart';

class CompanyUserProfileViewRepo {
  static Future<Resource<PaginationModel<ProfileViewResourceModel>?, dynamic>?>
      fetchUserProfilesView(
    Map<String, String> query,
  ) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.get(
        endpoints.companyUserProfileViewEndpoint,
        queryParameter: query,
      );

      print(
          "CompanyUserProfileViewRepo.fetchUserProfilesView: response data = ${response.body}");
      print(
        "CompanyUserProfileViewRepo.fetchUserProfilesView: response status code = ${response.statusCode}",
      );

      final responseData = jsonDecode(response.body);
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => PaginationModel.fromJson(
          data,
          dataConverter: (item) => ProfileViewResourceModel.fromJson(item),
        ),
        (errors) => null,
      );
    } catch (e) {
      print("CompanyUserProfileViewRepo.fetchUserProfilesView error: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<Resource<ProfileViewResourceModel?, dynamic>?>
      getUserProfileViewById(int? profileId) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.get(
        endpoints.companyUserProfileViewEndpoint,
        resourceId: profileId.toString(),
      );

      final responseString = response.body;
      print(
          "CompanyUserProfileViewRepo.getUserProfileViewById: response data = $responseString");
      print(
        "CompanyUserProfileViewRepo.getUserProfileViewById: response status code = ${response.statusCode}",
      );
      final responseData = jsonDecode(responseString);
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => ProfileViewResourceModel.fromJson(data),
        (errors) => null,
      );
    } catch (e) {
      print("CompanyUserProfileViewRepo.getUserProfileViewById error: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }
}
