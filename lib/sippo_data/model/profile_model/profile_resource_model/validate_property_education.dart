class ValidatePropEducationModel {
  ValidatePropEducationModel({
    this.level,
    this.institution,
    this.startDate,
    this.endDate,
    this.field,
    this.isCurrent,
    this.description,
  });


  List<String>? level;
  List<String>? institution;
  List<String>? startDate;
  List<String>? endDate;
  List<String>? field;
  List<String>? isCurrent;
  List<String>? description;

  ValidatePropEducationModel copyWith({
    List<String>? level,
    List<String>? institution,
    List<String>? startDate,
    List<String>? endDate,
    List<String>? field,
    List<String>? isCurrent,
    List<String>? description,
  }) =>
      ValidatePropEducationModel(
        level: level ?? this.level,
        institution: institution ?? this.institution,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        field: field ?? this.field,
        isCurrent: isCurrent ?? this.isCurrent,
        description: description ?? this.description,
      );

  Map<String, dynamic> toJson() {
    return {
      'level': this.level,
      'institution': this.institution,
      'start_date': this.startDate,
      'end_date': this.endDate,
      'field': this.field,
      'is_current': this.isCurrent,
      'description': this.description,
    };
  }

  factory ValidatePropEducationModel.fromJson(Map<String, dynamic> map) {
    return ValidatePropEducationModel(
      level: map['level'] != null ? map['level'].cast<String>() : [],
      institution: map['institution'] != null ? map['institution'].cast<String>() : [],
      startDate: map['start_date'] != null ? map['start_date'].cast<String>() : [],
      endDate: map['end_date'] != null ? map['end_date'].cast<String>() : [],
      field: map['field'] != null ? map['field'].cast<String>() : [],
      isCurrent: map['is_current'] != null ? map['is_current'].cast<String>() : [],
      description: map['description'] != null ? map['description'].cast<String>() : [],
    );
  }

  @override
  String toString() {
    return 'ValidatePropEducationModel{level: $level, institution: $institution, startDate: $startDate, endDate: $endDate, field: $field, isCurrent: $isCurrent, description: $description}';
  }
}
