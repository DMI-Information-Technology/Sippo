import 'dart:convert';

import 'package:jobspot/core/api_endpoints.dart' as endpoints;
import 'package:jobspot/sippo_data/model/status_message_model/status_message_model.dart';

import '../../JopController/HttpClientController/http_client_controller.dart';
import '../../core/resource.dart';
import '../../core/status_response_code_checker.dart';
import '../model/profile_model/company_profile_resource_model/company_job_model.dart';

class SavedJobsRepo {
  static Future<Resource<List<CompanyJobModel>?, dynamic>?> fetchSavedJobs(
      Map<String, String> query) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.get(
        endpoints.userSavedJobsEndpoint,
        queryParameter: query,
      );
      print("SavedJobsRepo.fetchSavedJobs: response data = ${response.body}");
      print(
        "SavedJobsRepo.fetchSavedJobs: response status code = ${response.statusCode}",
      );

      final responseBody = jsonDecode(response.body);
      late final responseData;
      if (responseBody is List) {
        responseData = {'data': responseBody};
      } else {
        responseData = responseBody;
      }
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) {
          return List.of(data['data'])
              .map((e) => CompanyJobModel.fromJson(e))
              .toList();
        },
        (errors) => null,
      );
    } catch (e, s) {
      print(s);
      print("SavedJobsRepo.fetchSavedJobs error: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<Resource<StatusMessageModel?, dynamic>?> toggleSavedJob(
    int? id,
  ) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.post(
        endpoints.userJobsEndpoint,
        data: {},
        resourceId: "$id/${endpoints.userJobsSavedParam}",
      );

      print(
        "SavedJobsRepo.toggleSavedJob: response data before decode = ${response.body}",
      );

      Map<String, dynamic> responseData = jsonDecode(response.body);
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => StatusMessageModel.fromJson(data),
        (errors) => null,
      );
    } catch (e) {
      print("SavedJobsRepo.toggleSavedJob error: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }
}
