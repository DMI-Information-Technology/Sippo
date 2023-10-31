import 'dart:convert';

import 'package:jobspot/sippo_controller/HttpClientController/http_client_controller.dart';
import 'package:jobspot/core/api_endpoints.dart' as endpoints;
import 'package:jobspot/core/resource.dart';
import 'package:jobspot/core/status_response_code_checker.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/profile_edit_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/validate_property_profile_edit.dart';

class ProfileInfoRepo {
  static Future<Resource<ProfileInfoModel, ValidatePropProfileInfo?>>
      updateProfile(ProfileInfoModel profile) async {
    final httpController = HttpClientController.instance;
    try {

      final response = await httpController.client.put(
        endpoints.editProfileEndpoint,
        data: profile.toJson(),
      );
      print(
        "EditProfileRepo.updateProfile: response data before decode = ${response.body}",
      );
      Map<String, dynamic> responseData = jsonDecode(response.body);
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => ProfileInfoModel.fromJson(data),
        (errors) => ValidatePropProfileInfo.fromJson(errors),
      );
    } catch (e, s) {
      print("EditProfileRepo.updateProfile: error: $e");
      print(s);
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<Resource<ProfileInfoModel, ValidatePropProfileInfo?>?>
      getUserProfile() async {
    final httpController = HttpClientController.instance;
    try {
      final response =
          await httpController.client.get(endpoints.editProfileEndpoint);
      print(
        "EditProfileRepo.getUserProfile: response data before decode = ${response.body}",
      );
      final responseData = jsonDecode(response.body);
      return await StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => ProfileInfoModel.fromJson(data),
        (errors) => ValidatePropProfileInfo.fromJson(errors),
      );
    } catch (e) {
      print(e.runtimeType);
      print("EditProfileRepo.getUserProfile: Exception: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

 static Future<Resource<ProfileInfoModel?, dynamic>?> updateProfileLocation(
      Map<String, dynamic> loc) async {
    try {
      final response = await HttpClientController.instance.client.put(
        'user/profile/update-location',
        data: loc,
      );
      final responseData = jsonDecode(response.body);
      return await StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => ProfileInfoModel.fromJson(data),
        (errors) => null,
      );
    } catch (e, s) {
      print(e);
      print(s);
      return Resource.error(
        errorMessage: 'Invalid Response',
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }
}
