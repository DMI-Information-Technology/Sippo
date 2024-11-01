import 'dart:convert';

import 'package:sippo/sippo_controller/HttpClientController/http_client_controller.dart';
import 'package:sippo/core/api_endpoints.dart' as endpoints;
import 'package:sippo/sippo_data/model/pagination_company_models/posts_pagination_model.dart';
import 'package:sippo/sippo_data/model/profile_model/company_profile_resource_model/company_post_model.dart';

import 'package:sippo/core/resource.dart';
import 'package:sippo/core/status_response_code_checker.dart';
import 'package:sippo/sippo_data/model/auth_model/company_response_details.dart';
import 'package:sippo/sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';

class UserCommunityRepo {
  static Future<
          Resource<PaginationModel<CompanyDetailsModel>?, dynamic>?>
      fetchCommunityCompanies(Map<String, String> query) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.get(
        endpoints.userCommunityCompaniesEndpoint,
        queryParameter: query,
      );
      final responseData = jsonDecode(response.body);

      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => PaginationModel.fromJson(
          data,
          dataConverter: (item) => CompanyDetailsModel.fromJson(item),
        ),
        (errors) => null,
      );
    } catch (e) {
      print(e.runtimeType);
      print("UserCommunityRepo.fetchCommunityCompanies Exception: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<Resource<PaginationModel<CompanyDetailsPostModel>?, dynamic>?>
      fetchCommunityPosts(Map<String, String> query) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.get(
        endpoints.userCommunityPostsEndpoint,
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
      print("UserCommunityRepo.fetchCommunityPosts Exception: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<Resource<PaginationModel<CompanyJobModel>?, dynamic>?>
      fetchCommunityJobs(Map<String, String> query) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.get(
        endpoints.userCommunityJobsEndpoint,
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
      print("UserCommunityRepo.fetchCommunityJobs Exception: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }
}
