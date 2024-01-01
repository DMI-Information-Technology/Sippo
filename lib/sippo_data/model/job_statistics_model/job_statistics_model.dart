import 'package:sippo/utils/string_formtter.dart';

class JobStatisticsModel {
  JobStatisticsModel({
    this.fullTimeJobs,
    this.partTimeJobs,
    this.remoteJobs,
  });

  factory JobStatisticsModel.fromJson(Map<String, dynamic>? json) {
    return JobStatisticsModel(
      fullTimeJobs: JobStatisticsData(
        count: json?["full_time_jobs"],
        label: 'Full Time',
        type: 'employment_type',
      ),
      partTimeJobs: JobStatisticsData(
        count: json?["part_time_jobs"],
        label: 'Part Time',
        type: 'employment_type',
      ),
      remoteJobs: JobStatisticsData(
        count: json?["remote_jobs"],
        label: 'Remote',
        type: 'workplace_type',
      ),
    );
  }

  final JobStatisticsData? fullTimeJobs;
  final JobStatisticsData? partTimeJobs;
  final JobStatisticsData? remoteJobs;

  JobStatisticsModel copyWith({
    JobStatisticsData? fullTimeJobs,
    JobStatisticsData? partTimeJobs,
    JobStatisticsData? remoteJobs,
  }) =>
      JobStatisticsModel(
        fullTimeJobs: fullTimeJobs ?? this.fullTimeJobs,
        partTimeJobs: partTimeJobs ?? this.partTimeJobs,
        remoteJobs: remoteJobs ?? this.remoteJobs,
      );
}

class JobStatisticsData {
  final String? label;
  final int? count;
  final String? type;

  String? get countString =>
      count != null ? count.toString().shortStringNumberFormat : null;

  const JobStatisticsData({
    this.label,
    this.count,
    this.type,
  });
}
