import 'package:jobspot/utils/helper.dart';

/// id : 0
/// job_title : "string"
/// company : "string"
/// start_date : "string"
/// end_date : "string"
/// is_current_job : true
/// description : "string"

class WorkExperiencesModel {
  WorkExperiencesModel({
    this.id,
    this.jobTitle,
    this.company,
    this.startDate,
    this.endDate,
    this.isCurrentJob,
    this.description,
  });

  WorkExperiencesModel.fromJson(Map<String, dynamic> json) {
    print("WorkExperiencesModel.fromJson: $json");
    id = json['id'];
    jobTitle = json['job_title'];
    company = json['company'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    isCurrentJob = json['is_current_job'];
    description = json['description'];
  }

  int? id;
  String? jobTitle;
  String? company;
  String? startDate;
  String? endDate;
  bool? isCurrentJob;
  String? description;

  String? get periodic {
    return "${periodicDateFormatter(startDate)} -"
        " ${periodicDateFormatter(endDate)}";
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "job_title": this.jobTitle,
      "company": this.company,
      "start_date": this.startDate,
      "end_date": this.endDate,
      "is_current_job": this.isCurrentJob,
      "description": this.description,
    };
  }

  Map<String, dynamic> toJsonNonId() {
    return {
      "job_title": this.jobTitle,
      "company": this.company,
      "start_date": this.startDate,
      "end_date": this.endDate,
      "is_current_job": this.isCurrentJob,
      "description": this.description,
    };
  }

  WorkExperiencesModel copyWith({
    int? id,
    String? jobTitle,
    String? company,
    String? startDate,
    String? endDate,
    bool? isCurrentJob,
    String? description,
  }) {
    return WorkExperiencesModel(
      id: id ?? this.id,
      jobTitle: jobTitle ?? this.jobTitle,
      company: company ?? this.company,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isCurrentJob: isCurrentJob ?? this.isCurrentJob,
      description: description ?? this.description,
    );
  }

  @override
  String toString() {
    return 'WorkExperiencesModel{id: $id, jobTitle: $jobTitle, company: $company, startDate: $startDate, endDate: $endDate, isCurrentJob: $isCurrentJob, description: $description}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkExperiencesModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          jobTitle == other.jobTitle &&
          company == other.company &&
          startDate == other.startDate &&
          endDate == other.endDate &&
          isCurrentJob == other.isCurrentJob &&
          description == other.description;

  @override
  int get hashCode =>
      id.hashCode ^
      jobTitle.hashCode ^
      company.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      isCurrentJob.hashCode ^
      description.hashCode;
}
