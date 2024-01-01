import 'package:sippo/utils/helper.dart';

class EducationModel {
  EducationModel({
    this.id,
    this.level,
    this.institution,
    this.field,
    this.startDate,
    this.endDate,
    this.isCurrent,
    this.description,
  });

  EducationModel.fromJson(Map<String, dynamic>? json) {
    id = json?['id'];
    level = json?['level'];
    institution = json?['institution'];
    field = json?['field'];
    startDate = json?['start_date'];
    endDate = json?['end_date'];
    isCurrent = json?['is_current'];
    description = json?['description'];
  }
  String? get periodic {
    return "${periodicDateFormatter(startDate)} -"
        " ${periodicDateFormatter(endDate)}";
  }
  int? id;
  String? level;
  String? institution;
  String? field;
  String? startDate;
  String? endDate;
  bool? isCurrent;
  String? description;

  EducationModel copyWith({
    int? id,
    String? level,
    String? institution,
    String? field,
    String? startDate,
    String? endDate,
    bool? isCurrent,
    String? description,
  }) =>
      EducationModel(
        id: id ?? this.id,
        level: level ?? this.level,
        institution: institution ?? this.institution,
        field: field ?? this.field,
        startDate: field ?? this.startDate,
        endDate: endDate ?? this.endDate,
        isCurrent: isCurrent ?? this.isCurrent,
        description: description ?? this.description,
      );

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "level": this.level,
      "institution": this.institution,
      "field": this.field,
      "start_date": this.startDate,
      "end_date": this.endDate,
      "is_current": this.isCurrent,
      "description": this.description,
    };
  }

  Map<String, dynamic> toJsonNonId() {
    return {
      "level": this.level,
      "institution": this.institution,
      "field": this.field,
      "start_date": this.startDate,
      "end_date": this.endDate,
      "is_current": this.isCurrent,
      "description": this.description,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EducationModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          level == other.level &&
          institution == other.institution &&
          field == other.field &&
          startDate == other.startDate &&
          endDate == other.endDate &&
          isCurrent == other.isCurrent &&
          description == other.description;

  @override
  int get hashCode =>
      id.hashCode ^
      level.hashCode ^
      institution.hashCode ^
      field.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      isCurrent.hashCode ^
      description.hashCode;

  @override
  String toString() {
    return 'EducationModel{id: $id, level: $level, institution: $institution, field: $field, startDate: $startDate, endDate: $endDate, isCurrent: $isCurrent, description: $description}';
  }
}
