class EducationInfoCardModel {
  final String? level;
  final String? university;
  final String? fieldStudy;
  final String? periodic;
  final String? institution;

  EducationInfoCardModel(
      {this.level,
      this.university,
      this.institution,
      this.fieldStudy,
      this.periodic});

  EducationInfoCardModel copyWith({
    String? level,
    String? university,
    String? fieldStudy,
    String? date,
  }) {
    return EducationInfoCardModel(
      level: level ?? this.level,
      university: university ?? this.university,
      institution: institution ?? this.institution,
      fieldStudy: fieldStudy ?? this.fieldStudy,
      periodic: date ?? this.periodic,
    );
  }

  factory EducationInfoCardModel.fromJson(Map<String, dynamic>? json) {
    return EducationInfoCardModel(
      level: json != null ? json["level"] : "",
      university: json != null ? json["university"] : "",
      institution: json != null ? json["institution"] : "",
      fieldStudy: json != null ? json["fieldStudy"] : "",
      periodic: json != null ? json["date"] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "level": this.level,
      "university": this.university,
      "institution": this.institution,
      "fieldStudy": this.fieldStudy,
      "date": this.periodic,
    };
  }

  @override
  String toString() {
    return 'EducationInfoCardModel{level: $level, university: $university, fieldStudy: $fieldStudy, periodic: $periodic, institution: $institution}';
  }
//
}
