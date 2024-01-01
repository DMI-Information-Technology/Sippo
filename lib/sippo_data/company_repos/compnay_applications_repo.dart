import 'dart:convert';

import 'package:sippo/sippo_controller/HttpClientController/http_client_controller.dart';
import 'package:sippo/core/api_endpoints.dart' as endpoints;
import 'package:sippo/core/resource.dart';
import 'package:sippo/core/status_response_code_checker.dart';
import '../model/pagination_company_models/posts_pagination_model.dart';
import '../model/application_model/application_change_status_model.dart';
import 'package:sippo/sippo_data/model/application_model/application_job_company_model.dart';

import '../model/status_message_model/status_message_model.dart';

class CompanyReceivedApplicationRepo {
  static Future<
          Resource<StatusMessageModel?, ValidatePropApplicationStatusModel?>?>
      changeApplicationStatus(
          ApplicationStatusModel status, int? resourceId) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.put(
        endpoints.companyApplicationEndpoint,
        data: status.toJson(),
        resourceId: resourceId.toString(),
      );

      print(
        "CompanyReceivedApplicationRepo.changeApplicationStatus: response data before decode = ${response.body}",
      );
      final responseData = jsonDecode(response.body);
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => StatusMessageModel.fromJson(data),
        (errors) => ValidatePropApplicationStatusModel.fromJson(errors),
      );
    } catch (e) {
      print("CompanyReceivedApplicationRepo.changeApplicationStatus error: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<
          Resource<PaginationModel<ApplicationCompanyModel>?, dynamic>?>
      fetchApplications(Map<String, String> query) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.get(
        endpoints.companyApplicationEndpoint,
        queryParameter: query,
      );
      print(
        "CompanyReceivedApplicationRepo.fetchApplications: response data before decode = ${response.body}",
      );
      print(
        "CompanyReceivedApplicationRepo.fetchApplications: response status code = ${response.statusCode}",
      );

      final responseData = jsonDecode(response.body);

      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => PaginationModel.fromJson(
          data,
          dataConverter: (item) => ApplicationCompanyModel.fromJson(item),
        ),
        (errors) => null,
      );
    } catch (e) {
      print(e.runtimeType);
      print("CompanyReceivedApplicationRepo.fetchApplications Exception: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }
}
