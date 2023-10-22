import 'dart:convert';

import 'package:jobspot/JopController/HttpClientController/http_client_controller.dart';
import 'package:jobspot/core/api_endpoints.dart' as endpoints;
import 'package:jobspot/core/resource.dart';
import 'package:jobspot/core/status_response_code_checker.dart';
import 'package:jobspot/sippo_data/model/notification/notification_model.dart';
import 'package:jobspot/sippo_data/model/pagination_company_models/posts_pagination_model.dart';
import 'package:jobspot/sippo_data/model/status_message_model/status_message_model.dart';

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

  static Future<Resource<StatusMessageModel?, dynamic>?> removeNotification(
      String? resourceId) async {
    try {
      final response = await HttpClientController.instance.client.delete(
        endpoints.notificationsEndpoint,
        resourceId: resourceId,
      );
      final responseData = jsonDecode(response.body);
      await StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => StatusMessageModel.fromJson(data),
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
    return null;
  }

  static Future<Resource<StatusMessageModel?, StatusMessageModel?>?>
      markedNotificationAsRead(String resourceId) async {
    try {
      final response = await HttpClientController.instance.client.put(
        endpoints.notificationsEndpoint,
        resourceId: '${resourceId}/mark-as-read',
      );
      final responseData = jsonDecode(response.body);
      return await StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => StatusMessageModel.fromJson(data),
        (errors) => StatusMessageModel.fromJson(errors),
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

  static Future<Resource<StatusMessageModel?, StatusMessageModel?>?>
      markedAllNotificationAsRead() async {
    try {
      final response = await HttpClientController.instance.client.put(
        endpoints.readAllNotificationsEndpoint,
      );
      final responseData = jsonDecode(response.body);
      return await StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => StatusMessageModel.fromJson(data),
        (errors) => StatusMessageModel.fromJson(errors),
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
