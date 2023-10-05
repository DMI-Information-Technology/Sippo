import 'dart:convert';

import 'package:jobspot/core/api_endpoints.dart' as endpoints;
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/user_job_application_model.dart';

import '../../JopController/HttpClientController/http_client_controller.dart';
import '../../core/resource.dart';
import '../../core/status_response_code_checker.dart';
import '../model/auth_model/company_response_details.dart';
import '../model/pagination_company_models/posts_pagination_model.dart';
import '../model/profile_model/company_profile_resource_model/company_job_model.dart';
import '../model/profile_model/company_profile_resource_model/company_post_model.dart';
import '../model/profile_model/profile_resource_model/validate_property_user_company_application_model.dart';

class UserCompaniesAboutsRepo {
  static Future<
          Resource<PaginationModel<CompanyDetailsResponseModel>?, dynamic>?>
      fetchCompanies(Map<String, String> query) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.get(
        endpoints.userCompaniesAboutsEndpoint,
        queryParameter: query,
      );
      final responseData = jsonDecode(response.body);

      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (resource) => PaginationModel.fromJson(
          resource,
          dataConverter: (data) => CompanyDetailsResponseModel.fromJson(data),
        ),
        (errors) => null,
      );
    } catch (e) {
      print(e.runtimeType);
      print(
          "UserCompaniesAboutsRepo.CompanyDetailsResponseModel Exception: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<Resource<CompanyDetailsResponseModel?, dynamic>?>
      fetchAboutsCompany(int? resourceId) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.get(
        endpoints.userCompaniesAboutsEndpoint,
        resourceId: resourceId.toString(),
      );
      final responseData = jsonDecode(response.body);

      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => CompanyDetailsResponseModel.fromJson(data),
        (errors) => null,
      );
    } catch (e) {
      print(e.runtimeType);
      print(
          "UserCompaniesAboutsRepo.CompanyDetailsResponseModel Exception: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<Resource<PaginationModel<CompanyDetailsPostModel>?, dynamic>?>
      fetchAboutCompanyPosts(Map<String, String> query, int? resourceId) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.get(
        endpoints.userCompaniesAboutsEndpoint,
        resourceId: "$resourceId/${endpoints.userPostsAboutsCompanies}",
        queryParameter: query,
      );
      final responseData = jsonDecode(response.body);

      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => PaginationModel.fromJson(
          data,
          dataConverter: (item) => CompanyDetailsPostModel.fromJson(item),
        ),
        (errors) => null,
      );
    } catch (e) {
      print(e.runtimeType);
      print("UserCompaniesAboutsRepo.fetchAboutCompanyPosts Exception: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<Resource<PaginationModel<CompanyJobModel>?, dynamic>?>
      fetchAboutCompanyJobs(Map<String, String> query, int? resourceId) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.get(
        endpoints.userCompaniesAboutsEndpoint,
        resourceId: "$resourceId/${endpoints.userJobsAboutsCompanies}",
        queryParameter: query,
      );

      final responseData = jsonDecode(response.body);

      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => PaginationModel.fromJson(
          data,
          dataConverter: (item) => CompanyJobModel.fromJson(item),
        ),
        (errors) => null,
      );
    } catch (e) {
      print(e.runtimeType);
      print("UserCompaniesAboutsRepo.fetchAboutCompanyJobs Exception: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<Resource<CompanyDetailsResponseModel?, dynamic>?> toggleFollow(
    int? companyId,
  ) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.put(
        endpoints.userCompaniesAboutsEndpoint,
        data: {},
        resourceId: "$companyId/${endpoints.toggleFollowCompaniesParam}",
      );

      print(
        "UserCommunityRepo.toggleFollow: response data before decode = ${response.body}",
      );

      Map<String, dynamic> responseData = jsonDecode(response.body);
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => CompanyDetailsResponseModel.fromJson(data),
        (errors) => null,
      );
    } catch (e) {
      print("UserCommunityRepo.toggleFollow error: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<
      Resource<CompanyDetailsResponseModel?,
          ValidatePropUserCompanyApplication?>?> applyCompany(
    UserSendApplicationModel application,
    int? companyId,
  ) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.postMultipartRequest(
        endpoints.userCompaniesAboutsEndpoint,
        fields: application.contentToJson(),
        multipartFile: application.toMultipartFile(),
        resourceId: "$companyId/${endpoints.applyCompanyParam}",
      );
      final responseString = await response.stream.bytesToString();
      print(
        "UserCommunityRepo.applyCompany: response data before decode = ${responseString}",
      );
      Map<String, dynamic> responseData = jsonDecode(responseString);
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => CompanyDetailsResponseModel.fromJson(data),
        (errors) => ValidatePropUserCompanyApplication.fromJson(errors),
      );
    } catch (e) {
      print("UserCommunityRepo.applyCompany error: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<Resource<CompanyDetailsResponseModel?, dynamic>?>
      getCompanyById(
    int? companyId,
  ) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.get(
        endpoints.userCompaniesAboutsEndpoint,
        resourceId: companyId.toString(),
      );

      print(
        "UserCommunityRepo.getCompanyById: response data before decode = ${response.body}",
      );

      final responseData = jsonDecode(response.body);
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => CompanyDetailsResponseModel.fromJson(data),
        (errors) => null,
      );
    } catch (e) {
      print("UserCommunityRepo.getCompanyById error: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }
}
