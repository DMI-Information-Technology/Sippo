import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../JobGlobalclass/jobstopimges.dart';
import '../../sippo_data/model/profile_model/jobstop_appreciation_info_card_model.dart';
import '../../sippo_data/model/profile_model/jobstop_education_info_card_model.dart';
import '../../sippo_data/model/profile_model/jobstop_language_info_card_model.dart';
import '../../sippo_data/model/profile_model/jobstop_resume_file_info.dart';
import '../../sippo_data/model/profile_model/jobstop_work_experience_info_card_model.dart';
class ProfileUserController extends GetxController {
  final _aboutMeText =
      "lorem ipsujfm vcxmkmvfkjhkgd jkflmvf lkfvmfdv klffdleoopmmvfmlvk ijggjjm,dfvom,.m,mcxvomfm "
          .obs;
  final _showAllWei = false.obs;
  final _showAllEdui = false.obs;
  final _showAllAppreciations = false.obs;
  final _showAllSkills = false.obs;
  final _showAllLangs = false.obs;

  bool get showAllLangs => _showAllLangs.isTrue;

  void set showAllLangs(bool value) {
    _showAllLangs.value = value;
  }

  final Rx<ResumeFileInfo?> _resumeFiles = ResumeFileInfo.getNull().obs;

  ResumeFileInfo? get resumeFiles => _resumeFiles.value;

  void set resumeFiles(ResumeFileInfo? value) {
    _resumeFiles.value = value;
  }

  final _wei = <WorkExperienceInfoCardModel>[
    WorkExperienceInfoCardModel(
      position: "Manager",
      company: "Amazon Inc",
      periodic: "Jan 2015 - Feb 2022",
    ),
    WorkExperienceInfoCardModel(
      position: "Manager",
      company: "Amazon Inc",
      periodic: "Jan 2015 - Feb 2022",
    ),
    WorkExperienceInfoCardModel(
      position: "Manager",
      company: "Amazon Inc",
      periodic: "Jan 2015 - Feb 2022",
    ),
  ].obs;
  final _edui = <EducationInfoCardModel>[
    EducationInfoCardModel(
      level: "Bachelor of Information Technology",
      university: "University of Oxford",
      fieldStudy: "Information Technology",
      periodic: "Jan 2010 - Feb 2013",
    ),
    EducationInfoCardModel(
      level: "Bachelor of Information Technology",
      university: "University of Oxford",
      fieldStudy: "Information Technology",
      periodic: "Jan 2010 - Feb 2013",
    ),
    EducationInfoCardModel(
      level: "Bachelor of Information Technology",
      university: "University of Oxford",
      fieldStudy: "Information Technology",
      periodic: "Jan 2010 - Feb 2013",
    ),
  ].obs;
  final _skills = <String>[
    "skill 1",
    "skill skill 2",
    "skill 3",
    "skill skill skill 4",
    "skill skill 5",
    "skill skill skill skill 6",
  ].obs;
  final _languages = <LanguageInfoCardModel>[
    LanguageInfoCardModel(
      countryFlag: JobstopPngImg.english,
      languageName: "English",
      talkingLevel: "Advanced",
      writtenLevel: "Advanced",
    ),
    LanguageInfoCardModel(
      countryFlag: JobstopPngImg.arabic,
      languageName: "arabic",
      talkingLevel: "Advanced",
      writtenLevel: "Advanced",
    ),
  ].obs;
  final _appreciations = <AppreciationInfoCardModel>[
    AppreciationInfoCardModel(
      awardName: "Wireless Symposium (RWS)",
      categoryAchieve: "Young Scientist",
      year: "2014",
    ),
    AppreciationInfoCardModel(
      awardName: "Wireless Symposium (RWS)",
      categoryAchieve: "Young Scientist",
      year: "2014",
    ),
    AppreciationInfoCardModel(
      awardName: "Wireless Symposium (RWS)",
      categoryAchieve: "Young Scientist",
      year: "2014",
    ),
  ].obs;

  List<AppreciationInfoCardModel> get appreciations => _appreciations.toList();

  List<WorkExperienceInfoCardModel> get wei => _wei.toList();

  List<EducationInfoCardModel> get edui => _edui.toList();

  List<LanguageInfoCardModel> get languages => _languages.toList();

  List<String> get skills => _skills.toList();

  String get aboutMeText => _aboutMeText.toString();

  bool get showAllAppreciations => _showAllAppreciations.isTrue;

  bool get showAllWei => _showAllWei.isTrue;

  bool get showAllEdui => _showAllEdui.isTrue;

  bool get showAllSkills => _showAllSkills.isTrue;

  void set showAllSkills(bool value) {
    _showAllSkills.value = value;
  }

  void set showAllWei(bool value) {
    _showAllWei.value = value;
  }

  void set showAllEdui(bool value) {
    _showAllEdui.value = value;
  }

  set showAllAppreciations(bool value) {
    _showAllAppreciations.value = value;
  }
}
