class SkillsModel {
  SkillsModel({
    this.skills,
  });

  SkillsModel.fromJson(Map<String, dynamic> json) {
    skills = json['skills'] != null ? json['skills'].cast<String>() : [];
  }

  SkillsModel.fromViewJson(Map<String, dynamic> json) {
    final allSkills = json['skills'];
    if (allSkills != null && allSkills is List) {
      skills = allSkills.map((e) => e['skill'].toString()).toList();
    }
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
