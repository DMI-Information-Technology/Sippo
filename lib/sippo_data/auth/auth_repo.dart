import "dart:convert";
import "package:http/http.dart" as http;
import "package:jobspot/sippo_data/model/auth_model/user_model.dart";
import "package:jobspot/core/api_endpoints.dart" as endpoints;
import "package:jobspot/core/header_api.dart";
import '../../core/status_response_code_checker.dart';
import "../model/auth_model/auth_response.dart";
import "../model/auth_model/company_model.dart";
import "../model/auth_model/company_property_error_model.dart";
import "../model/auth_model/company_response_login_user_model.dart";
import "../model/auth_model/company_response_model.dart";
import "../model/auth_model/user_response_model.dart";
import "../model/auth_model/user_propery_error_model.dart";

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

  static Future<AuthResponse<CompanyResponseModel, CompanyPropError>?>
      companyRegister(CompanyModel company) async {
    AuthResponse<CompanyResponseModel, CompanyPropError>? companyResponse;
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
        (entity) => CompanyResponseModel.fromJson(entity['company']),
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

  static Future<AuthResponse<LoginCompanyResponseModel, CompanyPropError>?>
      companyLogin(CompanyModel company) async {
    AuthResponse<LoginCompanyResponseModel, CompanyPropError>? companyResponse;
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
        (entity) => LoginCompanyResponseModel.fromJson(entity['user']),
        (errors) => CompanyPropError.fromJson(errors),
      );
    } catch (error) {
      print(error);
    } finally {
      return companyResponse;
    }
  }
}
