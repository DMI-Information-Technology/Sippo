
/// job_title : ["job title مطلوب."]
/// company : ["company مطلوب."]
/// start_date : ["start date مطلوب."]
/// end_date : ["end date مطلوب."]
/// is_current_job : ["is current job مطلوب."]
/// description : ["الوصف مطلوب."]

class ValidatePropWorkExperiencesModel {
  ValidatePropWorkExperiencesModel({
    this.jobTitle,
    this.company,
    this.startDate,
    this.endDate,
    this.isCurrentJob,
    this.description,
  });

  ValidatePropWorkExperiencesModel.fromJson(Map<String, dynamic> json) {
    jobTitle =
        json['job_title'] != null ? json['job_title'].cast<String>() : [];
    company = json['company'] != null ? json['company'].cast<String>() : [];
    startDate =
        json['start_date'] != null ? json['start_date'].cast<String>() : [];
    endDate = json['end_date'] != null ? json['end_date'].cast<String>() : [];
    isCurrentJob = json['is_current_job'] != null
        ? json['is_current_job'].cast<String>()
        : [];
    description =
        json['description'] != null ? json['description'].cast<String>() : [];
  }

  List<String>? jobTitle;
  List<String>? company;
  List<String>? startDate;
  List<String>? endDate;
  List<String>? isCurrentJob;
  List<String>? description;

  ValidatePropWorkExperiencesModel copyWith({
    List<String>? jobTitle,
    List<String>? company,
    List<String>? startDate,
    List<String>? endDate,
    List<String>? isCurrentJob,
    List<String>? description,
  }) =>
      ValidatePropWorkExperiencesModel(
        jobTitle: jobTitle ?? this.jobTitle,
        company: company ?? this.company,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        isCurrentJob: isCurrentJob ?? this.isCurrentJob,
        description: description ?? this.description,
      );

  Map<String, dynamic> toJson() {
    return {
      "job_title": this.jobTitle,
      "company": this.company,
      "start_date": this.startDate,
      "end_date": this.endDate,
      "is_current_job": this.isCurrentJob,
      "description": this.description,
    };
  }

  @override
  String toString() {
    return 'ValidatePropertyWorkExperiencesModel{jobTitle: $jobTitle, company: $company, startDate: $startDate, endDate: $endDate, isCurrentJob: $isCurrentJob, description: $description}';
  }
}
