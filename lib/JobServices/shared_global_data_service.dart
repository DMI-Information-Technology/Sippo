import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/routes.dart';
import 'package:jobspot/sippo_data/model/auth_model/company_response_details.dart';
import 'package:jobspot/sippo_data/model/job_statistics_model/job_statistics_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/company_user_profile_view_model.dart';
import 'package:jobspot/utils/global_shared_state.dart';

class SharedGlobalDataService extends GetxService {
  static SharedGlobalDataService get instance => Get.find();
  static const SELECTED_TAP_INDEX = 'selected_tap_index';
  var searchTextKey = "";
  JobStatisticsData? jobStatistics;
  var profileIdState = -1;
  final jobGlobalState = GlobalSharedState(details: CompanyJobModel().obs);
  final profileViewGlobalState =
      GlobalSharedState(details: ProfileViewResourceModel().obs);
  final companyGlobalState = GlobalSharedState(
    details: CompanyDetailsModel().obs,
  );

  static Future<void> onJobTap(
    CompanyJobModel? item, {
    Map<String, dynamic>? args,
  }) async {
    final localInstance = instance;
    final id = item?.id;
    if (id == null) return;
    localInstance.jobGlobalState.id = id;
    localInstance.jobGlobalState.details = item;
    await Get.toNamed(SippoRoutes.sippoJobDescription);
    localInstance.jobGlobalState.clearDetails(() => CompanyJobModel());
  }

  static void onJobTapWithID(
    int? id, {
    Map<String, dynamic>? args,
  }) async {
    await onJobTap(CompanyJobModel(id: id), args: args);
  }

  static Future<void> onCompanyTap(
    CompanyDetailsModel? item, {
    Map<String, dynamic>? args,
  }) async {
    final localInstance = instance;
    final id = item?.id;
    if (id == null) return;
    localInstance.companyGlobalState.args = args;
    localInstance.companyGlobalState.id = id;
    localInstance.companyGlobalState.details = item;
    await Get.toNamed(SippoRoutes.sippoAboutCompanies);
    localInstance.companyGlobalState.clearDetails(() => CompanyDetailsModel());
  }

  static void onProfileViewTap({
    ProfileViewResourceModel? item,
    int? profId,
    Map<String, dynamic>? args,
  }) async {
    final localInstance = instance;
    final id = item?.userInfo?.id ?? profId;
    if (id == null) return;
    localInstance.profileViewGlobalState.id = id;
    localInstance.profileViewGlobalState.details = item;
    await Get.toNamed(SippoRoutes.sippoCompanyUserProfileView, arguments: args);
    localInstance.profileViewGlobalState.clearDetails(
      () => ProfileViewResourceModel(),
    );
  }
}
