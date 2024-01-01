import 'dart:convert';

import 'package:sippo/sippo_controller/HttpClientController/http_client_controller.dart';
import 'package:sippo/core/api_endpoints.dart' as endpoints;
import 'package:sippo/core/resource.dart';
import 'package:sippo/sippo_data/model/job_statistics_model/job_statistics_model.dart';

import '../../core/status_response_code_checker.dart';

class JobStatisticsRepo {
  static Future<Resource<JobStatisticsModel?, dynamic>?>
      fetchLocations() async {
    try {
      final response = await HttpClientController.instance.client.get(
        endpoints.userJobsStatisticsEndpoint,
      );
      final responseData = jsonDecode(response.body);
      print(responseData);
      return await StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => JobStatisticsModel.fromJson(data),
        (errors) => null,
      );
    } catch (e, s) {
      print(s);
      print(e);
      return Resource.error(
        errorMessage: 'Invalid Response',
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }
}
