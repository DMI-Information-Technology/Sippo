class SkillsModel {
  SkillsModel({
    this.skills,
  });

  SkillsModel.fromJson(Map<String, dynamic> json) {
    skills = json['skills'] != null ? json['skills'].cast<String>() : [];
  }

  List<String>? skills;

  SkillsModel copyWith({
    List<String>? skills,
  }) =>
      SkillsModel(
        skills: skills ?? this.skills,
      );

  Map<String, dynamic> toJson() => {
        'skills': skills,
      };
}
