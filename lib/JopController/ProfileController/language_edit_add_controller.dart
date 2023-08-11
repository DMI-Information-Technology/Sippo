import 'package:get/get.dart';

import '../../Jopstobdata/model/profile_model/jobstop_language_info_card_model.dart';

class LanguageEditAddController extends GetxController {
  final _languageInfo = LanguageInfoCardModel(firstLanguage: false).obs;
  final _selectedIndexLanguage = (-1).obs;

  int get selectedIndexLanguage => _selectedIndexLanguage.toInt();

  void set selectedIndexLanguage(int value) {
    _selectedIndexLanguage.value = value;
  }

  LanguageInfoCardModel get languageInfo => _languageInfo.value;

  void setLanguageInfo({
    String? languageName,
    String? countryFlag,
    String? talkingLevel,
    String? writtenLevel,
    bool? firstLanguage,
  }) {
    _languageInfo.value = _languageInfo.value.copyWith(
      languageName: languageName,
      countryFlag: countryFlag,
      talkingLevel: talkingLevel,
      writtenLevel: writtenLevel,
      firstLanguage: firstLanguage,
    );
  }
}
