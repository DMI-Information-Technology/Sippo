import 'dart:convert';

import 'package:jobspot/JopController/HttpClientController/http_client_controller.dart';
import 'package:jobspot/core/api_endpoints.dart' as endpoints;
import 'package:jobspot/core/resource.dart';
import 'package:jobspot/sippo_data/model/job_statistics_model/job_statistics_model.dart';

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
