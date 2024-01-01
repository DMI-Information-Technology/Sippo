import 'dart:convert';

import 'package:sippo/core/api_endpoints.dart' as endpoints;
import 'package:sippo/sippo_data/model/application_model/application_job_company_model.dart';
import 'package:sippo/sippo_data/model/profile_model/profile_resource_model/validate_property_user_job_application_model.dart';

import 'package:sippo/sippo_controller/HttpClientController/http_client_controller.dart';
import 'package:sippo/core/resource.dart';
import 'package:sippo/core/status_response_code_checker.dart';
import 'package:sippo/sippo_data/model/pagination_company_models/posts_pagination_model.dart';
import 'package:sippo/sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';
import 'package:sippo/sippo_data/model/profile_model/company_profile_resource_model/vlidate_property_company_job_model.dart';
import 'package:sippo/sippo_data/model/profile_model/profile_resource_model/user_job_application_model.dart';

class SippoJobsRepo {
  static Future<
      Resource<PaginationModel<CompanyJobModel>?,
          ValidatePropCompanyJobModel?>?> fetchJobs(
    Map<String, String> query,
  ) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.get(
        endpoints.userJobsEndpoint,
        queryParameter: query,
      );

      print("UserJobRepo.fetchJobs: response data = ${response.body}");
      print(
        "UserJobRepo.fetchJobs: response status code = ${response.statusCode}",
      );

      final responseData = jsonDecode(response.body);

      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => PaginationModel.fromJson(
          data,
          dataConverter: (item) => CompanyJobModel.fromJson(item),
        ),
        (errors) => ValidatePropCompanyJobModel.fromJson(errors),
      );
    } catch (e, s) {
      print(s);
      print("UserJobRepo.fetchJobs error: $e");

      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<Resource<CompanyJobModel?, ValidatePropCompanyJobModel?>?>
      getJobById(int? jobId) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.get(
        endpoints.userJobsEndpoint,
        resourceId: jobId.toString(),
      );

      final responseString = response.body;
      print("UserJobRepo.getJobById: response data = $responseString");
      print(
        "UserJobRepo.getJobById: response status code = ${response.statusCode}",
      );
      final responseData = jsonDecode(responseString);
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => CompanyJobModel.fromJson(data),
        (errors) => ValidatePropCompanyJobModel.fromJson(errors),
      );
    } catch (e) {
      print("UserJobRepo.getJobById error: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<Resource<ApplicationUserModel?, ValidatePropUserJobApplication?>?>
      sendApplicationJob(
          UserSendApplicationModel application, String? resourceId) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.postMultipartRequest(
        endpoints.userJobsEndpoint,
        fields: application.contentToJson(),
        multipartFile: application.toMultipartFile(),
        resourceId: resourceId,
      );
      final responseString = await response.stream.bytesToString();
      print(
        "UserJobRepo.sendApplicationJob: response data before decode = ${responseString}",
      );
      Map<String, dynamic> responseData = jsonDecode(responseString);
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => ApplicationUserModel.fromJson(data),
        (errors) => ValidatePropUserJobApplication.fromJson(errors),
      );
    } catch (e) {
      print("UserJobRepo.sendApplicationJob error: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }
}
