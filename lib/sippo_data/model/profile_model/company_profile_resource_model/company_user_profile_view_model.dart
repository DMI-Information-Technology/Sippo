import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/application_job_company_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/education_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/language_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/profile_edit_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/skills_model.dart';

import '../../image_resource_model/image_resource_model.dart';
import '../profile_resource_model/work_experiences_model.dart';

class ProfileViewResourceModel {
  final ProfileInfoModel? userInfo;
  final ImageResourceModel? image;
  final CvModel? cv;
  final List<WorkExperiencesModel>? workExperiences;
  final List<EducationModel>? educations;
  final SkillsModel? skills;
  final List<LanguageModel>? languages;

  const ProfileViewResourceModel({
    this.userInfo,
    this.image,
    this.cv,
    this.workExperiences,
    this.educations,
    this.skills,
    this.languages,
  });

  factory ProfileViewResourceModel.fromJson(Map<String, dynamic> json) {
    return ProfileViewResourceModel(
      userInfo: ProfileInfoModel(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        secondaryPhone: json["secondary_phone"],
        email: json["email"],
        gender: json["gender"],
        bio: json["bio"],
      ),
      image: json["profile_image"] != null
          ? ImageResourceModel.fromJson(json["profile_image"])
          : null,
      cv: json["cv"] != null ? CvModel.fromJson(json["cv"]) : null,
      workExperiences: json["work_experiences"] is List
          ? List.of(json["work_experiences"])
              .map((e) => WorkExperiencesModel.fromJson(e))
              .toList()
          : null,
      educations: json["educations"] is List
          ? List.of(json["educations"])
              .map((e) => EducationModel.fromJson(e))
              .toList()
          : null,
      skills: SkillsModel.fromViewJson(json),
      languages: json["languages"] is List
          ? List.of(json["languages"])
              .map((e) => LanguageModel.fromJson(e))
              .toList()
          : null,
    );
  }
}
