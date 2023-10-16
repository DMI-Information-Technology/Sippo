import 'dart:convert';

import 'package:jobspot/JobGlobalclass/global_storage.dart';
import 'package:jobspot/core/api_endpoints.dart' as endpoints;
import 'package:jobspot/utils/app_use.dart';

import '../../JopController/HttpClientController/http_client_controller.dart';
import '../../core/resource.dart';
import '../../core/status_response_code_checker.dart';
import '../model/custom_file_model/custom_file_model.dart';
import '../model/image_resource_model/image_resource_model.dart';
import '../model/image_resource_model/validate_property_image_resource_model.dart';

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
