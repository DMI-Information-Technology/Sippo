import 'package:get/get.dart';
import 'package:jobspot/JopController/sippo_search_controller/user_filter_search.dart';

class SearchJobsFilterBindingController implements Bindings {
  @override
  void dependencies() {
    Get.put<SippoFilterSearchController>(SippoFilterSearchController());
  }

  const SearchJobsFilterBindingController();
}
