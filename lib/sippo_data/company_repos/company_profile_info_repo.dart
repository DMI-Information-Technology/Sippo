import 'dart:convert';

import 'package:jobspot/sippo_data/model/auth_model/company_response_details.dart';
import 'package:jobspot/sippo_data/model/custom_file_model/custom_file_model.dart';
import 'package:jobspot/sippo_data/model/image_resource_model/image_resource_model.dart';
import 'package:jobspot/sippo_data/model/image_resource_model/validate_property_image_resource_model.dart';

import '../../JopController/HttpClientController/http_client_controller.dart';
import '../../core/api_endpoints.dart' as endpoints;
import '../../core/resource.dart';
import '../../core/status_response_code_checker.dart';
import '../model/profile_model/company_profile_resource_model/validate_property_company_profile_details_model.dart';

class EditCompanyProfileInfoRepo {
  static Future<
      Resource<CompanyDetailsModel,
          ValidatePropCompanyProfileDetailsModel?>> updateCompanyProfile(
    CompanyDetailsModel profile,
  ) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.put(
        endpoints.companyInfoProfileEndpoint,
        data: profile.toJson(),
      );
      print("status code ${response.statusCode}");
      print(
        "EditCompanyProfileInfoRepo.updateCompanyProfile: response data before decode = ${response.body}",
      );
      Map<String, dynamic> responseData = jsonDecode(response.body);
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => CompanyDetailsModel.fromJson(data),
        (errors) => ValidatePropCompanyProfileDetailsModel.fromJson(errors),
      );
    } catch (e) {
      print("EditCompanyProfileInfoRepo.updateCompanyProfile: error: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<
      Resource<CompanyDetailsModel,
          ValidatePropCompanyProfileDetailsModel?>?> getCompanyProfile() async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.get(
        endpoints.companyInfoProfileEndpoint,
      );
      print(
        "CompanyProfileInfoRepo.getCompanyProfile: response data before decode = ${response.body}",
      );
      final responseData = jsonDecode(response.body);
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => CompanyDetailsModel.fromJson(data),
        (errors) => ValidatePropCompanyProfileDetailsModel.fromJson(errors),
      );
    } catch (e) {
      print(e.runtimeType);
      print("CompanyProfileInfoRepo.getCompanyProfile: Exception: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<
          Resource<ImageResourceModel?, ValidatePropertyImageResourceModel?>?>
      updateProfileImage(CustomFileModel profileImage) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.postMultipartRequest(
        endpoints.companyChangeCompanyProfile,
        fields: {'_method': "PUT"},
        multipartFile: profileImage.toMultipartFile(),
      );
      final responseBody = await response.stream.bytesToString();
      print(
        "CompanyProfileInfoRepo.updateProfileImage: response data before decode = ${responseBody}",
      );
      final responseData = jsonDecode(responseBody);
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => ImageResourceModel.fromJson(data),
        (errors) => ValidatePropertyImageResourceModel.fromJson(errors),
      );
    } catch (e) {
      print(e.runtimeType);
      print("CompanyProfileInfoRepo.updateProfileImage: Exception: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }
}