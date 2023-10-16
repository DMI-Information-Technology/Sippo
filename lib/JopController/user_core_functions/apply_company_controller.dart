import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/JobServices/shared_global_data_service.dart';
import 'package:jobspot/sippo_data/model/auth_model/company_response_details.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/user_job_application_model.dart';
import 'package:jobspot/sippo_data/user_repos/user_companies_abouts_repo.dart';

import 'package:jobspot/sippo_data/model/custom_file_model/custom_file_model.dart';
import 'package:jobspot/utils/file_picker_service.dart';
import 'package:jobspot/utils/states.dart';

class ApplyCompanyController extends GetxController {
  final applyCompanyState = ApplyCompanyState();

  static ApplyCompanyController get instance => Get.find();

  Future<void> uploadCvFile() async {
    final result = await FilePickerService.uploadFileCv(
      onFileUploading: (status) => applyCompanyState.uploadFileStatus =
          status == FilePickerStatus.picking,
    );
    print("file details: $result");
    if (result != null) {
      applyCompanyState.cvCompanyApply = result;
    }
  }

  Future<void> removeCvFile() async {
    applyCompanyState.cvCompanyApply = const CustomFileModel();
  }

  CompanyDetailsModel? get requestedCompanyDetails =>
      SharedGlobalDataService.instance.companyGlobalState.details;
  final companyId = SharedGlobalDataService.instance.companyGlobalState.id;
  final _states = States().obs;

  States get states => _states.value;

  Future<CompanyDetailsModel?> getCompanyById(int? id) async {
    final response = await UserCompaniesAboutsRepo.getCompanyById(id);
    final data = await response?.checkStatusResponseAndGetData(
      onValidateError: (validateError, _) {
        changeStates(isError: true, message: validateError?.message);
      },
      onError: (message, status) {
        changeStates(
          isError: true,
          isWarning: false,
          isSuccess: false,
          message: message,
        );
      },
    );
    return data;
  }

  Future<void> sendApplicationCompany(int? id) async {
    if (applyCompanyState.cvCompanyApply.isFileNull ||
        applyCompanyState.description.text.trim().isEmpty) {
      return changeStates(
        isWarning: true,
        isError: false,
        isSuccess: false,
        message: "Some required field is empty please check it.",
      );
    }
    final application = UserSendApplicationModel(
      cv: applyCompanyState.cvCompanyApply,
      description: applyCompanyState.description.text,
    );
    final response =
        await UserCompaniesAboutsRepo.applyCompany(application, id);
    await response?.checkStatusResponse(
      onSuccess: (data, _) {
        if (data != null) {
          applyCompanyState.company = data;
          SharedGlobalDataService.instance.companyGlobalState.details =
              applyCompanyState.company;
        }
        changeStates(
          isSuccess: true,
          message: 'The application is sent successfully.',
        );
      },
      onValidateError: (validateError, _) {
        changeStates(
          isError: true,
          message: "some error occurred during the application submission.",
        );
      },
      onError: (message, _) {
        changeStates(isError: true, message: message);
      },
    );
  }

  void requestCompanyDetails() async {
    changeStates(isLoading: true);
    if (requestedCompanyDetails?.id != null &&
        requestedCompanyDetails?.name != null) {
      applyCompanyState.company =
          requestedCompanyDetails ?? applyCompanyState.company;
    }
    if (companyId != -1) {
      applyCompanyState.company =
          await getCompanyById(companyId) ?? applyCompanyState.company;
    }
    changeStates(isLoading: false);
  }

  void changeStates({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    bool? isWarning,
    String? message,
    String? error,
  }) {
    _states.value = states.copyWith(
      isLoading: isLoading,
      isSuccess: isLoading == true ? false : isSuccess,
      isError: isLoading == true ? false : isError,
      message: message,
      isWarning: isLoading == true ? false : isWarning,
      error: error,
    );
  }

  Future<void> onApplySubmitted() async {
    if (states.isLoading) return;
    if (!InternetConnectionService.instance.isConnected) {
      return changeStates(
        isWarning: true,
        isError: false,
        isSuccess: false,
        message: "The connection is lost. Please"
            " reconnect to network and try again.",
      );
    }
    if (companyId == -1) return;
    changeStates(isLoading: true);
    await sendApplicationCompany(companyId);
    changeStates(isLoading: false);
  }

  @override
  void onInit() {
    requestCompanyDetails();
    super.onInit();
  }
}

class ApplyCompanyState {
  final _company = CompanyDetailsModel().obs;

  bool get hasApplied => company.hasApplied ?? false;

  CompanyDetailsModel get company => _company.value;

  void set company(CompanyDetailsModel value) {
    _company.value = value;
  }

  final _cvJobApply = const CustomFileModel().obs;

  void set cvCompanyApply(CustomFileModel value) {
    _cvJobApply.value = value;
  }

  final description = TextEditingController();

  CustomFileModel get cvCompanyApply => _cvJobApply.value;

  bool get isCvCompanyApplyNull =>
      cvCompanyApply.bytes == null && cvCompanyApply.file == null;
  final _uploadFileStatus = false.obs;

  bool get uploadFileStatus => _uploadFileStatus.isTrue;

  void set uploadFileStatus(bool value) {
    _uploadFileStatus.value = value;
  }
}
