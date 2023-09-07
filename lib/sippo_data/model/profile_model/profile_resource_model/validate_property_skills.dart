class ValidatePropSkillsModel {
  List<String>? skills;

  ValidatePropSkillsModel({this.skills});

  ValidatePropSkillsModel.fromJson(dynamic json) {
    skills = json['skills'] != null ? json['skills'].cast<String>() : [];
  }

  Map<String, dynamic> toJson() => {
        "skills": skills,
      };

  @override
  String toString() {
    return 'ValidatePropSkillsModel{skills: $skills}';
  }
}
