import 'package:get/get.dart';
import '../../sippo_data/model/profile_model/profile_widget_model/jobstop_language_info_card_model.dart';

class LanguageEditAddController extends GetxController {
  final _languageInfo = LanguageInfoCardModel(firstLanguage: false,talkingLevel: "no level",writtenLevel: "no level").obs;
  final _selectedIndexLanguage = (-1).obs;
  final _selectedLevel = 'no level'.obs;

  String get selectedLevel => _selectedLevel.toString();

  void set selectedLevel(String value) {
    _selectedLevel.value = value;
  }

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
