import "dart:convert";

import "package:http/http.dart" as http;
import "package:jobspot/JopController/HttpClientController/http_client_controller.dart";
import "package:jobspot/core/api_endpoints.dart" as endpoints;
import "package:jobspot/core/header_api.dart";
import "package:jobspot/sippo_data/model/auth_model/user_model.dart";

import '../../core/status_response_code_checker.dart';
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
      userResponse =
          await StatusResponseCodeChecker.checkStatusAuthResponseCode(
        response,
        (entity) => UserResponseModel.fromJson(entity['user']),
        (errors) => UserPropError.fromJson(errors),
      );
    } catch (error) {
      print(error);
    } finally {
      return userResponse;
    }
  }

  static Future<AuthResponse<CompanyResponseDetailsModel, CompanyPropError>?>
      companyRegister(CompanyModel company) async {
    AuthResponse<CompanyResponseDetailsModel, CompanyPropError>? companyResponse;
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
        (entity) => CompanyResponseDetailsModel.fromJson(entity['company']),
        (errors) => CompanyPropError.fromJson(errors),
      );
    } catch (error) {
      print(error);
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
    } catch (error) {
      print(error);
    } finally {
      return userResponse;
    }
  }

  static Future<String?> userLogout() async {
    try {
      final response = await HttpClientController.instance.client.post(
        endpoints.userLogoutEndpoint,
        data: {},
      );
      final responseData = jsonDecode(response.body);
      final logoutMessage = responseData["message"];
      if (!(response.statusCode == 200 || response.statusCode == 204)) {
        throw Exception(
          "AuthRepo.userLogout Exception: bad response status code: ${response.statusCode} - and response body: ${response.body}",
        );
      } else if (logoutMessage == null) {
        throw Exception(
            "AuthRepo.userLogout Exception: the logout message is null.");
      } else if (!(logoutMessage is String)) {
        throw Exception(
            "AuthRepo.userLogout Exception: the response is not a message of type string.");
      } else if (logoutMessage.isEmpty) {
        throw Exception(
            "AuthRepo.userLogout Exception: the logout message is empty.");
      }
      return logoutMessage;
    } catch (error) {
      print(error);
      return null;
    }
  }

  static Future<AuthResponse<CompanyResponseDetailsModel, CompanyPropError>?>
      companyLogin(CompanyModel company) async {
    AuthResponse<CompanyResponseDetailsModel, CompanyPropError>? companyResponse;
    try {
      final url =
          Uri.parse("${endpoints.baseUrl}/${endpoints.companyLoginEndpoint}");
      final body = jsonEncode(company.toLoginJson());
      final response = await http.post(
        url,
        headers: Header.defaultHeader,
        body: body,
      );
      companyResponse =
          await StatusResponseCodeChecker.checkStatusAuthResponseCode(
        response,
        (entity) => CompanyResponseDetailsModel.fromJson(entity['company']),
        (errors) => CompanyPropError.fromJson(errors),
      );
    } catch (error) {
      print(error);
    } finally {
      return companyResponse;
    }
  }
}
