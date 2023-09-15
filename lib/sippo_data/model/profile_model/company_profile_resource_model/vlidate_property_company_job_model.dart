class ValidatePropCompanyJobModel {
  final List<String>? title;
  final List<String>? description;
  final List<String>? requirements;
  final List<String>? workplaceType;
  final List<String>? longitude;
  final List<String>? latitude;
  final List<String>? employmentType;
  final List<String>? salaryFrom;
  final List<String>? salaryTo;
  final List<String>? experienceLevel;
  final List<String>? specialization;

  const ValidatePropCompanyJobModel({
    this.title,
    this.description,
    this.requirements,
    this.workplaceType,
    this.longitude,
    this.latitude,
    this.employmentType,
    this.salaryFrom,
    this.salaryTo,
    this.experienceLevel,
    this.specialization,
  });

  factory ValidatePropCompanyJobModel.fromJson(Map<String, dynamic> json) {
    return ValidatePropCompanyJobModel(
      title: (json["title"] as List<dynamic>?)?.map((item) => item.toString()).toList() ?? [],
      description: (json["description"] as List<dynamic>?)?.map((item) => item.toString()).toList() ?? [],
      requirements: (json["requirements"] as List<dynamic>?)?.map((item) => item.toString()).toList() ?? [],
      workplaceType: (json["workplace_type"] as List<dynamic>?)?.map((item) => item.toString()).toList() ?? [],
      longitude: (json["longitude"] as List<dynamic>?)?.map((item) => item.toString()).toList() ?? [],
      latitude: (json["latitude"] as List<dynamic>?)?.map((item) => item.toString()).toList() ?? [],
      employmentType: (json["employment_type"] as List<dynamic>?)?.map((item) => item.toString()).toList() ?? [],
      salaryFrom: (json["salary_from"] as List<dynamic>?)?.map((item) => item.toString()).toList() ?? [],
      salaryTo: (json["salary_to"] as List<dynamic>?)?.map((item) => item.toString()).toList() ?? [],
      experienceLevel: (json["experience_level"] as List<dynamic>?)?.map((item) => item.toString()).toList() ?? [],
      specialization: (json["specialization_id"] as List<dynamic>?)?.map((item) => item.toString()).toList() ?? [],
    );
  }
  @override
  String toString() {
    return 'ValidatePropCompanyJobModel{title: $title, description: $description, requirements: $requirements, workplaceType: $workplaceType, longitude: $longitude, latitude: $latitude, employmentType: $employmentType, salaryFrom: $salaryFrom, salaryTo: $salaryTo, experienceLevel: $experienceLevel, specialization: $specialization}';
  }
//
}
