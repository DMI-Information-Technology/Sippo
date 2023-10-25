import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jobspot/core/resource.dart';
import 'package:jobspot/core/validate_error.dart';
import 'package:jobspot/sippo_data/model/auth_model/entity_model.dart';

import '../sippo_data/model/auth_model/auth_response.dart';
import '../sippo_data/model/auth_model/register_model.dart';
import '../sippo_data/model/auth_model/user_register_type_response.dart';

class StatusResponseCodeChecker {
  static Future<AuthResponse<T, E>?>
      checkStatusAuthResponseCode<T extends EntityModel, E>(
    http.Response response,
    T Function(Map<String, dynamic> entity) entityModel,
    E Function(Map<String, dynamic> errors) entityErrorsModel,
  ) async {
    print("from checkStatusResponseCode: \n${jsonDecode(response.body)}");
    Map<String, dynamic> responseData = jsonDecode(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return AuthResponse.registerSuccess(
        data: RegisterModel.fromJson(
          responseData,
          (json) => entityModel(json),
        ),
        type: RegisterTypeResponse.success,
      );
    } else if (response.statusCode == 403) {
      return AuthResponse.registerAuthError(
        authMessageError: responseData['message'],
        type: RegisterTypeResponse.auth_error,
      );
    } else if (response.statusCode == 422) {
      return AuthResponse.registerValidateError(
        validateError: ValidateError.fromJson(
          responseData,
          (errors) => entityErrorsModel(errors),
        ),
        type: RegisterTypeResponse.validate_error,
      );
    }
    // this status code checking only for company response
    else if (response.statusCode == 500) {
      return AuthResponse.registerAuthError(
        authMessageError: responseData['message'],
        error: responseData['error'],
        type: RegisterTypeResponse.auth_error,
      );
    }
    return null;
  }

  static Future<Resource<T, E?>> checkStatusResponseCode<T, E>(
    Map<String, dynamic> responseData,
    int statusCode,
    T Function(Map<String, dynamic> data) dataModel,
    E? Function(Map<String, dynamic> errors) errorsModel,
  ) async {
    print(
        "StatusResponseCodeChecker.checkStatusResponseCode: status Code = $statusCode");
    print(
      "StatusResponseCodeChecker.checkStatusResponseCode: response data after decode = $responseData",
    );
    switch (statusCode) {
      case 200:
        return Resource.success(
          data: dataModel(responseData),
          type: StatusType.SUCCESS,
        );
      case 201:
        return Resource.success(
          data: dataModel(responseData),
          type: StatusType.SUCCESS,
        );
      case 204:
        return Resource.success(
          data: dataModel(responseData),
          type: StatusType.SUCCESS,
        );
      case 403:
        return Resource.error(
          errorMessage: responseData['message'],
          type: StatusType.ERROR,
        );
      case 404:
        return Resource.error(
          errorMessage: responseData['message'],
          type: StatusType.ERROR,
        );
      case 422:
        return Resource.validateError(
          validateError: ValidateError.fromJson(
            responseData,
            (errors) => errorsModel(errors),
          ),
          type: StatusType.VALIDATE_ERROR,
        );
      default:
        return Resource.error(
          errorMessage: "invalid response.",
          type: StatusType.INVALID_RESPONSE,
        );
    }
  }
}
