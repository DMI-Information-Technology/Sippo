import 'package:get/get.dart';
import 'package:jobspot/sippo_data/model/image_resource_model/image_resource_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/cv_file_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/education_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/language_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/profile_edit_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/skills_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/user_projects_model.dart';
import 'package:jobspot/utils/helper.dart';

import '../profile_resource_model/work_experiences_model.dart';

class ProfileViewResourceModel {
  final ProfileInfoModel? userInfo;
  final ImageResourceModel? image;
  final CvModel? cv;
  final List<WorkExperiencesModel>? workExperiences;
  final List<EducationModel>? educations;
  final SkillsModel? skills;
  final List<LanguageModel>? languages;
  final List<UserProjectsModel>? projects;

  const ProfileViewResourceModel({
    this.userInfo,
    this.image,
    this.cv,
    this.workExperiences,
    this.educations,
    this.skills,
    this.languages,
    this.projects,
  });

  Map<String, String> blankProfileMessages() {
    return {
      if (userInfo?.bio == null || userInfo?.bio?.isBlank == true)
        'bio': "You have not entered a bio for your profile account.",
      if (userInfo?.gender == null || userInfo?.gender?.isBlank == true)
        'gender': "You have not selected a gender for your profile account.",
      if (userInfo?.secondaryPhone == null ||
          userInfo?.secondaryPhone?.isBlank == true)
        'secondary_phone':
            "The profile account does not have an secondary phone number.",
      if (userInfo?.email == null || userInfo?.email?.isBlank == true)
        'email': "The profile account does not have an email address.",
      if (image == null || image?.url == null || image?.url?.isBlank == true)
        'image': "The profile account does not have an image profile.",
      if (cv == null || cv?.url == null || cv?.url?.isBlank == true)
        'cv': "The profile account does not have cv.",
      if (workExperiences == null || workExperiences?.isBlank == true)
        'work_experiences': "The profile account does not have an educations.",
      if (educations == null || educations?.isBlank == true)
        'educations': "The profile account does not have an educations.",
      if (skills == null || skills?.isBlank == true)
        'skills': "The profile account does not have an skills.",
      if (languages == null || languages?.isBlank == true)
        'languages': "The profile account does not have an languages.",
      if (projects == null || projects?.isBlank == true)
        'projects': "The profile account does not have an projects.",
    };
  }

  factory ProfileViewResourceModel.fromJson(Map<String, dynamic>? json) {
    return ProfileViewResourceModel(
      userInfo: ProfileInfoModel(
        id: json?["id"],
        name: json?["name"],
        phone: json?["phone"],
        secondaryPhone: json?["secondary_phone"],
        email: json?["email"],
        gender: json?["gender"],
        bio: json?["bio"],
      ),
      image: json?["profile_image"] != null
          ? ImageResourceModel.fromJson(json?["profile_image"])
          : null,
      cv: json?["cv"] != null ? CvModel.fromJson(json?["cv"]) : null,
      workExperiences: json?["work_experiences"] is List
          ? List.of(json?["work_experiences"])
              .map((e) => WorkExperiencesModel.fromJson(e))
              .toList()
          : null,
      educations: json?["educations"] is List
          ? List.of(json?["educations"])
              .map((e) => EducationModel.fromJson(e))
              .toList()
          : null,
      projects: json?["projects"] is List
          ? List.of(json?["projects"])
              .map((e) => UserProjectsModel.fromJson(e))
              .toList()
          : null,
      skills: SkillsModel.fromViewJson(json),
      languages: json?["languages"] is List
          ? List.of(json?["languages"])
              .map((e) => LanguageModel.fromJson(e))
              .toList()
          : null,
    );
  }

  ProfileViewResourceModel copyWith({
    ProfileInfoModel? userInfo,
    ImageResourceModel? image,
    CvModel? cv,
    List<WorkExperiencesModel>? workExperiences,
    List<EducationModel>? educations,
    SkillsModel? skills,
    List<LanguageModel>? languages,
    List<UserProjectsModel>? projects,
  }) {
    return ProfileViewResourceModel(
      userInfo: userInfo ?? this.userInfo,
      image: image ?? this.image,
      cv: cv ?? this.cv,
      workExperiences: workExperiences ?? this.workExperiences,
      educations: educations ?? this.educations,
      skills: skills ?? this.skills,
      languages: languages ?? this.languages,
      projects: projects ?? this.projects,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileViewResourceModel &&
          runtimeType == other.runtimeType &&
          userInfo == other.userInfo &&
          image == other.image &&
          cv == other.cv &&
          listEquality(workExperiences, other.workExperiences) &&
          listEquality(educations, other.educations) &&
          skills == other.skills &&
          listEquality(languages, other.languages) &&
          listEquality(projects, other.projects);

  @override
  int get hashCode =>
      userInfo.hashCode ^
      image.hashCode ^
      cv.hashCode ^
      workExperiences.hashCode ^
      educations.hashCode ^
      skills.hashCode ^
      languages.hashCode ^
      projects.hashCode;
}
