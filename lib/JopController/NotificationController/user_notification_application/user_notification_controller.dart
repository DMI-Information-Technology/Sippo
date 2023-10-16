import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jobspot/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:jobspot/sippo_data/model/notification/notification_model.dart';
import 'package:jobspot/sippo_data/notification_repo/notifications_repo.dart';
import 'package:jobspot/utils/states.dart';
import 'user_notification_application_controller.dart';

class UserNotificationController extends GetxController {
  final pagingController =
      PagingController<int, BaseNotificationModel?>(firstPageKey: 0);
  final notificationApplicationController =
      UserNotificationApplicationController.instance;
  final userNotificationState = UserNotificationState();

  States get states => notificationApplicationController.states;

  Future<void> fetchNotification(int pageKey) async {
    final query = {'page': "${userNotificationState.pageNumber}"};
    final response = await NotificationRepo.fetchNotifications(query);
    response?.checkStatusResponse(
      onSuccess: (data, _) {
        final lastPage =
            data?.meta?.lastPage ?? userNotificationState.pageNumber;
        if (userNotificationState.pageNumber >= lastPage) {
          pagingController.appendLastPage(data?.data ?? []);
        } else {
          final newDataLength = data?.data?.length ?? 0;
          final int nextKey = pageKey + newDataLength;
          pagingController.appendPage(data?.data ?? [], nextKey);
          userNotificationState.incrementPageNumber();
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

  void _pageRequester(int pageKey) async {
    notificationApplicationController.changeStates(isLoading: true);
    await fetchNotification(pageKey);
    notificationApplicationController.changeStates(isLoading: false);
  }

  void refreshPage() {
    if (InternetConnectionService.instance.isNotConnected) {
      notificationApplicationController.changeStates(
        isWarning: true,
        isSuccess: false,
        message:
            "sorry your connection is lost, please check your settings before continuing.",
      );
      return;
    }
    if (states.isLoading) return;
    userNotificationState.pageNumber = 1;
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
}

class UserNotificationState {
  var _pageNumber = 1;

  int get pageNumber => _pageNumber.toInt();

  void set pageNumber(int value) => _pageNumber = value;

  void incrementPageNumber() => _pageNumber++;
}
