import 'dart:ui';

import 'package:get/get.dart';
import 'package:jobspot/JopController/dashboards_controller/user_dashboard_controller.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';
import 'package:jobspot/utils/states.dart';

import '../../JobGlobalclass/jobstopcolor.dart';
import '../../sippo_data/user_repos/user_jobs_repo.dart';

class JobCompanyDetailsController extends GetxController {
  static JobCompanyDetailsController get instance => Get.find();

  CompanyJobModel get requestedJobDetails =>
      UserDashBoardController.instance.jobDashboardState.details;

  int get jobId => UserDashBoardController.instance.jobDashboardState.id;

  final jobDetailsState = JobCompanyDetailsState();
  final _states = States().obs;

  States get states => _states.value;

  Future<CompanyJobModel?> getJobById(int id) async {
    final response = await UserJobRepo.getJobById(id);
    final data = await response?.checkStatusResponseAndGetData(
      onValidateError: (validateError, _) {
        changeStates(isError: true, error: validateError?.message);
      },
      onError: (message, _) {
        changeStates(isError: true, error: message);
      },
    );
    return data;
  }

  void requestJobDetails() async {
    changeStates(isLoading: true);
    if (requestedJobDetails.id != null && requestedJobDetails.title != null) {
      jobDetailsState.jopDetails = requestedJobDetails;
    }

    if (jobId != -1) {
      jobDetailsState.jopDetails =
          await getJobById(jobId) ?? jobDetailsState.jopDetails;
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
    print("is loading:  $isLoading");
    _states.value = states.copyWith(
      isLoading: isLoading,
      isSuccess: isLoading == true ? false : isSuccess,
      isError: isLoading == true ? false : isError,
      message: message,
      isWarning: isLoading == true ? false : isWarning,
      error: error,
    );
  }

  @override
  void onInit() {
    requestJobDetails();
    super.onInit();
  }
}

class JobCompanyDetailsState {
  final _jopDetails = CompanyJobModel().obs;

  CompanyJobModel get jopDetails => _jopDetails.value;

  void set jopDetails(CompanyJobModel value) {
    _jopDetails.value = value;
  }

  final _selectedPageView = 0.obs;

  int get selectedPageView => _selectedPageView.toInt();

  Color changeDescriptionButtonColor() => selectedPageView == 0
      ? Jobstopcolor.primarycolor
      : Jobstopcolor.lightprimary;

  Color changeCompanyButtonColor() => selectedPageView == 1
      ? Jobstopcolor.primarycolor
      : Jobstopcolor.lightprimary;

  void set selectedPageView(int value) {
    _selectedPageView.value = value;
  }

  void switchPageView() => selectedPageView = selectedPageView == 0 ? 1 : 0;
}
