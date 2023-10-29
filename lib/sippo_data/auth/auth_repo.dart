import "dart:convert";
import "dart:io";

import "package:flutter/foundation.dart";
import "package:http/http.dart" as http;
import "package:jobspot/JobGlobalclass/global_storage.dart";
import "package:jobspot/JopController/HttpClientController/http_client_controller.dart";
import "package:jobspot/core/api_endpoints.dart" as endpoints;
import "package:jobspot/core/header_api.dart";
import 'package:jobspot/core/status_response_code_checker.dart';
import "package:jobspot/sippo_data/model/auth_model/user_model.dart";
import "package:jobspot/sippo_data/model/auth_model/user_register_type_response.dart";
import "package:jobspot/sippo_data/model/status_message_model/status_message_model.dart";
import "package:jobspot/utils/app_use.dart";

import "../../core/resource.dart";
import "../model/auth_model/auth_response.dart";
import "../model/auth_model/company_model.dart";
import "../model/auth_model/company_property_error_model.dart";
import "../model/auth_model/company_response_details.dart";
import "../model/auth_model/user_propery_error_model.dart";
import "../model/auth_model/user_response_model.dart";

class AuthRepo {
  static Future<AuthResponse<UserResponseModel, UserPropError>?> userRegister(
      UserModel user) async {
    AuthResponse<UserResponseModel, UserPropError>? userResponse;
    try {
      final url =
          Uri.parse("${endpoints.baseUrl}/${endpoints.userRegisterEndpoint}");
      final body = jsonEncode(user.toJson());
      final response = await http.post(
        url,
        headers: Header.defaultHeader,
        body: body,
      );
      print(response.body);
      userResponse =
          await StatusResponseCodeChecker.checkStatusAuthResponseCode(
        response,
        (entity) => UserResponseModel.fromJson(entity['user']),
        (errors) => UserPropError.fromJson(errors),
      );
    } catch (e, s) {
      print(e);
      print(s);
      FlutterError.reportError(FlutterErrorDetails(
        exception: e,
        stack: s,
        library: 'Flutter Custom Error',
        context: ErrorSummary('while running async test code'),
      ));
    } finally {
      return userResponse;
    }
  }

  static Future<AuthResponse<CompanyDetailsModel, CompanyPropError>?>
      companyRegister(CompanyModel company) async {
    AuthResponse<CompanyDetailsModel, CompanyPropError>? companyResponse;
    try {
      final url = Uri.parse(
          "${endpoints.baseUrl}/${endpoints.companyRegisterEndpoint}");
      final body = jsonEncode(company.toJson());
      final response = await http.post(
        url,
        headers: Header.defaultHeader,
        body: body,
      );
      companyResponse =
          await StatusResponseCodeChecker.checkStatusAuthResponseCode(
        response,
        (entity) => CompanyDetailsModel.fromJson(entity['company']),
        (errors) => CompanyPropError.fromJson(errors),
      );
    } catch (e, s) {
      print(e);
      print(s);
      FlutterError.reportError(FlutterErrorDetails(
        exception: e,
        stack: s,
        library: 'Flutter Custom Error',
        context: ErrorSummary('while running async test code'),
      ));
    } finally {
      return companyResponse;
    }
  }

  static Future<AuthResponse<UserResponseModel, UserPropError>?> userLogin(
      UserModel user) async {
    AuthResponse<UserResponseModel, UserPropError>? userResponse;
    try {
      final url =
          Uri.parse("${endpoints.baseUrl}/${endpoints.userLoginEndpoint}");
      final body = jsonEncode(user.toLoginJson());
      print("login form after decode: $body");
      final response = await http.post(
        url,
        headers: Header.defaultHeader,
        body: body,
      );
      userResponse =
          await StatusResponseCodeChecker.checkStatusAuthResponseCode(
        response,
        (entity) => UserResponseModel.fromJson(entity['user']),
        (errors) => UserPropError.fromJson(errors),
      );
    } on SocketException catch (e, s) {
      userResponse = AuthResponse.registerAuthError(
        authMessageError: "Unable to Establish Internet Connection "
            "Please check your internet connection and try again.",
        type: RegisterTypeResponse.auth_error,
      );
      print(e);
      print(s);
      FlutterError.reportError(FlutterErrorDetails(
        exception: e,
        stack: s,
        library: 'Flutter Custom Error',
        context: ErrorSummary('while running async test code'),
      ));
    } catch (error) {
      print(error);
    } finally {
      return userResponse;
    }
  }

  static Future<Map<String, String>?> userLogout() async {
    try {
      final response = await HttpClientController.instance.client.post(
        GlobalStorageService.appUse == AppUsingType.user
            ? endpoints.userLogoutEndpoint
            : endpoints.companyLogoutEndpoint,
        data: {},
      );
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 204) {
        return {"success": responseData.toString()};
      } else {
        return {"error": responseData.toString()};
      }
    } catch (error) {
      print(error);
      return {"error": error.toString()};
    }
  }

  static Future<AuthResponse<CompanyDetailsModel, CompanyPropError>?>
      companyLogin(CompanyModel company) async {
    AuthResponse<CompanyDetailsModel, CompanyPropError>? companyResponse;
    try {
      final url =
          Uri.parse("${endpoints.baseUrl}/${endpoints.companyLoginEndpoint}");
      final body = jsonEncode(company.toLoginJson());
      print("login form after decode: $body");
      final response = await http.post(
        url,
        headers: Header.defaultHeader,
        body: body,
      );
      companyResponse =
          await StatusResponseCodeChecker.checkStatusAuthResponseCode(
        response,
        (entity) => CompanyDetailsModel.fromJson(entity['company']),
        (errors) => CompanyPropError.fromJson(errors),
      );
    } on SocketException catch (e, s) {
      companyResponse = AuthResponse.registerAuthError(
        authMessageError: "Unable to Establish Internet Connection "
            "Please check your internet connection and try again.",
        type: RegisterTypeResponse.auth_error,
      );
      print(e);
      print(s);
      FlutterError.reportError(FlutterErrorDetails(
        exception: e,
        stack: s,
        library: 'Flutter Custom Error',
        context: ErrorSummary('while running async test code'),
      ));
    } catch (error) {
      print(error);
    } finally {
      return companyResponse;
    }
  }

  static Future<Resource<StatusMessageModel?, dynamic>?> forgetPassword(
      String? email) async {
    try {
      final url =
          Uri.parse("${endpoints.baseUrl}/${endpoints.forgetPasswordEndpoint}");
      final body = jsonEncode({"email": email});
      print("forget password after decode: $body");
      final response = await http.post(
        url,
        headers: Header.defaultHeader,
        body: body,
      );
      final responseData = jsonDecode(response.body);
      return await StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => StatusMessageModel.fromJson(data),
        (errors) => null,
      );
    } catch (e, s) {
      print(e);
      print(s);
      FlutterError.reportError(FlutterErrorDetails(
        exception: e,
        stack: s,
        library: 'Flutter Custom Error',
        context: ErrorSummary('while running async test code'),
      ));
      return const Resource.error(
        errorMessage: "Invalid response",
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<Resource<Map<String, dynamic>?, dynamic>?> confirmOtpCode(
      Map<String, String> resetData) async {
    try {
      final url =
          Uri.parse("${endpoints.baseUrl}/${endpoints.confirmOtpEndPoint}");
      final body = jsonEncode(resetData);
      print('forget password url: $url');
      print("forget password after decode: $body");
      final response = await http.post(
        url,
        headers: Header.defaultHeader,
        body: body,
      );
      final responseData = jsonDecode(response.body);
      print('forget password response data: $responseData');
      return await StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => data,
        (errors) => null,
      );
    } catch (e, s) {
      print(e);
      print(s);
      FlutterError.reportError(FlutterErrorDetails(
        exception: e,
        stack: s,
        library: 'Flutter Custom Error',
        context: ErrorSummary('while running async test code'),
      ));
      return const Resource.error(
        errorMessage: "Invalid response",
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<Resource<Map<String, dynamic>?, dynamic>?> resetNewPassword(
    Map<String, String> resetData,
  ) async {
    try {
      final url =
          Uri.parse("${endpoints.baseUrl}/${endpoints.resetPasswordEndpoint}");
      final body = jsonEncode(resetData);
      print('reset password url: $url');
      print("reset password after decode: $body");
      final response = await http.post(
        url,
        headers: Header.defaultHeader,
        body: body,
      );
      final responseData = jsonDecode(response.body);
      print('reset password response data: $responseData');
      return await StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => data,
        (errors) => null,
      );
    } catch (e, s) {
      print(e);
      print(s);
      FlutterError.reportError(FlutterErrorDetails(
        exception: e,
        stack: s,
        library: 'Flutter Custom Error',
        context: ErrorSummary('while running async test code'),
      ));
      return const Resource.error(
        errorMessage: "Invalid response",
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }
}
