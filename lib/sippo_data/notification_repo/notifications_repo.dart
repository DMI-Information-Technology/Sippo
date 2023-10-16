import 'dart:convert';

import 'package:jobspot/JopController/HttpClientController/http_client_controller.dart';
import 'package:jobspot/core/api_endpoints.dart' as endpoints;
import 'package:jobspot/core/resource.dart';
import 'package:jobspot/core/status_response_code_checker.dart';
import 'package:jobspot/sippo_data/model/notification/notification_model.dart';
import 'package:jobspot/sippo_data/model/pagination_company_models/posts_pagination_model.dart';

class NotificationRepo {
  static Future<Resource<PaginationModel<BaseNotificationModel?>?, dynamic>?>
      fetchNotifications([Map<String, String>? query]) async {
    try {
      final response = await HttpClientController.instance.client.get(
        endpoints.notificationsEndpoint,
        queryParameter: query,
      );
      final responseData = jsonDecode(response.body);
      return await StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => PaginationModel.fromJson(
          data,
          dataConverter: (item) =>
              BaseNotificationModel.fromNotificationsJson(item),
        ),
        (errors) => null,
      );
    } catch (e, s) {
      print(e);
      print(s);
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }
}
