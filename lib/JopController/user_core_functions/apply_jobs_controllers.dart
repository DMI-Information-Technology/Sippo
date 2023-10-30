import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/JobServices/shared_global_data_service.dart';
import 'package:jobspot/sippo_data/model/custom_file_model/custom_file_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/user_job_application_model.dart';
import 'package:jobspot/sippo_data/user_repos/user_jobs_repo.dart';
import 'package:jobspot/utils/file_picker_service.dart';
import 'package:jobspot/utils/states.dart';

class ApplyJobsController extends GetxController {
  final applyJobsState = ApplyJobsState();

  static ApplyJobsController get instance => Get.find();

  Future<void> uploadCvFile() async {
    final result = await FilePickerService.uploadFileCv(
      onFileUploading: (status) =>
          applyJobsState.uploadFileStatus = status == FilePickerStatus.picking,
    );
    print("file details: $result");
    if (result != null) {
      applyJobsState.cvJobApply = result;
    }
  }

  Future<void> removeCvFile() async {
    applyJobsState.cvJobApply = const CustomFileModel();
  }

  CompanyJobModel? get requestedJobDetails =>
      SharedGlobalDataService.instance.jobGlobalState.details;
  int get jobId => SharedGlobalDataService.instance.jobGlobalState.id;
  final _states = States().obs;

  States get states => _states.value;

  Future<CompanyJobModel?> getJobById(int? id) async {
    final response = await SippoJobsRepo.getJobById(id);
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

  Future<void> sendApplicationJob(int? id) async {
    if (applyJobsState.cvJobApply.isFileNull ||
        applyJobsState.description.text.trim().isEmpty) {
      return changeStates(
        isWarning: true,
        isError: false,
        isSuccess: false,
        message: "Some required field is empty please check it.",
      );
    }
    final application = UserSendApplicationModel(
      cv: applyJobsState.cvJobApply,
      description: applyJobsState.description.text,
    );
    final response =
        await SippoJobsRepo.sendApplicationJob(application, "$id/apply");
    await response?.checkStatusResponse(
      onSuccess: (data, _) {
        if (data != null) {
          applyJobsState.jopDetails = applyJobsState.jopDetails.copyWith(
            hasApplied: true,
            application: data,
          );
          SharedGlobalDataService.instance.jobGlobalState.details =
              applyJobsState.jopDetails;
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

  void requestJobDetails() async {
    _states.value = States(isLoading: true);
    final job = requestedJobDetails;
    if (job == null || job.isJobContentBlank || jobId == -1) {
      _states.value = States(isLoading: false);
      return;
    }
    applyJobsState.jopDetails = job;
    if (job.application == null) {
      applyJobsState.jopDetails =
          await getJobById(jobId) ?? applyJobsState.jopDetails;
    }
    _states.value = States(isLoading: false);
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
    if (requestedJobDetails?.id == -1) return;
    changeStates(isLoading: true);
    await sendApplicationJob(requestedJobDetails?.id);
    changeStates(isLoading: false);
  }

  @override
  void onInit() {
    requestJobDetails();
    super.onInit();
  }
}

class ApplyJobsState {
  final _jopDetails = CompanyJobModel().obs;

  bool get hasApplied => jopDetails.hasApplied ?? false;

  CompanyJobModel get jopDetails => _jopDetails.value;

  void set jopDetails(CompanyJobModel value) {
    _jopDetails(value);
    _jopDetails.value = value;
  }

  final _cvJobApply = const CustomFileModel().obs;

  void set cvJobApply(CustomFileModel value) {
    _cvJobApply.value = value;
  }

  final description = TextEditingController();

  CustomFileModel get cvJobApply => _cvJobApply.value;

  bool get isCvJobApplyNull =>
      cvJobApply.bytes == null && cvJobApply.file == null;
  final _uploadFileStatus = false.obs;

  bool get uploadFileStatus => _uploadFileStatus.isTrue;

  void set uploadFileStatus(bool value) {
    _uploadFileStatus.value = value;
  }
}
