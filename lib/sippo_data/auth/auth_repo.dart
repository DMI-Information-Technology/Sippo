import "dart:convert";
import "package:http/http.dart" as http;
import "package:jobspot/sippo_data/model/auth_model/user_model.dart";
import "package:jobspot/utils/api_endpoints.dart" as endpoints;
import "package:jobspot/utils/header_api.dart";
import "../model/auth_model/auth_response.dart";
import "../model/auth_model/company_model.dart";
import "../model/auth_model/company_property_error_model.dart";
import "../model/auth_model/company_response_login_user_model.dart";
import "../model/auth_model/company_response_model.dart";
import "../model/auth_model/register_model.dart";
import "../model/auth_model/user_response_model.dart";
import "../model/auth_model/user_propery_error_model.dart";
import "../model/auth_model/user_register_type_response.dart";
import "../model/auth_model/validate_error.dart";

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
      userResponse = await checkStatusResponseCode(
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
    AuthResponse<CompanyResponseModel, CompanyPropError>? userResponse;
    try {
      final url = Uri.parse(
          "${endpoints.baseUrl}/${endpoints.companyRegisterEndpoint}");
      final body = jsonEncode(company.toJson());
      final response = await http.post(
        url,
        headers: Header.defaultHeader,
        body: body,
      );
      userResponse = await checkStatusResponseCode(
        response,
        (entity) => CompanyResponseModel.fromJson(entity['company']),
        (errors) => CompanyPropError.fromJson(errors),
      );
    } catch (error) {
      print(error);
    } finally {
      return userResponse;
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
      userResponse = await checkStatusResponseCode(
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

  static Future<AuthResponse<UserCompanyResponseModel, CompanyPropError>?>
      companyLogin(CompanyModel company) async {
    AuthResponse<UserCompanyResponseModel, CompanyPropError>? companyResponse;
    try {
      final url =
          Uri.parse("${endpoints.baseUrl}/${endpoints.companyLoginEndpoint}");
      final body = jsonEncode(company.toLoginJson());
      final response = await http.post(
        url,
        headers: Header.defaultHeader,
        body: body,
      );
      companyResponse = await checkStatusResponseCode(
        response,
        (entity) => UserCompanyResponseModel.fromJson(entity['user']),
        (errors) => CompanyPropError.fromJson(errors),
      );
    } catch (error) {
      print(error);
    } finally {
      return companyResponse;
    }
  }

  static Future<AuthResponse<T, E>?> checkStatusResponseCode<T, E>(
    http.Response response,
    T Function(Map<String, dynamic> entity) entityModel,
    E Function(Map<String, dynamic> errors) entityErrorsModel,
  ) async {
    print("from checkStatusResponseCode: \n${jsonDecode(response.body)}");
    Map<String, dynamic> responseData = jsonDecode(response.body);
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
}
