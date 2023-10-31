import 'dart:convert';

import 'package:jobspot/core/api_endpoints.dart' as endpoints;

import 'package:jobspot/sippo_controller/HttpClientController/http_client_controller.dart';
import 'package:jobspot/core/resource.dart';
import 'package:jobspot/core/status_response_code_checker.dart';
import '../model/pagination_company_models/posts_pagination_model.dart';
import '../model/profile_model/company_profile_resource_model/company_job_model.dart';
import '../model/profile_model/company_profile_resource_model/vlidate_property_company_job_model.dart';

class CompanyJobRepo {
  static Future<Resource<CompanyJobModel?, ValidatePropCompanyJobModel?>?>
      addNewJob(CompanyJobModel job) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.post(
        endpoints.companyJobsEndpoint,
        data: job.toJson(),
      );

      print(
          "CompanyJobRepo.addNewJob: response data before decode = ${response.body}");

      Map<String, dynamic> responseData = jsonDecode(response.body);
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => CompanyJobModel.fromJson(data),
        (errors) => ValidatePropCompanyJobModel.fromJson(errors),
      );
    } catch (e) {
      print("CompanyJobRepo.addNewJob error: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<Resource<CompanyJobModel?, ValidatePropCompanyJobModel?>?>
      updateJob(CompanyJobModel job, int? jobId) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.put(
        endpoints.companyJobsEndpoint,
        data: job.toJson(),
        resourceId: jobId.toString(),
      );

      print(
        "CompanyJobRepo.updateJob: response data before decode = ${response.body}",
      );

      Map<String, dynamic> responseData = jsonDecode(response.body);
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => CompanyJobModel.fromJson(data),
        (errors) => ValidatePropCompanyJobModel.fromJson(errors),
      );
    } catch (e) {
      print("CompanyJobRepo.updateJob error: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<
      Resource<PaginationModel<CompanyJobModel>?,
          ValidatePropCompanyJobModel?>?> fetchJobs(
      Map<String, String> query) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.get(
        endpoints.companyJobsEndpoint,
        queryParameter: query,
      );

      print("CompanyJobRepo.fetchJobs: response data = ${response.body}");
      print(
        "CompanyJobRepo.fetchJobs: response status code = ${response.statusCode}",
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
    } catch (e) {
      print("CompanyJobRepo.fetchJobs error: $e");
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
        endpoints.companyJobsEndpoint,
        resourceId: jobId.toString(),
      );

      final responseString = response.body;
      print("CompanyJobRepo.getJobById: response data = $responseString");
      print(
        "CompanyJobRepo.getJobById: response status code = ${response.statusCode}",
      );

      final responseData = jsonDecode(responseString);
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => CompanyJobModel.fromJson(data),
        (errors) => ValidatePropCompanyJobModel.fromJson(errors),
      );
    } catch (e) {
      print("CompanyJobRepo.getJobById error: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<Resource<CompanyJobModel?, ValidatePropCompanyJobModel?>?>
      updateStatusJobById(
    int? jobId,
  ) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.put(
        endpoints.companyJobsEndpoint,
        resourceId: '$jobId/${endpoints.companyChangeStatusJobParam}',
      );

      final responseString = response.body;
      print(
          "CompanyJobRepo.updateStatusJobById: response data = $responseString");
      print(
          "CompanyJobRepo.updateStatusJobById: response status code = ${response.statusCode}");

      final responseData = jsonDecode(responseString);

      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => CompanyJobModel.fromJson(data),
        (errors) => null,
      );
    } catch (e) {
      print("CompanyJobRepo.updateStatusJobById error: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<Resource<List<ExperienceLevel>?, ValidatePropCompanyJobModel?>?>
      fetchExperienceLevels() async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.get(
        endpoints.experienceLevelsEndpoint,
      );
      print(
          "CompanyJobRepo.fetchExperienceLevels: response data = ${response.body}");
      print(
        "CompanyJobRepo.fetchExperienceLevels: response status code = ${response.statusCode}",
      );

      final responseData = jsonDecode(response.body);
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => ExperienceLevel.fromJsonToExperienceLevelList(data),
        (errors) => null,
      );
    } catch (e) {
      print("CompanyJobRepo.fetchExperienceLevels error: $e");
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
