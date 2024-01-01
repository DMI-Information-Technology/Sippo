import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sippo/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:sippo/sippo_controller/NotificationController/company_notification_application/company_notification_application_controller.dart';
import 'package:sippo/core/Refresh.dart';
import 'package:sippo/sippo_data/model/notification/notification_model.dart';
import 'package:sippo/sippo_data/notification_repo/notifications_repo.dart';
import 'package:sippo/utils/states.dart';


class CompanyNotificationController extends GetxController {
  static CompanyNotificationController get instance =>Get.find();
  final pagingController =
      PagingController<int, BaseNotificationModel?>(firstPageKey: 0);
  final notificationApplicationController =
      CompanyNotificationApplicationController.instance;
  final companyNotificationState = CompanyNotificationState();

  States get states => notificationApplicationController.states;

  void notificationReadMarker(int notificationIndex) {
    pagingController.itemList = Refresher.changePropertyItemState(
      pagingController.itemList,
      notificationIndex,
      newItemChanger: (item) => item?.copyWithSetIsRead(true),
    );
  }

  Future<void> markedNotificationAsRead(
    int notificationIndex,
    String? notificationId,
  ) async {
    if (notificationId == null) return;
    final response = await NotificationRepo.markedNotificationAsRead(
      notificationId,
    );
    await response?.checkStatusResponse(
      onSuccess: (data, _) {
        if (data != null) {
          notificationReadMarker(notificationIndex);
        }
      },
      onValidateError: (validateError, _) {},
      onError: (message, _) {},
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
    final query = {'page': "${companyNotificationState.pageNumber}"};
    final response = await NotificationRepo.fetchNotifications(query);
    response?.checkStatusResponse(
      onSuccess: (data, _) {
        final lastPage =
            data?.meta?.lastPage ?? companyNotificationState.pageNumber;
        if (companyNotificationState.pageNumber >= lastPage) {
          pagingController.appendLastPage(data?.data ?? []);
        } else {
          final newDataLength = data?.data?.length ?? 0;
          final int nextKey = pageKey + newDataLength;
          pagingController.appendPage(data?.data ?? [], nextKey);
          companyNotificationState.incrementPageNumber();
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
    companyNotificationState.pageNumber = 1;
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

class CompanyNotificationState {
  var _pageNumber = 1;

  int get pageNumber => _pageNumber.toInt();

  void set pageNumber(int value) => _pageNumber = value;

  void incrementPageNumber() => _pageNumber++;
}
