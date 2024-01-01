import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sippo/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:sippo/JobServices/shared_global_data_service.dart';
import 'package:sippo/custom_app_controller/switch_status_controller.dart';
import 'package:sippo/sippo_data/model/custom_file_model/custom_file_model.dart';
import 'package:sippo/sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';
import 'package:sippo/sippo_data/model/profile_model/profile_resource_model/user_job_application_model.dart';
import 'package:sippo/sippo_data/user_repos/user_jobs_repo.dart';
import 'package:sippo/utils/file_picker_service.dart';
import 'package:sippo/utils/states.dart';

class ApplyJobsController extends GetxController {
  final applyJobsState = ApplyJobsState();
  final loadingController = SwitchStatusController();

  static ApplyJobsController get instance => Get.find();

  Future<void> uploadCvFile() async {
    loadingController.start();
    final result = await FilePickerService.uploadFileCv(
      onFileUploading: (status) =>
          applyJobsState.uploadFileStatus = status == FilePickerStatus.picking,
    );
    loadingController.pause();
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
    // if (applyJobsState.cvJobApply.isFileNull ||
    //     applyJobsState.description.text.trim().isEmpty) {
    //   return changeStates(
    //     isWarning: true,
    //     isError: false,
    //     isSuccess: false,
    //     message: "required_field_empty".tr,
    //   );
    // }
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
          message: 'application_sent_message'.tr,
        );
      },
      onValidateError: (validateError, _) {
        changeStates(
          isError: true,
          message: validateError?.message,
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
    print(applyJobsState.jopDetails.application);
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
        message: "connection_lost_message_1".tr,
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

  @override
  void onClose() {
    loadingController.dispose();
    super.onClose();
  }
}

class ApplyJobsState {
  final _isHeightOverAppBar = false.obs;

  bool get isHeightOverAppBar => _isHeightOverAppBar.isTrue;

  set isHeightOverAppBar(bool value) => _isHeightOverAppBar.value = value;
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
