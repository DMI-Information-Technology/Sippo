import 'package:jobspot/sippo_data/model/auth_model/company_response_details.dart';
import 'package:jobspot/sippo_data/model/salary_model/range_salary_model.dart';
import 'package:jobspot/sippo_data/model/specializations_model/specializations_model.dart';

class CompanyJobModel {
  int? id; // New field
  final CompanyDetailsResponseModel? company; // New field
  final String? title;
  final String? description;
  final String? requirements;
  final String? workplaceType;
  final double? longitude;
  final double? latitude;
  final String? employmentType;
  final double? salaryFrom;
  final double? salaryTo;
  final String? currencyType;
  final ExperienceLevel? experienceLevel;
  final SpecializationModel? specialization;
  final String? createdAt; // New field
  final bool? isExpired; // New field
  final bool? isActive; // New field
  final bool? hasApplied;
  final bool? isSaved;

  CompanyJobModel({
    this.id,
    this.company,
    this.title,
    this.description,
    this.requirements,
    this.workplaceType,
    this.longitude,
    this.latitude,
    this.employmentType,
    this.salaryFrom,
    this.salaryTo,
    this.specialization,
    this.experienceLevel,
    this.createdAt,
    this.isExpired,
    this.isActive,
    this.currencyType,
    this.hasApplied,
    this.isSaved,
  });

  RangeSalaryModel get salaryRange =>
      RangeSalaryModel(from: salaryFrom, to: salaryTo);

  factory CompanyJobModel.fromJson(Map<String, dynamic> json) {
    return CompanyJobModel(
      id: json['id'],
      company: json['company'] != null
          ? CompanyDetailsResponseModel.fromJson(json['company'])
          : null,
      title: json['title'],
      description: json['description'],
      requirements: json['requirements'],
      workplaceType: json['workplace_type'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      employmentType: json['employment_type'],
      salaryFrom: (() {
        final result = json['salary_from'];
        if (result is String && result.runtimeType == String)
          return double.parse(result);
        if (result is num) return result.toDouble();
        return null;
      })(),
      salaryTo: (() {
        final result = json['salary_to'];
        if (result is String && result.runtimeType == String)
          return double.parse(result);
        if (result is num) return result.toDouble();
        return null;
      })(),
      experienceLevel:
          json['experience_level'] != null && json['experience_level'] is Map
              ? ExperienceLevel.fromJson(json['experience_level'])
              : null,
      createdAt: json['created_at'],
      isExpired: json['is_expired'],
      hasApplied: json['has_applied'],
      isActive: json['is_active'],
      specialization:
          json['specialization'] != null && json['specialization'] is Map
              ? SpecializationModel.fromJson(json['specialization'])
              : null,
      isSaved: json['is_saved'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'longitude': longitude,
      'latitude': latitude,
      'requirements': requirements,
      'workplace_type': workplaceType,
      'employment_type': employmentType,
      'salary_from': salaryFrom,
      'salary_to': salaryTo,
      'experience_level': experienceLevel?.value,
      'specialization_id': specialization?.id,
    };
  }

  @override
  String toString() {
    return 'CompanyJobModel{id: $id, title: $title, description: $description, requirements: $requirements, workplaceType: $workplaceType, longitude: $longitude, latitude: $latitude, employmentType: $employmentType, isSaved: $isSaved, salaryFrom: $salaryFrom, salaryTo: $salaryTo, experienceLevel: $experienceLevel, specialization: $specialization, createdAt: $createdAt, isExpired: $isExpired, hasApplied: $hasApplied, isActive: $isActive}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompanyJobModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description &&
          requirements == other.requirements &&
          workplaceType == other.workplaceType &&
          longitude == other.longitude &&
          latitude == other.latitude &&
          employmentType == other.employmentType &&
          salaryFrom == other.salaryFrom &&
          salaryTo == other.salaryTo &&
          isSaved == other.isSaved &&
          isActive == other.isActive &&
          isExpired == other.isExpired &&
          currencyType == other.currencyType &&
          experienceLevel == other.experienceLevel &&
          hasApplied == other.hasApplied &&
          specialization == other.specialization;

  @override
  int get hashCode =>
      id.hashCode ^
      company.hashCode ^
      title.hashCode ^
      description.hashCode ^
      requirements.hashCode ^
      workplaceType.hashCode ^
      longitude.hashCode ^
      latitude.hashCode ^
      employmentType.hashCode ^
      salaryFrom.hashCode ^
      salaryTo.hashCode ^
      currencyType.hashCode ^
      experienceLevel.hashCode ^
      specialization.hashCode ^
      createdAt.hashCode ^
      isExpired.hashCode ^
      hasApplied.hashCode ^
      isSaved.hashCode ^
      isActive.hashCode;

  CompanyJobModel copyWith({
    int? id,
    CompanyDetailsResponseModel? company,
    String? title,
    String? description,
    String? requirements,
    String? workplaceType,
    double? longitude,
    double? latitude,
    String? employmentType,
    double? salaryFrom,
    double? salaryTo,
    String? currencyType,
    ExperienceLevel? experienceLevel,
    SpecializationModel? specialization,
    String? createdAt,
    bool? isExpired,
    bool? isActive,
    bool? isSaved,
    bool? hasApplied,
  }) {
    return CompanyJobModel(
      id: id ?? this.id,
      company: company ?? this.company,
      title: title ?? this.title,
      description: description ?? this.description,
      requirements: requirements ?? this.requirements,
      workplaceType: workplaceType ?? this.workplaceType,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      employmentType: employmentType ?? this.employmentType,
      salaryFrom: salaryFrom ?? this.salaryFrom,
      salaryTo: salaryTo ?? this.salaryTo,
      currencyType: currencyType ?? this.currencyType,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      specialization: specialization ?? this.specialization,
      createdAt: createdAt ?? this.createdAt,
      isExpired: isExpired ?? this.isExpired,
      isActive: isActive ?? this.isActive,
      hasApplied: hasApplied ?? this.hasApplied,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}

class ExperienceLevel {
  final String? label;
  final String? value;

  ExperienceLevel({
    this.label,
    this.value,
  });

  static List<ExperienceLevel>? fromJsonToExperienceLevelList(
      Map<String, dynamic> json) {
    return json.keys
        .map((key) => ExperienceLevel(label: json[key], value: key))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'value': value,
    };
  }

  factory ExperienceLevel.fromJson(Map<String, dynamic> json) {
    return ExperienceLevel(
      label: json["label"]?.toString(),
      value: json["value"]?.toString(),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExperienceLevel &&
          runtimeType == other.runtimeType &&
          label == other.label &&
          value == other.value;

  @override
  int get hashCode => label.hashCode ^ value.hashCode;

  @override
  String toString() {
    return 'ExperienceLevel{label: $label, value: $value}';
  }

//
}
