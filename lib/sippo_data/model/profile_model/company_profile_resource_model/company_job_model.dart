import 'package:sippo/sippo_data/model/application_model/application_job_company_model.dart';
import 'package:sippo/sippo_data/model/auth_model/company_response_details.dart';
import 'package:sippo/sippo_data/model/salary_model/range_salary_model.dart';
import 'package:sippo/sippo_data/model/specializations_model/specializations_model.dart';

import '../../locations_model/location_address_model.dart';

class CompanyJobModel {
  int? id; // New field
  final CompanyDetailsModel? company; // New field
  final String? title;
  final String? description;
  final String? requirements;
  final String? workplaceType;
  final double? salaryFrom;
  final double? salaryTo;
  final String? employmentType;
  final ExperienceLevel? experienceLevel;
  final SpecializationModel? specialization;
  final double? longitude;
  final double? latitude;
  final String? currencyType;
  final String? createdAt; // New field
  final bool? isExpired; // New field
  final bool? isActive; // New field
  final bool? hasApplied;
  final bool? isSaved;
  final LocationAddress? locationAddress;
  final ApplicationUserModel? application;

  bool get isJobContentBlank => id == null || title == null;

  CompanyJobModel({
    this.id,
    this.company,
    this.title,
    this.description,
    this.requirements,
    this.workplaceType,
    this.longitude,
    this.latitude,
    this.locationAddress,
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
    this.application,
  });

  RangeSalaryModel get salaryRange =>
      RangeSalaryModel(from: salaryFrom, to: salaryTo);

  factory CompanyJobModel.fromJson(Map<String, dynamic>? json) {
    return CompanyJobModel(
      id: json?['id'],
      company: json?['company'] != null
          ? CompanyDetailsModel.fromJson(json?['company'])
          : null,
      title: json?['title'],
      description: json?['description'],
      requirements: json?['requirements'],
      workplaceType: json?['workplace_type'],
      longitude:
          json?['longitude'] != null ? (json?['longitude'] ?? 0) * 1.0 : null,
      latitude:
          json?['longitude'] != null ? (json?['latitude'] ?? 0) * 1.0 : null,
      locationAddress: json?['location'] != null
          ? LocationAddress.fromJson(json?['location'])
          : null,
      employmentType: json?['employment_type'],
      salaryFrom: (() {
        final result = json?['salary_from'];

        return switch (result) {
          String() => double.parse(result),
          int() || num() => result.toDouble(),
          _ => null
        };
      })(),
      salaryTo: (() {
        final result = json?['salary_to'];
        return switch (result) {
          String() => double.parse(result),
          int() || num() => result.toDouble(),
          _ => null
        };
      })(),
      experienceLevel:
          json?['experience_level'] != null && json?['experience_level'] is Map
              ? ExperienceLevel.fromJson(json?['experience_level'])
              : null,
      createdAt: json?['created_at'],
      isExpired: json?['is_expired'],
      hasApplied: json?['has_applied'],
      isActive: json?['is_active'],
      specialization:
          json?['specialization'] != null && json?['specialization'] is Map
              ? SpecializationModel.fromJson(json?['specialization'])
              : null,
      isSaved: json?['is_saved'],
      application: json?['application'] != null
          ? ApplicationUserModel.fromJson(json?['application'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'longitude': longitude,
      'latitude': latitude,
      'location_id': locationAddress?.id,
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
    return 'CompanyJobModel{id: $id, title: $title, description: $description, requirements: $requirements, workplaceType: $workplaceType, longitude: $longitude, latitude: $latitude, location: $locationAddress, employmentType: $employmentType, isSaved: $isSaved, salaryFrom: $salaryFrom, salaryTo: $salaryTo, experienceLevel: $experienceLevel, specialization: $specialization, createdAt: $createdAt, isExpired: $isExpired, hasApplied: $hasApplied, isActive: $isActive}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompanyJobModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          company == other.company &&
          title == other.title &&
          description == other.description &&
          requirements == other.requirements &&
          workplaceType == other.workplaceType &&
          salaryFrom == other.salaryFrom &&
          salaryTo == other.salaryTo &&
          employmentType == other.employmentType &&
          experienceLevel == other.experienceLevel &&
          specialization == other.specialization &&
          longitude == other.longitude &&
          latitude == other.latitude &&
          currencyType == other.currencyType &&
          createdAt == other.createdAt &&
          isExpired == other.isExpired &&
          isActive == other.isActive &&
          hasApplied == other.hasApplied &&
          isSaved == other.isSaved &&
          locationAddress == other.locationAddress &&
          application == other.application;

  @override
  int get hashCode =>
      id.hashCode ^
      company.hashCode ^
      title.hashCode ^
      description.hashCode ^
      requirements.hashCode ^
      workplaceType.hashCode ^
      salaryFrom.hashCode ^
      salaryTo.hashCode ^
      employmentType.hashCode ^
      experienceLevel.hashCode ^
      specialization.hashCode ^
      longitude.hashCode ^
      latitude.hashCode ^
      currencyType.hashCode ^
      createdAt.hashCode ^
      isExpired.hashCode ^
      isActive.hashCode ^
      hasApplied.hashCode ^
      isSaved.hashCode ^
      locationAddress.hashCode ^
      application.hashCode;

  CompanyJobModel copyWith({
    int? id,
    CompanyDetailsModel? company,
    String? title,
    String? description,
    String? requirements,
    String? workplaceType,
    double? salaryFrom,
    double? salaryTo,
    String? employmentType,
    ExperienceLevel? experienceLevel,
    SpecializationModel? specialization,
    double? longitude,
    double? latitude,
    String? currencyType,
    String? createdAt,
    bool? isExpired,
    bool? isActive,
    bool? hasApplied,
    bool? isSaved,
    LocationAddress? locationAddress,
    ApplicationUserModel? application,
  }) {
    return CompanyJobModel(
      id: id ?? this.id,
      company: company ?? this.company,
      title: title ?? this.title,
      description: description ?? this.description,
      requirements: requirements ?? this.requirements,
      workplaceType: workplaceType ?? this.workplaceType,
      salaryFrom: salaryFrom ?? this.salaryFrom,
      salaryTo: salaryTo ?? this.salaryTo,
      employmentType: employmentType ?? this.employmentType,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      specialization: specialization ?? this.specialization,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      currencyType: currencyType ?? this.currencyType,
      createdAt: createdAt ?? this.createdAt,
      isExpired: isExpired ?? this.isExpired,
      isActive: isActive ?? this.isActive,
      hasApplied: hasApplied ?? this.hasApplied,
      isSaved: isSaved ?? this.isSaved,
      locationAddress: locationAddress ?? this.locationAddress,
      application: application ?? this.application,
    );
  }

  CompanyJobModel copyForEdit({
    int? id,
    String? title,
    String? description,
    String? requirements,
    String? workplaceType,
    double? salaryFrom,
    double? salaryTo,
    String? employmentType,
    ExperienceLevel? experienceLevel,
    SpecializationModel? specialization,
    double? longitude,
    double? latitude,
    String? currencyType,
    String? createdAt,
    bool? isExpired,
    bool? isActive,
    bool? hasApplied,
    LocationAddress? locationAddress,
    ApplicationUserModel? application,
  }) {
    return CompanyJobModel(
      id: id ?? this.id,
      company: null,
      title: title ?? this.title,
      description: description ?? this.description,
      requirements: requirements ?? this.requirements,
      workplaceType: workplaceType ?? this.workplaceType,
      salaryFrom: salaryFrom ?? this.salaryFrom,
      salaryTo: salaryTo ?? this.salaryTo,
      employmentType: employmentType ?? this.employmentType,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      specialization: specialization ?? this.specialization,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      currencyType: currencyType ?? this.currencyType,
      createdAt: createdAt ?? this.createdAt,
      isExpired: isExpired ?? this.isExpired,
      isActive: isActive ?? this.isActive,
      hasApplied: hasApplied ?? this.hasApplied,
      isSaved: null,
      locationAddress: locationAddress ?? this.locationAddress,
      application: application ?? this.application,
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
