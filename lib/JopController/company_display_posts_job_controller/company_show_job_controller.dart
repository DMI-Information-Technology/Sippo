import 'dart:async';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jobspot/JopController/company_display_posts_job_controller/company_show_job_post_wrapper_controller.dart';
import 'package:jobspot/sippo_data/company_user/company_job_repo.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../sippo_data/model/auth_model/company_response_details.dart';
import '../../utils/states.dart';

class CompanyShowJobController extends GetxController {
  final pagingController =
      PagingController<int, CompanyJobModel>(firstPageKey: 0);
  final showWrapperController = CompanyShowJobPostWrapperController.instance;

  States get states => showWrapperController.states;

  void refreshJobsAfterEdit(dynamic value) {
    if (value is bool && value.runtimeType == bool && value == true) {
      refreshPage();
    }
  }

  final jobState = CompanyShowJobState();

  CompanyResponseDetailsModel get company => showWrapperController.company;

  Future<void> fetchJobPages(int pageKey) async {
    final query = {'page': "${jobState.pageNumber}"};
    final response = await CompanyJobRepo.fetchJobs(query);
    response?.checkStatusResponse(
      onSuccess: (data, _) {
        final lastPage = data?.meta?.lastPage ?? jobState.pageNumber;
        if (jobState.pageNumber >= lastPage) {
          pagingController.appendLastPage(data?.data ?? []);
        } else {
          final newDataLength = data?.data?.length ?? 0;
          final int nextKey = pageKey + newDataLength;
          pagingController.appendPage(data?.data ?? [], nextKey);
          jobState.incrementPageNumber();
        }
      },
      onValidateError: (validateError, _) {},
      onError: (message, _) {
        pagingController.error = true;
        showWrapperController.changeStates(isError: true, message: message);
      },
    );
  }

  Future<void> updateStatusJobById(int? id) async {
    showWrapperController.changeStates(isLoading: true);
    final response = await CompanyJobRepo.updateStatusJobById(id);
    final result = await response?.checkStatusResponseAndGetData(
      onValidateError: (validateError, _) {
        showWrapperController.changeStates(
            isError: true, error: validateError?.message);
      },
      onError: (message, _) {
        showWrapperController.changeStates(isError: true, message: message);
      },
    );
    showWrapperController.changeStates(isLoading: false);
    if (result != null) {
      refreshPage();
      showWrapperController.changeStates(
        isSuccess: true,
        message: 'the job status is updated successfully.',
      );
    }
  }

  Future<void> onUpdateStatusJobSubmitted(int? postId) async {
    if (!showWrapperController.isNetworkConnected) {
      showWrapperController.changeStates(
        isWarning: true,
        isSuccess: false,
        message:
            "sorry your connection is lost, please check your settings before continuing.",
      );
      return;
    }
    showWrapperController.changeStates(isLoading: true);
    await updateStatusJobById(postId);
  }

  void refreshPage() {
    if (!showWrapperController.isNetworkConnected) {
      showWrapperController.changeStates(
        isWarning: true,
        isSuccess: false,
        message:
            "sorry your connection is lost, please check your settings before continuing.",
      );
      return;
    }
    if (states.isLoading) return;
    jobState.pageNumber = 1;
    pagingController.refresh();
  }

  void retryLastFieldRequest() {
    pagingController.retryLastFailedRequest();
  }

  void _pageRequester(int pageKey) async {
    showWrapperController.changeStates(isLoading: true);
    await fetchJobPages(pageKey);
    showWrapperController.changeStates(isLoading: false);
  }

  Future<void> lunchMapWithLocation(double? lat, double? long) async {
    print("is work place is null? ${long == null || lat == null}");
    if (long == null || lat == null) return;
    try {
      !await launchUrl(Uri.parse("http://maps.google.com/?ll=$lat,$long"));
    } catch (e, s) {
      print(e);
      print(s);
    }
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

class CompanyShowJobState {
  var _pageNumber = 1;

  int get pageNumber => _pageNumber.toInt();

  void set pageNumber(int value) => _pageNumber = value;

  void incrementPageNumber() => _pageNumber++;
}