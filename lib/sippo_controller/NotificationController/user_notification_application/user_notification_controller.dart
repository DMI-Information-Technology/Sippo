import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sippo/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:sippo/core/Refresh.dart';
import 'package:sippo/sippo_data/model/notification/notification_model.dart';
import 'package:sippo/sippo_data/notification_repo/notifications_repo.dart';
import 'package:sippo/utils/states.dart';

import 'user_notification_application_controller.dart';

class UserNotificationController extends GetxController {
  static UserNotificationController get instance => Get.find();
  final _isNotificationsEmpty = true.obs;

  bool get isNotificationsEmpty => _isNotificationsEmpty.isTrue;
  final pagingController =
      PagingController<int, BaseNotificationModel?>(firstPageKey: 0);
  final notificationApplicationController =
      UserNotificationApplicationController.instance;
  final userNotificationState = UserNotificationState();

  States get states => notificationApplicationController.states;

  void notificationReadMarker(int notificationIndex, bool isRead) {
    pagingController.itemList = Refresher.changePropertyItemState(
      pagingController.itemList,
      notificationIndex,
      newItemChanger: (item) => item?.copyWithSetIsRead(isRead),
    );
  }

  final isReading = false.obs;

  Future<void> markedNotificationAsRead(
    int notificationIndex,
    String? notificationId,
  ) async {
    if (notificationId == null) return;
    notificationReadMarker(notificationIndex, true);
    isReading.value = true;
    final response = await NotificationRepo.markedNotificationAsRead(
      notificationId,
    );
    isReading.value = false;
    await response?.checkStatusResponse(
      onError: (message, _) => notificationReadMarker(notificationIndex, false),
    );
  }

  void _resetNotificationAfterFailedRemover(
    int index,
    List<BaseNotificationModel?> temp,
    BaseNotificationModel? item,
  ) {
    if (index < temp.length) {
      pagingController.itemList = temp.toList()..add(item);
      return;
    }
    pagingController.itemList = temp.toList()..insert(index, item);
  }

  Future<void> removedNotification(int index, String? notificationId) async {
    if (isReading.isTrue) return;
    final temp = pagingController.itemList?.toList();
    if (temp == null) return;
    final item = temp[index];
    pagingController.itemList = temp..removeAt(index);
    final response = await NotificationRepo.removeNotification(notificationId);
    await response?.checkStatusResponse(
      onSuccess: (data, _) => _,
      onValidateError: (validateError, _) {
        _resetNotificationAfterFailedRemover(index, temp, item);
      },
      onError: (message, _) {
        _resetNotificationAfterFailedRemover(index, temp, item);
      },
    );
  }

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
        _isNotificationsEmpty.value = false;
      },
      onValidateError: (validateError, _) {
        _isNotificationsEmpty.value = true;
      },
      onError: (message, _) {
        _isNotificationsEmpty.value = true;
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
        message: "connection_lost_message_1".tr,
      );
      return;
    }
    if (states.isLoading) return;
    userNotificationState.pageNumber = 1;
    pagingController.refresh();
  }

  void retryLastFieldRequest() => pagingController.retryLastFailedRequest();

  void pagingControllerListener() {
    notificationApplicationController.showNotificationReadAllButton.status =
        pagingController.itemList?.isNotEmpty == true;
  }

  @override
  void onInit() {
    super.onInit();
    pagingController.addListener(pagingControllerListener);
    pagingController.addPageRequestListener(_pageRequester);
  }

  @override
  void onClose() {
    pagingController.removeListener(pagingControllerListener);
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
