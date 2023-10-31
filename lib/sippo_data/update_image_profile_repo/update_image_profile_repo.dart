import 'dart:convert';

import 'package:jobspot/JobGlobalclass/global_storage.dart';
import 'package:jobspot/core/api_endpoints.dart' as endpoints;
import 'package:jobspot/utils/app_use.dart';

import 'package:jobspot/sippo_controller/HttpClientController/http_client_controller.dart';
import 'package:jobspot/core/resource.dart';
import 'package:jobspot/core/status_response_code_checker.dart';
import 'package:jobspot/sippo_data/model/custom_file_model/custom_file_model.dart';
import 'package:jobspot/sippo_data/model/image_resource_model/image_resource_model.dart';
import 'package:jobspot/sippo_data/model/image_resource_model/validate_property_image_resource_model.dart';

class ImageProfileRepo {
  static Future<
          Resource<ImageResourceModel?, ValidatePropertyImageResourceModel?>?>
      updateProfileImage(CustomFileModel profileImage) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.postMultipartRequest(
        switch (GlobalStorageService.appUse) {
          AppUsingType.company => endpoints.companyChangeCompanyProfile,
          AppUsingType.user => endpoints.userChangeCompanyProfile,
        },
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
