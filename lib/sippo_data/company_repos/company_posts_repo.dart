import 'dart:convert';

import 'package:jobspot/JopController/HttpClientController/http_client_controller.dart';
import 'package:jobspot/core/api_endpoints.dart' as endpoints;
import 'package:jobspot/sippo_data/model/pagination_company_models/posts_pagination_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/company_post_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/validate_property_company_post_model.dart';

import '../../core/resource.dart';
import '../../core/status_response_code_checker.dart';

class CompanyPostRepo {
  static Future<
          Resource<CompanyDetailsPostModel?, ValidatePropCompanyPostModel?>?>
      addNewPost(CompanyPostModel post) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.postMultipartRequest(
        endpoints.companyPostEndpoint,
        fields: post.contentToJson(),
        multipartFile: post.imageToMultipartFile(),
      );
      final responseString = await response.stream.bytesToString();
      print(
        "CompanyPostRepo.addNewPost: response data before decode = ${responseString}",
      );
      Map<String, dynamic> responseData = jsonDecode(responseString);
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => CompanyDetailsPostModel.fromJson(data),
        (errors) => ValidatePropCompanyPostModel.fromJson(errors),
      );
    } catch (e) {
      print("CompanyPostRepo.addNewPost error: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<
          Resource<CompanyDetailsPostModel?, ValidatePropCompanyPostModel?>?>
      updatePostCompanyById(
    CompanyPostModel post,
    int? postId,
  ) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.postMultipartRequest(
        endpoints.companyPostEndpoint,
        fields: post.contentToJson()..['_method'] = 'PUT',
        multipartFile: post.imageToMultipartFile(),
        resourceId: postId.toString(),
      );
      final responseString = await response.stream.bytesToString();
      print(
        "CompanyPostRepo.updatePostCompanyById: response data before decode = ${responseString}",
      );
      Map<String, dynamic> responseData = jsonDecode(responseString);
      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => CompanyDetailsPostModel.fromJson(data),
        (errors) => ValidatePropCompanyPostModel.fromJson(errors),
      );
    } catch (e) {
      print("CompanyPostRepo.updatePostCompanyById error: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<
      Resource<PaginationModel<CompanyDetailsPostModel>?,
          ValidatePropCompanyPostModel?>?> fetchPosts(
      Map<String, String> query) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.get(
        endpoints.companyPostEndpoint,
        queryParameter: query,
      );
      print(
        "CompanyPostRepo.fetchPosts: response data before decode = ${response.body}",
      );
      print(
        "CompanyPostRepo.fetchPosts: response status code = ${response.statusCode}",
      );

      final responseData = jsonDecode(response.body);

      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => PaginationModel.fromJson(
          data,
          dataConverter: (item) => CompanyDetailsPostModel.fromJson(item),
        ),
        (errors) => null,
      );
    } catch (e) {
      print(e.runtimeType);
      print("CompanyPostRepo.fetchPosts Exception: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<
          Resource<CompanyDetailsPostModel?, ValidatePropCompanyPostModel?>?>
      getPostById(int id) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.get(
        endpoints.companyPostEndpoint,
        resourceId: id.toString(),
      );
      print(
        "CompanyPostRepo.getPostById: response data before decode = ${response.body}",
      );
      print(
        "CompanyPostRepo.getPostById: response status code = ${response.statusCode}",
      );
      final responseData = jsonDecode(response.body);
      print(
        "CompanyPostRepo.getPostById: response run time type after decode = ${responseData.runtimeType}",
      );

      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) {
          return CompanyDetailsPostModel.fromJson(data);
        },
        (errors) => null,
      );
    } catch (e) {
      print(e.runtimeType);
      print("EducationRepo.getEducationById: Exception: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }

  static Future<Resource<bool, ValidatePropCompanyPostModel?>?> deletePostById(
      int? id) async {
    final httpController = HttpClientController.instance;
    try {
      final response = await httpController.client.delete(
        endpoints.companyPostEndpoint,
        resourceId: id.toString(),
      );
      print(
        "EducationRepo.deleteEducationById: response data before decode = ${response.body}",
      );
      print(
        "EducationRepo.deleteEducationById: response status code = ${response.statusCode}",
      );
      late final Map<String, dynamic> responseData;
      if (response.body.isNotEmpty) {
        responseData = jsonDecode(response.body);
      } else {
        responseData = {};
      }
      print(
        "EducationRepo.deleteEducationById: response run time type after decode = ${responseData.runtimeType}",
      );

      return StatusResponseCodeChecker.checkStatusResponseCode(
        responseData,
        response.statusCode,
        (data) => true,
        (errors) => null,
      );
    } catch (e) {
      print(e.runtimeType);
      print("EducationRepo.deleteEducationById Exception: $e");
      return Resource.error(
        errorMessage: e.toString(),
        type: StatusType.INVALID_RESPONSE,
      );
    }
  }
}
