class ProfessionsUserModel {
  ProfessionsUserModel({
    this.professions,
  });


  List<int>? professions;

  ProfessionsUserModel copyWith({
    List<int>? professions,
  }) =>
      ProfessionsUserModel(
        professions: professions ?? this.professions,
      );

  Map<String, dynamic> toJson() => {'professions': professions};
}

class ValidatePropProfessionsUserModel {
  final List<String>? professions;

  factory ValidatePropProfessionsUserModel.fromJson(Map<String, dynamic> map) {
    return ValidatePropProfessionsUserModel(
      professions:
          List.of(map['professions']).map((e) => e.toString()).toList(),
    );
  }

  const ValidatePropProfessionsUserModel({
    this.professions,
  });
}
