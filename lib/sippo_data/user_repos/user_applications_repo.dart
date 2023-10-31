import 'dart:convert';

import 'package:jobspot/sippo_controller/HttpClientController/http_client_controller.dart';
import 'package:jobspot/core/api_endpoints.dart' as endpoints;
import 'package:jobspot/core/resource.dart';
import 'package:jobspot/core/status_response_code_checker.dart';
import 'package:jobspot/sippo_data/model/pagination_company_models/posts_pagination_model.dart';
import 'package:jobspot/sippo_data/model/application_model/application_job_company_model.dart';

class UserReceivedApplicationRepo {

  static Future<
          Resource<PaginationModel<ApplicationUserModel>?, dynamic>?>
      fetchApplications(Map<String, String> query) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.get(
        endpoints.userApplicationEndpoint,
        queryParameter: query,
      );
      print(
        "UserReceivedApplicationRepo.fetchApplications: response data before decode = ${response.body}",
      );
      print(
        "UserReceivedApplicationRepo.fetchApplications: response status code = ${response.statusCode}",
      );

      final responseData = jsonDecode(response.body);

      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => PaginationModel.fromJson(
          data,
          dataConverter: (item) => ApplicationUserModel.fromJson(item),
        ),
        (errors) => null,
      );
    } catch (e) {
      print(e.runtimeType);
      print("UserReceivedApplicationRepo.fetchApplications Exception: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }
}
