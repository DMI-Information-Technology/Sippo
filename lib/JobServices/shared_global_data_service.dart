import 'package:get/get.dart';

import '../sippo_data/model/auth_model/company_response_details.dart';
import '../sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';
import '../utils/global_shared_state.dart';

class SharedGlobalDataService extends GetxService {
  static SharedGlobalDataService get instance => Get.find();
  final  jobDashboardState =
  GlobalSharedState(details: CompanyJobModel().obs);
  final companyDashboardState = GlobalSharedState(
    details: CompanyDetailsResponseModel().obs,
  );
  var searchTextKey = "";
}
