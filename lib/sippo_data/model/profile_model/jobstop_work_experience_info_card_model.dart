class WorkExperienceInfoCardModel {
  final String? position;
  final String? company;
  final String? periodic;

  WorkExperienceInfoCardModel({this.position, this.company, this.periodic});

  WorkExperienceInfoCardModel copyWith({
    String? position,
    String? company,
    String? periodic,
  }) {
    return WorkExperienceInfoCardModel(
      position: position ?? this.position,
      company: company ?? this.company,
      periodic: periodic ?? this.periodic,
    );
  }

  @override
  String toString() {
    return 'WorkExperienceInfoCardModel{position: $position, company: $company, periodic: $periodic}';
  }

  Map<String, dynamic> toJson() {
    return {
      "position": this.position,
      "company": this.company,
      "periodic": this.periodic,
    };
  }

  factory WorkExperienceInfoCardModel.fromJson(Map<String, dynamic>? json) {
    return WorkExperienceInfoCardModel(
      position: json != null ? json["position"] : "",
      company: json != null ? json["company"] : "",
      periodic: json != null ? json["periodic"] : "",
    );
  }
//
}
