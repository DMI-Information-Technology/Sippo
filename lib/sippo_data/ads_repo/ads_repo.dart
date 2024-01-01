import 'dart:convert';

import 'package:sippo/core/resource.dart';
import 'package:sippo/core/status_response_code_checker.dart';
import 'package:sippo/sippo_controller/HttpClientController/http_client_controller.dart';
import 'package:sippo/sippo_data/model/ads_model/ad_model.dart';

class AdsRepo {
  static Future<Resource<List<AdModel>?, dynamic>> fetchAds() async {
    try {
      final response = await HttpClientController.instance.client.get('ads');
      late final Map<String, dynamic> responseData;
      final responseBody = jsonDecode(response.body);
      if (responseBody is List) {
        responseData = {'data': responseBody};
      } else {
        responseData = responseBody;
      }
      return await StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) =>
            List.of(data['data']).map((e) => AdModel.fromJson(e)).toList(),
        (errors) => null,
      );
    } catch (e, s) {
      print(e);
      print(s);
      return Resource.error(
        errorMessage: 'Invalid response',
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }
}
