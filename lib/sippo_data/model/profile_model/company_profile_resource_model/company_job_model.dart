import 'package:jobspot/sippo_data/model/auth_model/company_response_details.dart';
import 'package:jobspot/sippo_data/model/specializations_model/specializations_model.dart';

class JobPosting {
  final int? id; // New field
  final CompanyResponseDetailsModel? company; // New field
  final String? title;
  final String? description;
  final String? requirements;
  final String? workplaceType;
  final double? longitude;
  final double? latitude;
  final String? employmentType;
  final String? salaryFrom;
  final String? salaryTo;
  final ExperienceLevel? experienceLevel;
  final SpecializationModel? specialization;
  final DateTime? createdAt; // New field
  final bool? isExpired; // New field
  final bool? isActive; // New field

  JobPosting({
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
  });

  factory JobPosting.fromJson(Map<String, dynamic> json) {
    return JobPosting(
      id: json['id'],
      company: json['company'] != null
          ? CompanyResponseDetailsModel.fromJson(json['company'])
          : null,
      title: json['title'],
      description: json['description'],
      requirements: json['requirements'],
      workplaceType: json['workplace_type'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      employmentType: json['employment_type'],
      salaryFrom: json['salary_from'],
      salaryTo: json['salary_to'],
      experienceLevel: json['experience_level'] != null
          ? ExperienceLevel.fromJson(json['experience_level'])
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      isExpired: json['is_expired'],
      isActive: json['is_active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'requirements': requirements,
      'workplace_type': workplaceType,
      'longitude': longitude,
      'latitude': latitude,
      'employment_type': employmentType,
      'salary_from': salaryFrom,
      'salary_to': salaryTo,
      'experience_level': experienceLevel?.value,
      'specialization_id': specialization?.id,
    };
  }
}

class ExperienceLevel {
  final String? label;
  final int? value;

  ExperienceLevel({
    this.label,
    this.value,
  });

  factory ExperienceLevel.fromJson(Map<String, dynamic> json) {
    return ExperienceLevel(
      label: json['label'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'value': value,
    };
  }
}
