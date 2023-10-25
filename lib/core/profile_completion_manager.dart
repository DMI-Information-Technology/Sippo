import 'package:jobspot/JobGlobalclass/global_storage.dart';
import 'package:jobspot/utils/app_use.dart';

class ProfileCompletionManager {
  static const TOTAL_USER_COMPLETION = 130.0;
  static const TOTAL_COMPANY_COMPLETION = 110.0;

  static double get totalCompletionType =>
      switch (GlobalStorageService.appUse) {
        AppUsingType.user => TOTAL_USER_COMPLETION,
        AppUsingType.company => TOTAL_COMPANY_COMPLETION,
      };

  static double calculateCompletionPercentage(
    Map<String, String> messages,

  ) {
    return calculateCompletionPercentageLength(messages.length);
  }

  static double calculateCompletionPercentageLength(int length) {
    return (((totalCompletionType - (length * 10)) / totalCompletionType) * 100)
            .round() *
        1.0;
  }
}
