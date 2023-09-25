import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jobspot/JopController/NotificationController/company_notification_application/company_notification_application_controller.dart';
import 'package:jobspot/sippo_data/company_repos/compnay_applications_repo.dart';
import 'package:jobspot/sippo_data/model/notification/job_application_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/application_change_status_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/application_job_company_model.dart';

import '../../../utils/states.dart';

class CompanyApplicationController extends GetxController {
  final pagingController =
      PagingController<int, ApplicationJobCompanyModel>(firstPageKey: 0);
  final notificationApplicationController =
      CompanyNotificationApplicationController.instance;
  final companyApplicationState = CompanyApplicationState();

  States get states => notificationApplicationController.states;

  Future<void> fetchApplications(int pageKey) async {
    final query = {'page': "${companyApplicationState.pageNumber}"};
    final response =
        await CompanyReceivedApplicationRepo.fetchApplications(query);
    response?.checkStatusResponse(
      onSuccess: (data, _) {
        final lastPage =
            data?.meta?.lastPage ?? companyApplicationState.pageNumber;
        if (companyApplicationState.pageNumber >= lastPage) {
          pagingController.appendLastPage(data?.data ?? []);
        } else {
          final newDataLength = data?.data?.length ?? 0;
          final int nextKey = pageKey + newDataLength;
          pagingController.appendPage(data?.data ?? [], nextKey);
          companyApplicationState.incrementPageNumber();
        }
      },
      onValidateError: (validateError, _) {},
      onError: (message, _) {
        pagingController.error = true;
        notificationApplicationController.changeStates(
          isError: true,
          message: message,
        );
      },
    );
  }

  Future<void> changeApplicationStatus(
    ApplicationStatusModel statusModel,
    int? applicationId,
  ) async {
    final response =
        await CompanyReceivedApplicationRepo.changeApplicationStatus(
      statusModel,
      applicationId,
    );
    response?.checkStatusResponse(
      onSuccess: (data, _) {
        if (data != null) {
          final items = pagingController.itemList;
          final index = items?.indexWhere((e) => e.id == applicationId);
          if (index != null && index != -1) {
            final item = items?[index];
            if(item!=null) {
              print(items?[index]);
              pagingController.itemList = items?.toList()
                ?..[index] = item.copyWith(
                  status: statusModel.status?.name,
                );
            }
          }
        }
      },
      onValidateError: (validateError, _) {},
      onError: (message, _) {},
    );
  }

  void _pageRequester(int pageKey) async {
    notificationApplicationController.changeStates(isLoading: true);
    await fetchApplications(pageKey);
    notificationApplicationController.changeStates(isLoading: false);
  }

  void refreshPage() {
    if (!notificationApplicationController.isNetworkConnected) {
      notificationApplicationController.changeStates(
        isWarning: true,
        isSuccess: false,
        message:
            "sorry your connection is lost, please check your settings before continuing.",
      );
      return;
    }
    if (states.isLoading) return;
    companyApplicationState.pageNumber = 1;
    pagingController.refresh();
  }

  void retryLastFieldRequest() {
    pagingController.retryLastFailedRequest();
  }

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener(_pageRequester);
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }

  Future<void> onUpdateStatusApplicationSubmitted(
    JobApplicationStatusType status,
    int? applicationId,
  ) async {
    changeApplicationStatus(
      ApplicationStatusModel(
        status: switch (status) {
          JobApplicationStatusType.Rejected =>
            JobApplicationStatusType.Rejected,
          JobApplicationStatusType.Accepted =>
            JobApplicationStatusType.Accepted,
          JobApplicationStatusType.Pending => JobApplicationStatusType.Pending,
        },
      ),
      applicationId,
    );
  }
}

class CompanyApplicationState {
  var _pageNumber = 1;

  int get pageNumber => _pageNumber.toInt();

  void set pageNumber(int value) => _pageNumber = value;

  void incrementPageNumber() => _pageNumber++;
}
