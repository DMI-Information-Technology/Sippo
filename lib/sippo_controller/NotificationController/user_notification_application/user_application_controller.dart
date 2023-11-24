import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jobspot/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/custom_app_controller/switch_status_controller.dart';
import 'package:jobspot/sippo_data/model/application_model/application_job_company_model.dart';
import 'package:jobspot/sippo_data/user_repos/user_applications_repo.dart';
import 'package:jobspot/utils/file_downloader_service.dart';
import 'package:jobspot/utils/states.dart';

import 'user_notification_application_controller.dart';

class UserApplicationController extends GetxController {
  static UserApplicationController get instance => Get.find();
  final pagingController =
      PagingController<int, ApplicationUserModel>(firstPageKey: 0);
  final notificationApplicationController =
      UserNotificationApplicationController.instance;
  final userApplicationState = UserApplicationState();
  final _states = States().obs;

  States get notStates => notificationApplicationController.states;

  States get states => _states.value;

  set states(States value) => _states.value = value;

  Future<void> fetchApplications(int pageKey) async {
    final query = {'page': "${userApplicationState.pageNumber}"};
    final response = await UserReceivedApplicationRepo.fetchApplications(query);
    response?.checkStatusResponse(
      onSuccess: (data, _) {
        final lastPage =
            data?.meta?.lastPage ?? userApplicationState.pageNumber;
        if (userApplicationState.pageNumber >= lastPage) {
          pagingController.appendLastPage(data?.data ?? []);
        } else {
          final newDataLength = data?.data?.length ?? 0;
          final int nextKey = pageKey + newDataLength;
          pagingController.appendPage(data?.data ?? [], nextKey);
          userApplicationState.incrementPageNumber();
        }
      },
      onError: (message, _) {
        pagingController.error = true;
        notificationApplicationController.changeStates(
          isError: true,
          message: message,
        );
      },
    );
  }

  Future<void> removeApplication(int? applicationId) async {
    if (InternetConnectionService.instance.isNotConnected) return;
    if (states.isLoading) return;
    states = States(isLoading: true);
    final response = await UserReceivedApplicationRepo.deleteApplication(
      applicationId,
    );
    states = States(isLoading: false);

    await response.checkStatusResponse(
      onSuccess: (data, statusType) {
        refreshPage();
        states = States(isSuccess: false);
      },
      onError: (message, statusType) {
        states = States(isError: false, message: message);
      },
    );
  }

  void _pageRequester(int pageKey) async {
    notificationApplicationController.changeStates(isLoading: true);
    await fetchApplications(pageKey);
    notificationApplicationController.changeStates(isLoading: false);
  }

  void refreshPage() {
    if (InternetConnectionService.instance.isNotConnected) {
      notificationApplicationController.changeStates(
        isWarning: true,
        isSuccess: false,
        message: "connection_lost_message_1".tr,
      );
      return;
    }
    if (notStates.isLoading) return;
    userApplicationState.pageNumber = 1;
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
    loadingController.dispose();
    super.onClose();
  }

  final loadingController = SwitchStatusController();

  void openFile(String? url, String? size) {
    if (url == null) return;
    FileDownloader.openFile(
      url,
      size: size,
      fn: (value) => loadingController.status = value,
    );
  }
}

class UserApplicationState {
  var _pageNumber = 1;

  int get pageNumber => _pageNumber.toInt();

  void set pageNumber(int value) => _pageNumber = value;

  void incrementPageNumber() => _pageNumber++;
  final _application = ApplicationUserModel().obs;

  ApplicationUserModel get application => _application.value;

  set application(ApplicationUserModel value) {
    _application.value = value;
  }
}
