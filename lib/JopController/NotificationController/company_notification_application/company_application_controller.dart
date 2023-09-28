import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jobspot/JopController/NotificationController/company_notification_application/company_notification_application_controller.dart';
import 'package:jobspot/sippo_data/company_repos/compnay_applications_repo.dart';
import 'package:jobspot/sippo_data/model/notification/job_application_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/application_change_status_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/application_job_company_model.dart';
import 'package:jobspot/utils/storage_permission_service.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../../../utils/file_downloader_service.dart';
import '../../../utils/states.dart';

class CompanyApplicationController extends GetxController {
  final pagingController =
      PagingController<int, ApplicationCompanyModel>(firstPageKey: 0);
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
            if (item != null) {
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
    ApplicationStatusType status,
    int? applicationId,
  ) async {
    changeApplicationStatus(
      ApplicationStatusModel(
        status: switch (status) {
          ApplicationStatusType.Rejected => ApplicationStatusType.Rejected,
          ApplicationStatusType.Accepted => ApplicationStatusType.Accepted,
          ApplicationStatusType.Pending => ApplicationStatusType.Pending,
        },
      ),
      applicationId,
    );
  }

  void openFile(String fileUrl) async {
    if (!notificationApplicationController.isNetworkConnected) return;
    notificationApplicationController.loadingOverlayController.startLoading();
    final hasPermission = await StoragePermissionsService.storageRequested(
      DeviceInfoPlugin(),
    );
    if (!hasPermission) {
      notificationApplicationController.loadingOverlayController.pauseLoading();
      return;
    }
    final fileDownloader = FileDownloader();
    final String fileName = fileUrl.split('/').last;
    final downloadData = <int>[];
    Directory downloadDirectory;
    if (Platform.isIOS) {
      downloadDirectory = await getApplicationDocumentsDirectory();
    } else {
      downloadDirectory = Directory('/storage/emulated/0/Download');
      if (!downloadDirectory.existsSync())
        downloadDirectory = (await getExternalStorageDirectory())!;
    }
    final filePathName = "${downloadDirectory.path}/$fileName";
    final savedFile = File(filePathName);
    if (!savedFile.existsSync()) {
      notificationApplicationController.loadingOverlayController.pauseLoading();
      return;
    }
    fileDownloader.downloadFileListener(
      url: fileUrl,
      onData: (d) {
        downloadData.addAll(d);
      },
      onDone: () {
        final raf = savedFile.openSync(mode: FileMode.write);
        raf.writeFromSync(downloadData);
        raf.closeSync();
        fileDownloader.close();
        notificationApplicationController.loadingOverlayController
            .pauseLoading();
        OpenFile.open(savedFile.path);
      },
      onError: (e, s) {
        print(e);
        print(s);
        notificationApplicationController.loadingOverlayController
            .pauseLoading();
        fileDownloader.close();
      },
    );
  }
}

class CompanyApplicationState {
  var _pageNumber = 1;

  int get pageNumber => _pageNumber.toInt();

  void set pageNumber(int value) => _pageNumber = value;

  void incrementPageNumber() => _pageNumber++;
}
